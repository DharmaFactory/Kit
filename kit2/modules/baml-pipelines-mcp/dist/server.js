import "dotenv/config";
import "dotenv/config";
import { fileURLToPath } from "node:url";
import * as path from "node:path";
import { logger } from "./logger.js";
import { PipelineRegistry } from "./registry.js";
import { executePipeline } from "./executor.js";
// Resolve registry path relative to modules directory if env not set
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const registryPath = process.env.BAML_PIPELINES_REGISTRY_PATH ??
    path.resolve(__dirname, "../baml-openrouter/PIPELINES.registry");
const registry = new PipelineRegistry(registryPath);
// Heuristic: require at least this many characters of context
const MIN_CONTEXT_CHARS = Number(process.env.BAML_MIN_CONTEXT_CHARS ?? "2000");
function send(response) {
    process.stdout.write(JSON.stringify(response) + "\n");
}
function getToolsDescription() {
    return [
        {
            name: "baml.run_pipeline",
            description: "Execute a registered BAML pipeline with high-context input for external models.",
            inputSchema: {
                type: "object",
                properties: {
                    pipeline: {
                        type: "string",
                        description: "Pipeline name from PIPELINES.registry"
                    },
                    context: {
                        type: "string",
                        description: "Rich narrative context: situation, goal, constraints, what has been tried. Calls with thin context will be rejected.",
                        minLength: MIN_CONTEXT_CHARS
                    },
                    payload: {
                        type: "object",
                        description: "Pipeline-specific JSON payload (see PIPELINES.registry)",
                        additionalProperties: true
                    },
                    options: {
                        type: "object",
                        properties: {
                            timeout_ms: {
                                type: "number",
                                description: "Max execution time in ms"
                            },
                            dry_run: {
                                type: "boolean",
                                description: "If true, only validate pipeline+context; do not execute."
                            },
                            backend: {
                                type: "string",
                                enum: ["auto", "baml_client", "script"],
                                description: "Backend selection (default: script)"
                            }
                        },
                        additionalProperties: false
                    }
                },
                required: ["pipeline", "context", "payload"],
                additionalProperties: false
            }
        }
    ];
}
async function handleRequest(req) {
    const { id = null, method, params } = req;
    if (method === "ping") {
        return send({ jsonrpc: "2.0", id, result: { ok: true } });
    }
    if (method === "tools/list" || method === "mcp/tools/list") {
        return send({
            jsonrpc: "2.0",
            id,
            result: {
                tools: getToolsDescription(),
                meta: {
                    pipelines: registry.list()
                }
            }
        });
    }
    if (method === "tools/call" || method === "mcp/tools/call") {
        const { name, arguments: args } = params ?? {};
        if (name !== "baml.run_pipeline") {
            return send({
                jsonrpc: "2.0",
                id,
                error: {
                    code: -32601,
                    message: `Unknown tool '${name}'`
                }
            });
        }
        const { pipeline, context, payload, options } = args ?? {};
        if (!pipeline || typeof pipeline !== "string") {
            return send({
                jsonrpc: "2.0",
                id,
                error: {
                    code: -32602,
                    message: "Missing or invalid 'pipeline'"
                }
            });
        }
        if (!context || typeof context !== "string") {
            return send({
                jsonrpc: "2.0",
                id,
                error: {
                    code: -32602,
                    message: "Missing 'context' string"
                }
            });
        }
        if (context.trim().length < MIN_CONTEXT_CHARS) {
            logger.warn("Context too sparse for outbound call", {
                pipeline,
                context_length: context.trim().length,
                min_required: MIN_CONTEXT_CHARS
            });
            return send({
                jsonrpc: "2.0",
                id,
                error: {
                    code: 422,
                    message: "Context too sparse. Provide a rich description (situation, goal, constraints, tried).",
                    data: {
                        code: "context_too_sparse",
                        min_context_chars: MIN_CONTEXT_CHARS
                    }
                }
            });
        }
        if (payload === undefined || typeof payload !== "object") {
            return send({
                jsonrpc: "2.0",
                id,
                error: {
                    code: -32602,
                    message: "Missing or invalid 'payload' object"
                }
            });
        }
        try {
            const execResult = await executePipeline(registry, {
                pipeline,
                payload,
                options
            });
            if (!execResult.ok) {
                return send({
                    jsonrpc: "2.0",
                    id,
                    error: {
                        code: -32000,
                        message: execResult.error || "Pipeline execution failed",
                        data: execResult.meta
                    }
                });
            }
            return send({
                jsonrpc: "2.0",
                id,
                result: {
                    ok: true,
                    pipeline,
                    result: execResult.result,
                    meta: execResult.meta
                }
            });
        }
        catch (err) {
            logger.error("Unhandled server error", {
                pipeline,
                error: err.message
            });
            return send({
                jsonrpc: "2.0",
                id,
                error: {
                    code: -32603,
                    message: "Internal error",
                    data: { message: err.message }
                }
            });
        }
    }
    if (id !== null) {
        send({
            jsonrpc: "2.0",
            id,
            error: {
                code: -32601,
                message: `Unknown method '${method}'`
            }
        });
    }
}
function start() {
    logger.info("Starting BAML Pipelines MCP server", {
        registryPath,
        min_context_chars: MIN_CONTEXT_CHARS
    });
    let buffer = "";
    process.stdin.setEncoding("utf8");
    process.stdin.on("data", chunk => {
        buffer += chunk;
        let idx;
        while ((idx = buffer.indexOf("\n")) >= 0) {
            const line = buffer.slice(0, idx).trim();
            buffer = buffer.slice(idx + 1);
            if (!line)
                continue;
            try {
                const msg = JSON.parse(line);
                void handleRequest(msg);
            }
            catch (err) {
                logger.error("Failed to parse JSON-RPC message", {
                    line,
                    error: err.message
                });
            }
        }
    });
    process.stdin.on("end", () => {
        logger.info("Stdin closed, exiting");
        process.exit(0);
    });
}
start();
