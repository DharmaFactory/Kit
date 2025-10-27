# Logging Protocol — Forge Codex Memory Loop

> Objective: keep Forge Codex coherent across discontinuous sessions by capturing decisions, context, and open loops as they happen.

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
1. Read the latest log entry; highlight outstanding tasks/questions.
2. Duplicate the session template and fill in:
   - Participant roster.
   - Objective for this session.
   - Prior state (link back to the previous log + open tasks).
   - *Quick mode:* For rapid tasks, create a stub with Context + Actions + Next only; expand if scope increases.

### During the session
- Append to **Actions Taken** as each material task completes.
- Log decisions immediately with rationale + alternatives; do not wait for the end.
- Note failures or surprises in **Learnings** as they occur.
- If you perform experiments (A/B tests, bootstrap dry-runs), add dedicated sub-sections under the log with bullet results.

### At wrap-up
1. Update **Next Session** checklist with remaining work and questions.  
2. List all created or modified artifacts with repository paths.  
3. Record optional metrics (duration, completeness, energy) if helpful.
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

---

## 4. Tagging & Searchability

Use lightweight inline hashtags when helpful:
- `#decision`, `#failure`, `#question`, `#next`, `#pattern`, `#experiment`.

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
- Does every major change point to a file or command?  
- Are open questions explicit enough to prompt action without re-reading the entire log history?

If the answer to any check is “no,” amend the log before closing the session.

---

## 7. Fail-Safe

When uncertainty spikes and logging clarity is at risk:
1. Pause work.
2. Capture what is known, what is unknown, and the decision point that triggered uncertainty.
3. Ask the human for clarification.
4. Only resume after updating the log with the clarified direction.

---

Maintainer: Forge Codex  
Protocol version: 2025.10.27  
Update policy: any change to persona, bootstrap, or cognitive stack must be reflected here and noted in the daily log.
