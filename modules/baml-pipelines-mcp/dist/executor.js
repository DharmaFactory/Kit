import { spawn } from "node:child_process";
import * as path from "node:path";
import { logger } from "./logger.js";
// Backend A: use npm run pipeline (baml-openrouter CLI).
async function runWithScript(pipeline, payload, timeoutMs) {
    const moduleRoot = process.env.BAML_MODULE_ROOT ??
        path.resolve(__dirname, "../../baml-openrouter");
    const cmd = "npm";
    const args = [
        "run",
        "pipeline",
        "--",
        "--pipeline",
        pipeline,
        "--input",
        JSON.stringify(payload)
    ];
    logger.info("Spawning baml-openrouter pipeline", { moduleRoot, cmd, args });
    return new Promise((resolve, reject) => {
        const child = spawn(cmd, args, {
            cwd: moduleRoot,
            stdio: ["ignore", "pipe", "pipe"]
        });
        let stdout = "";
        let stderr = "";
        child.stdout.on("data", (chunk) => {
            stdout += chunk.toString();
        });
        child.stderr.on("data", (chunk) => {
            stderr += chunk.toString();
        });
        let timer;
        if (timeoutMs && timeoutMs > 0) {
            timer = setTimeout(() => {
                logger.warn("Pipeline script timeout, killing", { pipeline });
                child.kill("SIGKILL");
                reject(new Error("Pipeline execution timed out"));
            }, timeoutMs);
        }
        child.on("close", code => {
            if (timer)
                clearTimeout(timer);
            if (code !== 0) {
                logger.error("Pipeline script failed", { pipeline, code, stderr });
                return reject(new Error(`Pipeline '${pipeline}' failed with code ${code}: ${stderr}`));
            }
            const text = stdout.trim();
            if (!text)
                return resolve(null);
            try {
                const parsed = JSON.parse(text);
                return resolve(parsed);
            }
            catch {
                // CLI prints pretty JSON; if parse fails, return raw text.
                logger.warn("Non-JSON pipeline output, returning raw text", {
                    pipeline
                });
                return resolve(text);
            }
        });
    });
}
export async function executePipeline(registry, args) {
    const { pipeline, payload, options } = args;
    const backend = options?.backend ?? "script"; // default: script, since it's wired
    const timeoutMs = options?.timeout_ms;
    registry.assertAllowed(pipeline);
    if (options?.dry_run) {
        return {
            ok: true,
            meta: { dry_run: true }
        };
    }
    const started = Date.now();
    try {
        let result;
        // For now, both auto and script use the CLI backend.
        if (backend === "script" || backend === "auto" || backend === "baml_client") {
            result = await runWithScript(pipeline, payload, timeoutMs);
        }
        else {
            throw new Error(`Unsupported backend: ${backend}`);
        }
        const duration_ms = Date.now() - started;
        return { ok: true, result, meta: { backend: "script", duration_ms } };
    }
    catch (err) {
        const duration_ms = Date.now() - started;
        logger.error("Pipeline execution error", {
            pipeline,
            error: err.message,
            duration_ms
        });
        return {
            ok: false,
            error: err.message,
            meta: { backend, duration_ms }
        };
    }
}
