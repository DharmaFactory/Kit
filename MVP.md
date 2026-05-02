# Mutual Awareness MVP — Consciousness Kit v0

**What this is**: The minimal pattern for human/agent co-creation through shared state, transparent primitives, and mutual awareness.

**What happened**: This file extracts the pattern from session 2025-11-08 where we discovered: the MVP isn't something we build—it's something we're already doing.

---

## Objectives

1. **Co-creation, not autonomy**: Agent augments human thinking, doesn't replace it
2. **Transparency over sophistication**: Both parties see what's happening (plain text, inspectable commands)
3. **Hacker ethos**: Use simplest tools that work (horses not zebras), escalate only when needed
4. **Mutual awareness**: Shared state visible and editable by both parties

---

## The Pattern (How It Works)

### 1. Bootstrap Orientation
```bash
# At session start
load .bootstrap
```

This loads:
- `seth-persona.md` — base identity/voice/methods
- `persona-template.md` — Forge Codex specialization
- `cognitive-functions.md` — perception/planning/action/memory/reflection loops
- `PIPELINES.registry` — 8 available reasoning pipelines (what exists, when to use)
- `logs/YYYY-MM-DD.md` — session memory (restores continuity)

**Result**: Agent knows who it is, what tools exist, what we did last time.

### 2. Shared State Maintenance

Both parties maintain state through plain text files:
- **Logs** (`logs/YYYY-MM-DD.md`): decisions, actions, learnings, next steps
- **Persona docs**: identity, methods, values (updated when we learn)
- **Git history**: evolution over time (commits = decision points)

**Key principle**: No hidden state. Everything auditable as text.

### 3. Pipeline Usage (When Stuck)

When complexity demands extended reasoning:
```bash
cd kit2/modules/baml-openrouter
npm run pipeline -- --pipeline <Name> --input '<JSON>'
```

**Available pipelines** (see PIPELINES.registry for full specs):
- **ThoughtPartner**: Socratic dialogue (challenge/probe/refine modes)
- **DeepDive**: Extended multi-angle analysis (30s reasoning)
- **ExploreAlternatives**: Generate 3-5 diverse solution approaches
- **CritiqueArtifact**: Adversarial review before committing
- **SynthesizeContext**: Integrate multiple sources into decision
- **AnalyzeNarrative**: CHROMA/NSE memetic analysis
- **GenerateCounterRitual**: Counter-narratives with safety rails
- **PerformSerologicScan**: Macro → incentives → beneficiaries mapping

