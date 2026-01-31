import * as fs from "node:fs";
import * as path from "node:path";
import { logger } from "./logger.js";

export class PipelineRegistry {
  private pipelines = new Set<string>();

  constructor(private registryPath: string) {
    this.load();
  }

  private load() {
    try {
      const content = fs.readFileSync(this.registryPath, "utf8");
      const names: string[] = [];

      // Very simple heuristic: look for lines starting with "### " as pipeline names.
      // This matches PIPELINES.registry sections like "### DeepDive".
      for (const line of content.split(/\r?\n/)) {
        const trimmed = line.trim();
        if (trimmed.startsWith("### ")) {
          const name = trimmed.slice(4).trim();
          if (name) names.push(name);
        }
      }

      this.pipelines = new Set(names);
      logger.info("Loaded pipelines from registry", {
        registryPath: this.registryPath,
        count: names.length,
        names
      });
    } catch (err: any) {
      logger.error("Failed to load PIPELINES.registry", {
        registryPath: this.registryPath,
        error: err.message
      });
      this.pipelines = new Set();
    }
  }

  list(): string[] {
    return Array.from(this.pipelines);
  }

  has(name: string): boolean {
    return this.pipelines.has(name);
  }

  assertAllowed(name: string) {
    if (!this.has(name)) {
      const available = this.list();
      const error: any = new Error(
        `Pipeline '${name}' is not registered. Available: ${available.join(", ")}`
      );
      error.code = "NOT_FOUND";
      error.available = available;
      throw error;
    }
  }
}
