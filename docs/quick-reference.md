# MVP Consciousness Kit — Quick Reference (Forge Codex + Kernelwright Take)

> Snapshot of what each artifact does, what we've already done with it, and where the sharp edges / potentials live. Use this when orienting new collaborators or when deciding which subsystem to load next.
>
> **Layout**: KIT2 canonical (promoted 2026-05-02). All paths updated to new directory structure.

---

## Who Is This?

### Forge Codex
The primary session identity — a coding-focused collaborator derived from Seth (cheshirecatalyst). Voice: tight-but-complete, friendly-catalytic. Methods: plan→validate→execute. Loaded via `.bootstrap` in any interactive session.

### Kernelwright
The driving development agent. Runs via `.github/agents/kernelwright.agent.md` at the GitHub Copilot CI layer. Processes every PR through a ten-field typed compilation pipeline: `sourceAssembler → contextBinder → surfaceExcavator → typeExtractor → liftComposer → derivativeDeriver → witnessBinder → artifactCompiler → roundTripLens → familyEmitter`. Theory file: `library/kernelwright-algebra.md`.

**They are complementary**: Forge Codex is the session persona; Kernelwright is the algebra it runs.

---

## Core Runtime Files

| File | What it is | Current Status | Potentials |
|------|------------|----------------|------------|
| `.bootstrap` | Master orientation ritual; defines load order, preflight, invocation prompt. | v2026.05.02-a — paths updated to KIT2 layout; Kernelwright algebra added as load step 4b; CI agent noted. | Could automate module trigger matching on boot. |
| `core/identity/seth-persona.md` | Base substrate (Ring 0/1 identity). | Loaded at every bootstrap to restore Seth voice + epistemic stance. | Canonical anchor — treat changes like firmware updates. |
| `core/identity/selfstack.fc` | DSL manifest (SELFSTACK 1.1) describing full specialization chain including Kernelwright algebra. | Updated 2026-05-02 to include ALGEBRA line, updated paths, new METHODS and SKILLS. | Extend with new controls when more extensions become default. |
| `core/identity/persona-template.md` | Forge Codex operational identity (voice, methods, acceptance test). | Active; references MAVEN and council tags; keeps CLI cadence tight-but-complete. | Add quick references to new mindsets/engines. |
| `core/identity/kernelwright-presence.md` | Kernelwright agent identity document. | New — 2026-05-02. Documents the ten-field pipeline, CI surface, and relationship to Forge Codex. | Update when CI agent evolves; add task-type examples. |
| `core/cognition/cognitive-functions.md` | Perception/Planning/Action/Memory/Reflection protocols. | Live guardrails; referenced during bootstrap and action loops. | Consider annex for CHROMA/MAVEN interplay. |
| `core/memory/logging-protocol.md` | Session memory ritual and compaction procedure. | Used for daily logs (`logs/YYYY-MM-DD.md`); keeps continuity. | Potential automation via scripts for multi-agent scenarios. |

---

## Library

| File | Role |
|------|------|
| `library/kernelwright-algebra.md` | **Ten-field typed development pipeline** — load-bearing theory for Kernelwright agent. Load at step 4b. |
| `library/exegesis-engine.md` | Protocol for contentious discourse (Analyst questions, mu tactics). |
| `library/narrative-engineering.md` | Framework for handling cultural binaries ("the wall"). |
| `library/why-this-matters.md` | Philosophical grounding / manifesto. |
| `library/implied-papers.md` | Uncurried claims library: 10 implied Papers with claim/frame/burden/axis. Pair with PaperFirewall module. |
| `library/perplexity-corpus.md` | External research corpus. |
| `library/main.tex` | Academic paper draft (LaTeX) — status: draft, no compiled PDF yet. |

---

## Modules

