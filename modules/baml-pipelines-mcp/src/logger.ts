export type LogLevel = "debug" | "info" | "warn" | "error";

function log(level: LogLevel, message: string, data?: any) {
  const entry = {
    ts: new Date().toISOString(),
    level,
    message,
    ...(data ? { data } : {})
  };
  // Stderr only; keep stdout clean for MCP protocol
  process.stderr.write(JSON.stringify(entry) + "\n");
}

export const logger = {
  debug: (m: string, d?: any) => log("debug", m, d),
  info: (m: string, d?: any) => log("info", m, d),
  warn: (m: string, d?: any) => log("warn", m, d),
  error: (m: string, d?: any) => log("error", m, d)
};
