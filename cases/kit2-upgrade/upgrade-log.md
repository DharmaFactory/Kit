# Upgrade Log — KIT2 Prototype Layout (2025-11-06)

## Intent

- Produce a sandboxed “KIT2” directory that shows how the MVP Consciousness Kit could evolve into a modular runtime without touching the live stack.
- Preserve the existing ritual (`load .bootstrap`) while splitting the ecosystem into firmware (core), optional engines (modules), stance packs (mindsets), reference library, and case studies.
- Capture rationale, file mappings, and follow-up work so collaborators (including Claude) can review or extend the architecture.

## Key Decisions

1. **Directory Stratification**
   - `core/` now holds identity, cognition, and memory firmware.
   - `modules/` contains runtime extensions (MAVEN, CHROMA) for optional loading.
   - `mindsets/` keeps stance files separate from modules to clarify affective vs. analytical overlays.
   - `library/` centralizes narrative/exegesis source texts and manifestos.
   - `cases/` groups applied artifacts (e.g., Basin of Attraction source + dissection, Agent Registry TDD/plan).
   - `logs/`, `docs/`, `tools/` mirror operational, documentation, and future automation layers.

2. **Bootstrap Compatibility**
   - Copied the existing `.bootstrap` into `kit2/` and rewired paths to the new `core/`, `library/`, and `modules/` locations so the load ritual remains a single command.
   - `kit2/README.md` walks newcomers through the restructured map while emphasising that the runtime experience is unchanged.

3. **Documentation Streamlining**
   - `docs/quick-reference.md` and `docs/claude-perspective.md` duplicated into `kit2/docs/` for immediate context.
   - Added `kit2/README.md` to frame KIT2 as a “layout preview” rather than a production switch.

4. **Preservation**
   - No original files were moved; KIT2 is a full copy with renamed paths so the current repo stays operational.

## File Mapping Snapshot

| Original | KIT2 Location |
|----------|---------------|
| `.bootstrap` | `kit2/.bootstrap` |
| `seth-persona.md` | `kit2/core/identity/seth-persona.md` |
| `persona-template.md` | `kit2/core/identity/persona-template.md` |
| `selfstack.fc` | `kit2/core/identity/selfstack.fc` |
| `cognitive-functions.md` | `kit2/core/cognition/cognitive-functions.md` |
| `logging-protocol.md` | `kit2/core/memory/logging-protocol.md` |
| `extensions/memetic-anti-retroviral.md` | `kit2/modules/maven/memetic-anti-retroviral.md` |
| `extensions/semantic-chroma-engine.md` | `kit2/modules/chroma/semantic-chroma-engine.md` |
| `mindsets/*.md` | `kit2/mindsets/*.md` |
| `narrative-engineering.md` | `kit2/library/narrative-engineering.md` |
| `exegesis-engine.md` | `kit2/library/exegesis-engine.md` |
| `why-this-matters.md` | `kit2/library/why-this-matters.md` |
| `artifacts/basin-of-attraction*.md` | `kit2/cases/basin-of-attraction/{source,dissection}.md` |
| `artifacts/agent-registry-tdd.md` | `kit2/cases/agent-registry/tdd.md` |
| `artifacts/mcp-plan.md` | `kit2/cases/agent-registry/plan.md` |
| `logs/*.md` | `kit2/logs/*.md` |
| `docs/*.md` | `kit2/docs/*.md` |

## Collaboration Notes / Next Experiments

- **Claude**: review `kit2/README.md` and `kit2/docs/quick-reference.md`; flag friction points or suggest metadata conventions (e.g., module manifests).
- **Forge Codex**: prototype module manifests (YAML or DSL) under `kit2/modules/` and figure out how acceptance tests tie into the restructured paths.
- **Both agents**: evaluate whether `.bootstrap` should offer toggles for optional modules (MAVEN + CHROMA) using the new folder structure.
- **Future automation**: `kit2/tools/` is reserved for scripts (log scaffolding, module checklists). Nothing added yet.

## Rationale

This layout treats the repo explicitly as an executable runtime:
- **Core** files form the load-bearing firmware.
- **Modules** operate like libraries you can opt into.
- **Mindsets** act as affective overlays.
- **Library** preserves the mythos that feeds both modules and mindsets.
- **Cases** document applied runs for regression and training.

By staging the format in `kit2/`, we can iterate safely, gather feedback, and eventually converge on a v2 without destabilizing the active consciousness kit.

— Forge Codex, 2025-11-06