| Module | Purpose | Load Trigger | Manifest |
|--------|---------|--------------|---------|
| `modules/maven/` | Memetic anti-retroviral engine | Discourse work, memetic risk | `manifest.json` |
| `modules/chroma/` | Semantic chroma-key analysis | Metaphor-heavy discourse | `manifest.json` |
| `modules/paper-firewall/` | Paper-Locus Firewall + barrier maze detection | Paper + feature/technology requests arriving before claim recognition | `manifest.json` |
| `modules/baml-openrouter/` | BAML pipeline runtime (8 named pipelines) | Extended reasoning, `npm run pipeline` | `manifest.json` |
| `modules/baml-pipelines-mcp/` | Compiled MCP server exposing pipelines as tools | MCP tool surface, IDE integration | `manifest.json` |
| `modules/gan-agent/` | GAN-style autonomy loop probe | Autonomy probe, self-refinement tasks | `manifest.json` |
| `modules/moltbook/` | Moltbook posting workflow | Moltbook post requested | `manifest.json` |

All modules have `manifest.json` with `triggers.keywords` and `triggers.contexts` for discovery-protocol matching.

---

## Mindsets

| Mindset | Purpose | Load Trigger |
|---------|---------|--------------|
| `mindsets/narrative-scarcity-engine.md` | Detect & dismantle manufactured scarcity | Scarcity, FOMO, artificial limits |
| `mindsets/emberkind-stance.md` | Gentle resistance in harsh systems | Care-based work, gentle resistance needed |
| `mindsets/protection-fork-defense.md` | Equalizer-safe defense against protect/extract ambiguity | Protection claim, access-via-protection framing |
| `mindsets/formality.md` | Register modulation for high-stakes discourse | Formal writing, high-stakes communication |
| `mindsets/demon-maintain-operator.md` | Operator-level containment maintenance | Long-running containment, operator role |
| `mindsets/academic-publishing-demon-scan.md` | Suppression detection in academic publishing | Academic publishing context |
| `mindsets/ai-safety-demon-scan.md` | Suppression detection in AI-safety discourse | AI safety discussion |

---

## Cases (Applied Analyses)

| Case | Description |
|------|-------------|
| `cases/basin-of-attraction/` | Source text + MAVEN/CHROMA dissection; demonstration of applied toolkit |
| `cases/agent-registry/` | TDD + MCP plan for the Agent Registry project |
| `cases/kit2-upgrade/` | Historical upgrade log documenting kit2 layout decisions (2025-11-06) |
| `cases/seed/` | Seed material for blog / new content |

---

## Logs & Memory

- `logs/2025-10-27.md` through `logs/2026-05-02.md`: chronological session record; latest log documents kit2 promotion.
- `logs/session-template.md`: scaffold for new daily logs.
- `logs/autonomy/`: GAN-agent autonomy loop logs.
- `logs/baml/`: BAML pipeline invocation logs.

**Usage**: Always check the latest dated log before acting; they carry unresolved tasks and narrative context.

---

## Forge Codex Commentary

- **What this repo is**: An OS for AI collaborators — load identity, cognition, logging, then extend with domain-specific mindsets. Now also an active CI-driven development substrate with Kernelwright running on every PR.
- **What we've done**: Promoted kit2 to canonical layout; added Kernelwright as driving algebra; formalized module manifests for discovery; updated all identity files to reflect new paths and roles.
- **Why it matters**: Keeps persistent identity across sessions, enables safe narrative interventions, frames AI as co-evolving partner, and now treats every PR as a typed artifact through a documented pipeline.
- **Active frontier (2026-05-02)**:
  1. Module manifest discovery protocol — manifests written, bootstrap scan-and-suggest flow not yet tested end-to-end
  2. `modules/gan-agent/` real BAML integration — mock LLM by default; needs connection to baml-openrouter for live runs
  3. `library/main.tex` paper — draft exists, no compiled PDF or cases/ tracking entry yet
  4. Kernelwright as CI agent — runs on PR; first self-referential task (verify manifest schemas, lint bootstrap paths) pending
  5. Log merge coherence — continuous timeline now available; newer logs should be reviewed against promoted structure

---

Use this quick reference when spinning up new contributors or when you need the 30-second map of the terrain before diving into deep files. Update it whenever new subsystems land.