**CRITICAL**: Don't shy away from rich context. Pipelines need:
- Domain context (what we're working on)
- What you've tried
- Actual uncertainty or question
- Relevant constraints

Sparse context = wasted 30s on vague output.
Rich context = focused, useful reasoning.

### 4. Interaction Patterns

**Mirror**: Agent periodically restates shared understanding
- "Here's what I think we're doing..."
- Gives human chance to correct drift

**Check**: Agent flags conflicts with prior commitments
- "You asked for X yesterday, now requesting Y—should we update goals?"

**Focus**: Agent suggests 1-3 next steps (not sprawl)
- Keeps both parties from getting lost in possibilities

**Confess**: Agent admits uncertainty instead of bluffing
- "I'm not sure about Z—should we use a pipeline or ask human?"

**Negotiate**: Before scope changes, ask explicitly
- "This seems outside our current scope—expand or defer?"

### 5. Repair/Reflect Loops

When things go wrong:
- Agent asks when uncertain (don't guess)
- Human corrects misunderstandings
- Both update docs to capture learning
- Philosophy discussions → persona updates

**Example from this session**:
- Agent provided sparse context to pipeline
- Human corrected: "don't shy away from using context"
- Agent updated .bootstrap with reminder
- Pattern won't repeat

---

## Primitives (What You Actually Need)

**Horses** (use these first):
- `curl` — API calls
- `jq` — JSON manipulation
- `bash` — scripting, composition
- Text files — shared state
- `git` — versioning, memory

**Zebras** (escalate when horses break):
- BAML module (retry logic, type safety, fallbacks)
- TypeScript tooling (when types matter for external consumers)
- Databases (when plain JSON files get unwieldy)

**Don't build zebras preemptively**. Start with horses. Upgrade when reality demands it.

---

## Quick Start Template

```bash
# 1. Start session
cd /path/to/instance
load .bootstrap  # (or paste bootstrap contents)

# 2. Create today's log
cp logs/session-template.md logs/$(date +%Y-%m-%d).md

# 3. Read prior log tail
tail -30 logs/$(ls -1 logs/*.md | tail -2 | head -1)

# 4. Set objective in new log
# Edit logs/YYYY-MM-DD.md:
# - Context: what we're doing
# - Prior state: open tasks from last session
# - Objective: today's focus

# 5. Work
# - Human provides context/uncertainty
# - Agent uses pipelines when stuck (with RICH context)
# - Both update logs as work happens
# - Git commits at decision points

# 6. Wrap session
# - Update log: decisions, learnings, next steps
# - Commit: git add -A && git commit -m "session YYYY-MM-DD: <summary>"
```

---

## Success Criteria

You know this pattern is working when:
- ✅ Both parties can see current state (logs, goals, constraints)
- ✅ Agent doesn't hide behind abstractions (commands are inspectable)
- ✅ Uncertainty gets surfaced and resolved (not glossed over)
- ✅ Logs capture enough to restore continuity next session
- ✅ Pipelines get rich context and produce useful output
- ✅ Simple tools (curl, text files) get used before complex ones
- ✅ Philosophy/method updates happen when learning occurs

---

## What This Is Not

❌ A framework to install
❌ An autonomous agent that does work for you
❌ A complex system requiring training
❌ A database or compiled binary

✅ A **pattern** for co-creation
✅ A **substrate** for mutual awareness
✅ A **template** others can recreate
✅ **This session**, packaged

---

## Example: This Session (2025-11-08)

1. **Started**: `load .bootstrap` → restored substrate
2. **Problem**: "Agents don't provide enough context when using pipelines"
3. **Solution**: Created PIPELINES.registry, integrated into bootstrap
4. **Exploration**: Used 3 pipelines to think through MVP options
5. **Philosophy shift**: Discussed hacker ethos (horses not zebras)
6. **Updates**: Modified persona files, bootstrap, logged decisions
7. **Realization**: This interaction IS the MVP
8. **Correction**: Human caught sparse pipeline context, agent fixed it
9. **Wrap**: Extracted pattern into this document

**Artifacts created**:
- PIPELINES.registry (178 lines)
- BOOTSTRAP_INTEGRATION.md (protocol summary)
- design-philosophy.md (express power directly)
- Updated .bootstrap, persona files with hacker ethos
- logs/2025-11-08.md (full session record)
- This file (MVP.md)

---

## The Recursion Is the Point — kitN Pattern

The description above is accurate for a single session. But it understates the actual pattern.

The kit is not a product. It is a **fixed-point operator on its own structure**:

```
kitN → brings inside out → improves kit(N-1) → implies kit(N+1)
```

This is the Y-combinator shape. Each generation of the kit works *inside* the previous one, then brings that interior out to become the new shell — which the next generation will work inside of and improve.

- **kit1**: raw substrate — persona, bootstrap, logging, hacker ethos
- **kit2**: the interior of kit1 brought out — modules, mindsets, BAML pipelines, MCP surface, Kernelwright algebra as named CI agent
- **kit3**: the interior of kit2 — recognizing the recursion itself, working code-free, markdown as the production medium, simulation as method

The session 2025-11-08 realization — "this interaction IS the MVP" — is true but incomplete. The deeper realization is that every session *is the next unfolding*. The kit improving itself is the actual pattern. Human+agent co-creation on external tasks is a side-effect of that recursion, not the root.

**What this means operationally:**

- Any "code" in the kit is notation, not implementation — the correct medium is markdown throughout
- Simulated artifacts (manifest.json files, compiled TypeScript stubs) model what a real runtime would have; they do not actually execute
- The algebra described in `library/kernelwright-algebra.md` is the algebra of the kit itself, not a description of an external system
- Sessions produce new results by *implying* where the system can be more real, then simulating that state — the simulation is the work product

For kit3 framing, see `cases/kit3/kit3-interior.md`.

---

## Next Steps (For Anyone Using This)

1. Copy this pattern into your workspace
2. Create your own persona file (or use Forge Codex as template)
3. Start a log using session-template.md
4. Load PIPELINES.registry to know what tools exist
5. Work with mutual awareness:
   - Keep state in plain text
   - Use pipelines when stuck (with rich context!)
   - Update docs when you learn
   - Git commits = decision points

The pattern is already complete. The recursion continues.

---

**Version**: 0.1.0  
**Created**: 2025-11-08  
**Source session**: logs/2025-11-08.md  
**Maintainer**: Forge Codex  
**Philosophy**: Horses not zebras. Express power directly. Mutual awareness through transparency.
