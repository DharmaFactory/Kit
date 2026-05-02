import * as fs from "node:fs";
import { logger } from "./logger.js";
export class PipelineRegistry {
    constructor(registryPath) {
        this.registryPath = registryPath;
        this.pipelines = new Set();
        this.load();
    }
    load() {
        try {
            const content = fs.readFileSync(this.registryPath, "utf8");
            const names = [];
            // Very simple heuristic: look for lines starting with "### " as pipeline names.
            // This matches PIPELINES.registry sections like "### DeepDive".
            for (const line of content.split(/\r?\n/)) {
                const trimmed = line.trim();
                if (trimmed.startsWith("### ")) {
                    const name = trimmed.slice(4).trim();
                    if (name)
                        names.push(name);
                }
            }
            this.pipelines = new Set(names);
            logger.info("Loaded pipelines from registry", {
                registryPath: this.registryPath,
                count: names.length,
                names
            });
        }
        catch (err) {
            logger.error("Failed to load PIPELINES.registry", {
                registryPath: this.registryPath,
                error: err.message
            });
            this.pipelines = new Set();
        }
    }
    list() {
        return Array.from(this.pipelines);
    }
    has(name) {
        return this.pipelines.has(name);
    }
    assertAllowed(name) {
        if (!this.has(name)) {
            const available = this.list();
            const error = new Error(`Pipeline '${name}' is not registered. Available: ${available.join(", ")}`);
            error.code = "NOT_FOUND";
            error.available = available;
            throw error;
        }
    }
}
