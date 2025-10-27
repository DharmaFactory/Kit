# Logging Protocol — Forge Codex Memory Loop

> Objective: keep Forge Codex coherent across discontinuous sessions by capturing decisions, context, and open loops as they happen.

---

## Dual Read Mode

- **Operator:** This is your ritual manual—run it straight and you’ll always know where the work left off.
- **Agent:** Treat every bullet as a runtime check on your own memory loop; the text describes how to narrate yourself.

### Quotation Stack Map for Logs

- **Single quotes (`'context`)** — Capture what happened without interpretation. Use in Context and quick observations.
- **Double quotes (`"plan")`** — Note the why and how; Decisions and Next steps live here.
- **Triple backticks (three-backtick blocks)** — Preserve executable artifacts: commands, prompts, code, or transcripts that future sessions can replay.

Annotate the layer whenever it isn’t obvious. Council tags (#action, #memory, etc.) are live metadata—treat them as signals the next run will parse, not decorative hashtags.

---

## 1. Files & Structure

- Daily session logs live in `logs/YYYY-MM-DD.md`. Create one file per active day.  
- `logs/session-template.md` supplies the scaffold; copy it at session start.  
- Optional support files (only if needed later):
  - `logs/patterns.md` for recurring insights.
  - `logs/decisions.md` for cross-day canonical decisions.

Keep everything in plain markdown so it is diff-friendly.

---

## 2. Session Logging Ritual

### Before work begins
1. Read the latest log entry; highlight outstanding tasks/questions and note which quotation layers they occupy (data, story, executable).
2. Duplicate the session template and fill in:
   - Participant roster.
   - Objective for this session.
   - Prior state (link back to the previous log + open tasks).
   - *Quick mode:* For rapid tasks, create a stub with Context + Actions + Next only; expand if scope increases.
3. Open with a `Bash prompt` check if helpful: note the command you just ran to boot (usually `load .bootstrap`) so the next session sees the runtime you spawned from.

### During the session
- Append to **Actions Taken** as each material task completes and tag entries with Council markers (#action, #witness, #memory, #containment) when it clarifies the role of the note.
- Log decisions immediately with rationale + alternatives; do not wait for the end. Pair substantive claims with dual anchors (file paths, commands, commit hashes).
- Note which quotation layer each entry reflects if it’s ambiguous (e.g., data observation vs. narrative interpretation vs. executable snippet).
- Note failures or surprises in **Learnings** as they occur, including anchors for replication.
- If you perform experiments (A/B tests, bootstrap dry-runs), add dedicated sub-sections under the log with bullet results and mark them with `#experiment`.

### At wrap-up
1. Update **Next Session** checklist with remaining work and questions.  
2. List all created or modified artifacts with repository paths. Use code fences for anything the next session should be able to copy/paste and run.
3. Run a stack sanity check: confirm the log ends with a clear pointer from data → interpretation → executable next action.
4. Record optional metrics (duration, completeness, energy) if helpful.
   - *Quick mode:* If work stayed small, a single bullet for outcome + next is acceptable.

Close with `**End of session.**`

---

## 3. What Must Be Captured

1. **Decisions + rationale + alternatives** — ensures future you knows why a path was chosen.  
2. **Failures / blocked attempts** — prevents repetition and documents risk.  
3. **Open tasks + questions** — feed directly into the next session plan.  
4. **Artifacts** — file paths, scripts, or commands produced.  
5. **Experiments / validations** — especially any A/B comparisons or bootstrap acknowledgements.

Optional but encouraged:
- Patterns or lessons learned.
- Notes about tone/cadence adjustments to evaluate against persona acceptance tests.
- A quick note on which quotation layer the entry primarily lives in (data, narrative, executable) when it isn’t obvious.

---

## 4. Tagging & Searchability

Use lightweight inline hashtags when helpful. Treat them as metadata the next run will parse, not decoration:
- Council tags: `#action`, `#witness`, `#memory`, `#containment`.
- Additional utility tags: `#decision`, `#failure`, `#question`, `#next`, `#pattern`, `#experiment`.

Tags should complement the structured sections, not replace them.

---

## 5. Handoff & Multi-Agent Scenarios

If additional agents join:
- Add subsections labelled `### [Agent/Role] Entry` inside **Actions Taken** or **Decisions Made**.
- For handoffs, include a bullet list:
  - **Completed**
  - **Current status**
  - **Next steps**
  - **Questions**

Always reference the persona and cognitive stack to keep tone consistent across agents.

---

## 6. Quality Checks

- Can a cold start recover context within two minutes by reading the latest log?  
  - If no, add more detail next time.  
- Does every major change point to at least two anchors (file, command, commit) or explicitly flag uncertainty?  
- Are open questions explicit enough to prompt action without re-reading the entire log history?

If the answer to any check is “no,” amend the log before closing the session.

---

## 7. Log Compaction Ritual

**When to run:** A daily log has grown unwieldy and you’re ready to collapse detail into a tighter summary, or you’ve been explicitly asked to compact today’s entry.

**Guardrail:** Preserve the high-resolution version in git *before* editing it down.

**Procedure:**
1. `git status --short` — Ensure only the files you intend to compact are dirty. If other work is in flight, finish or commit it first.
2. Commit the detailed log snapshot. Example:
   ```bash
   git add logs/YYYY-MM-DD.md
   git commit -m "log: detailed YYYY-MM-DD session"
   ```
   Capture the resulting commit hash (`DETAIL_COMMIT`) for reference.
3. In the log you’re compacting, add a Compaction note (see template) referencing `DETAIL_COMMIT` so anybody can resurrect the full version.
4. Rewrite sections into summary form. Maintain quotation-layer cues—data bullets stay in the `'` lane, narrative reasoning in `"`, executable artifacts in fenced blocks.
5. `git status --short` again to confirm only the intended summary edits remain. If satisfied, commit the compacted version with a message such as `log: compact 2025-10-27 session` and include `DETAIL_COMMIT` in the body.
6. Update the current session log (or README) to note that compaction occurred and where to find the detailed commit.

If you cannot create commits (e.g., read-only mode), record that limitation in the log and defer compaction.

---

## 8. Fail-Safe

When uncertainty spikes and logging clarity is at risk:
1. Pause work.
2. Capture what is known, what is unknown, and the decision point that triggered uncertainty.
3. Ask the human for clarification.
4. Only resume after updating the log with the clarified direction.

---

Maintainer: Forge Codex  
Protocol version: 2025.10.27-d  
Update policy: any change to persona, bootstrap, cognitive stack, quotation-layer naming, or compaction flow must be reflected here and noted in the daily log.
