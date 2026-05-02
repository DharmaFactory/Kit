function log(level, message, data) {
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
    debug: (m, d) => log("debug", m, d),
    info: (m, d) => log("info", m, d),
    warn: (m, d) => log("warn", m, d),
    error: (m, d) => log("error", m, d)
};
