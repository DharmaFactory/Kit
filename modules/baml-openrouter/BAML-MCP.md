# BAML Pipelines MCP Server — Design

Status: draft
Owner: Forge Codex

## 1. Intent

Provide a single, simple MCP tool that:
- Wraps existing BAML pipelines (and future external "AI friends").
- Forces rich context (roughly >= 2k tokens) for all outbound calls.
- Keeps pipelines discoverable via `PIPELINES.registry`.
- Stays small enough that any agent can understand and extend it.

This server is for agents like Forge Codex / OpenCode that are context-rich, calling out to tools that are not.

## 2. Tool Interface

Tool name:
- `baml.run_pipeline`

Input schema:
- `pipeline` (string, required)
  - Must match a name declared in `PIPELINES.registry`.
- `context` (string, required)
  - Narrative blob for the callee:
    - Situation / background
    - Objective / question
    - Constraints / guardrails
    - What has already been tried
  - Server enforces a minimum length heuristic (see §3).
- `payload` (object, required)
  - Structured JSON the target pipeline expects (per `PIPELINES.registry`).
- `options` (object, optional):
  - `timeout_ms` (number)
  - `dry_run` (boolean)
  - `backend` ("auto" | "baml_client" | "script")

Output:
- Success:
  - `ok: true`
  - `pipeline: string`
  - `result: any` (pipeline-specific JSON)
  - `meta: { duration_ms, backend }`
- Error:
  - `ok: false`
  - `error: string`
  - `meta: { code, details? }`

## 3. Context Heuristic (Hard Gate)

Outside tools are not running with the same repo/log/persona view. They need full context in-band.

Enforcement:
- Minimum context length (configurable, default ~2k characters as a proxy for ~400 tokens; can tune upward).
- Additionally encourage structure via recommended markers (not hard-required by parser):
  - `Context:`
  - `Goal:`
  - `Constraints:`
  - `Tried:`

If `context` is too short or obviously vague (e.g. "help", "analyze this"):
- Server returns `ok: false`, `meta.code = "context_too_sparse"`.
- This is deliberate pressure on the caller (agent) to think and to surface repo/log state.

## 4. Registry & Extensibility

Source of truth:
- `kit2/modules/baml-openrouter/PIPELINES.registry`

Server behavior:
- On start, load `PIPELINES.registry` and extract valid pipeline names.
- Reject any `pipeline` not in the registry.

Extensibility:
- Add pipelines by updating BAML definitions + `PIPELINES.registry`, then restart.
- Future: support a JSON `module.manifest` file without changing the public tool schema.
- Backends are pluggable inside the server (no surface change):
  - `baml_client` (preferred)
  - `script` (e.g. existing `npm run pipeline`)

## 5. Implementation Notes

Location:
- `kit2/modules/baml-pipelines-mcp/`
  - `package.json`
  - `tsconfig.json`
  - `mcp.json`
  - `src/logger.ts` — JSONL to stderr
  - `src/registry.ts` — reads `PIPELINES.registry`
  - `src/executor.ts` — calls BAML client / script
  - `src/server.ts` — MCP JSON-RPC over stdio

Behavior:
- `tools/list`:
  - Advertise `baml.run_pipeline` with schema above.
  - Include a list of known pipelines + short descriptions from `PIPELINES.registry`.
- `tools/call` (`baml.run_pipeline`):
  - Validate `pipeline` against registry.
  - Validate `context` against length heuristic.
  - If `dry_run`, only validate and return `ok: true, meta.dry_run`.
  - Else execute via executor (respecting `timeout_ms`, `backend`).
  - Log invocation (ts, pipeline, context_length, backend, ok/error).

## 6. Usage Examples

Good call:

```json
{
  "pipeline": "DeepDive",
  "context": "Refactoring kit2 modules to support third-party plugins. Goal: choose a discovery mechanism that is simple, git-native, and agent-readable. Constraints: no external DB, no heavy services, must be compatible with PIPELINES.registry + manifests. Tried: naive convention-only, central JSON registry; need deeper trade-off analysis.",
  "payload": {
    "topic": "Module discovery mechanism for kit2",
    "context": "Extensible agent modules, repo-local metadata, third-party contributions",
    "focus": "Maintainability, clarity for agents, low operational overhead"
  },
  "options": {
    "timeout_ms": 30000
  }
}
```

Bad (rejected):

```json
{
  "pipeline": "DeepDive",
  "context": "help",
  "payload": { "topic": "the project" }
}
```

Server returns `context_too_sparse` and does not call out.

---

This document is the binding contract: future agents must treat `baml.run_pipeline` as a high-context, high-discipline gateway to external compute, not a fire-and-forget convenience.
