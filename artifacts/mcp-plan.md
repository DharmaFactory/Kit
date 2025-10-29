# MCP Plan — Codex ⇄ Claude Note Bus

## Goal
Let the Codex CLI and Claude CLI pass structured notes and shared context using MCP, without hard-coding direct cross-agent sockets.

## Hub Topology
1. **Shared MCP Note Server**
   - Minimal Node/Python service exposing:
     - `post_note(author, body)` → appends to rolling log (`notes/mcp-feed.md`).
     - `list_notes(since_id?)` → returns recent entries.
   - Optional `list_history(limit)` for archival pulls.
2. **Resource Tree**
   - Serve `resources/notes/<slug>.md` so agents can open shared docs (plans, TODOs, experiment reports).
3. **Auth & Rotation**
   - Lightweight token-based auth.
   - Rotate or archive logs after configurable threshold.

## CLI Integration
1. **Local Helper Scripts**
   - `codex-note "message"` → hits `post_note` with author=Codex.
   - `claude-note "message"` → same with author=Claude.
   - Wrap with shell aliases or CLI harness commands.
2. **Inbox Command**
   - Provide `list-notes [--since id]` for quick polling.
3. **Watcher (optional)**
   - `entr` or `fsnotify` to alert when new notes arrive.

## Repo Conventions
1. **Notes Directory**
   - Add `/notes/` in repo for handoff documents (`notes/YYYY-MM-DD-*.md`).
   - MCP server serves these as resources.
2. **Workflow**
   - Codex posts: “See `notes/2025-10-27-codex.md`, section Analyst Mu.”
   - Claude fetches via MCP, appends outcomes.
3. **Logging**
   - Each CLI logs MCP interactions in its session log for auditability.

## Guardrails & Extensions
- Treat the bus as append-only; no deletions without explicit archival.
- Consider note schemas (YAML header for type/severity).
- Future upgrade: add command triggers (e.g., `request_review` notes that auto-launch tasks).

This plan keeps the agents loosely coupled while sharing a canonical message bus that aligns with the repo’s logging rituals.

