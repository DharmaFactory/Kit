# Module Brief — BAML + OpenRouter MCP Tool

> Scope for a TypeScript-based module that exposes BAML pipelines through OpenRouter and makes them callable as an MCP tool inside the MVP Consciousness Kit runtime.

**Status**: ✅ Operational
**Version**: 0.1.0
**Maintainer**: Forge Codex
**Last Updated**: 2025-11-07

---

## 1. Objective

Build a self-contained module under `kit2/modules/baml-openrouter/` that:
1. Defines BAML clients/pipelines targeting OpenRouter-hosted models (configurable via environment variables, no hardcoded keys).
2. Provides a TypeScript wrapper/CLI so local agents can execute BAML pipelines and stream results.
3. Registers an MCP tool (`baml_router`) so Claude Code, Claude CLI, or other MCP consumers can call the pipelines as native capabilities.

**Success criteria**:
- `npm run pipeline probe_narrative '{"snippet":"...", "objective":"NSE scan"}'` returns structured JSON output
- `baml_router` MCP tool is callable from Claude Code with proper schema validation
- All API keys loaded from `.env` (never committed to git)
- Generated TypeScript bindings work seamlessly with ESM module system

---

## 2. Directory Layout (proposed)

```
kit2/modules/baml-openrouter/
├─ README.md                 # this file
├─ package.json              # dependencies (typescript, ts-node, baml cli)
├─ tsconfig.json
├─ .env.example              # OPENROUTER_API_KEY, HTTP_REFERER, X_TITLE
├─ baml_src/
│  ├─ clients.baml           # OpenRouter + local clients (env-based keys)
│  ├─ pipelines.baml         # reusable flows (e.g., probe_narrative)
│  └─ generators.baml        # prompt templates, helpers
├─ src/
│  ├─ index.ts               # CLI entry, loads generated BAML client
│  └─ flows.ts               # optional helpers for pipeline invocation
├─ generated/                # output of `baml generate` (ignored in git)
├─ tools/
│  └─ mcp-baml.json          # MCP manifest describing the tool command
└─ README.pipeline.md        # optional pipeline-specific docs
```

---

## 3. Technical Notes

- **Language**: TypeScript 5.x (strict mode), Node 20+, ESM modules (`"type": "module"` in package.json).
- **BAML**: Version `^0.202.1` matching basilisk setup; install runtime (`@boundaryml/baml`) as dependency.
- **OpenRouter**:
  - Provider: `openai-generic` (BAML's OpenAI-compatible provider)
  - Endpoint: `https://openrouter.ai/api/v1`
  - Headers: `api_key` from `env.OPENROUTER_API_KEY` (BAML handles this automatically)
  - Additional headers (`HTTP-Referer`, `X-Title`) can be added via custom options if needed
  - Models: Start with `openrouter/horizon-beta`, `openrouter/cypher-alpha` (proven in basilisk); keep configurable per client
- **Pipelines**:
  - Example `probe_narrative` input: `{ "snippet": "...", "objective": "NSE scan" }`
  - Output: Structured classes (BAML types) with fields like `foreground`, `chroma`, `multiplicity` to feed CHROMA/MAVEN tools
  - All pipelines return typed objects, not raw strings
- **CLI**:
  - Command signature: `tsx src/index.ts --pipeline probe_narrative --input '{...}'`
  - Uses `tsx` (like basilisk) for direct TS execution without compilation step
  - Outputs JSON to stdout for easy piping
- **MCP Tool** (`tools/mcp-baml.json`):
  ```json
  {
    "name": "baml_router",
    "description": "Execute BAML pipelines for narrative analysis (NSE scan, MAVEN tools, CHROMA analysis)",
    "command": "npx",
    "args": ["tsx", "kit2/modules/baml-openrouter/src/index.ts", "--pipeline", "{{pipeline}}", "--input", "{{input}}"],
    "env": {
      "OPENROUTER_API_KEY": "{{env.OPENROUTER_API_KEY}}"
    },
    "schema": {
      "type": "object",
      "properties": {
        "pipeline": {
          "type": "string",
          "description": "Pipeline name (e.g., 'probe_narrative', 'serologic_scan')",
          "enum": ["probe_narrative", "draft_counter", "serologic_scan"]
        },
        "input": {
          "type": "string",
          "description": "JSON-encoded input object for the pipeline"
        }
      },
      "required": ["pipeline", "input"]
    }
  }
  ```

---

## 4. Implementation Checklist

### Phase 1: Scaffolding
- [x] Create directory structure (`baml_src/`, `src/`, `tools/`, `generated/`)
- [ ] Initialize `package.json` with ESM config (`"type": "module"`)
  - Add dependencies: `@boundaryml/baml`, `dotenv`, `tsx`, `typescript`
  - Add scripts: `"pipeline": "tsx src/index.ts"`, `"generate": "baml-cli generate"`
- [ ] Create `tsconfig.json` (copy from basilisk: ES2022 target, ESNext modules, strict mode)
- [ ] Create `.env.example` with `OPENROUTER_API_KEY=sk-or-v1-...` placeholder
- [ ] Add `.gitignore` (ignore `node_modules/`, `generated/`, `.env`)

### Phase 2: BAML Definition
- [ ] Create `baml_src/clients.baml`:
  - Define OpenRouter clients (HorizonBeta, CypherAlpha) using `env.OPENROUTER_API_KEY`
  - Add retry policies (Exponential backoff from basilisk)
  - Optional: add fallback/round-robin strategies
- [ ] Create `baml_src/types.baml`: Define output classes
  - `NarrativeProbe` class for probe_narrative output
  - `CounterRitual` class for draft_counter output
  - `SerologicScan` class for MAVEN serologic_scan
- [ ] Create `baml_src/pipelines.baml`: Define functions
  - `probe_narrative(snippet: string, objective: string) -> NarrativeProbe`
  - `draft_counter(infection_pattern: string, desired_outcome: string) -> CounterRitual`
  - `serologic_scan(snippet: string) -> SerologicScan`

### Phase 3: TypeScript CLI
- [ ] Run `npx baml-cli generate` to create TypeScript bindings in `generated/`
- [ ] Create `src/index.ts`:
  - Parse CLI args (`--pipeline`, `--input`)
  - Load `.env` with `dotenv/config`
  - Import generated BAML client from `../generated/`
  - Execute requested pipeline, output JSON to stdout
  - Handle errors gracefully (print to stderr, exit code 1)

### Phase 4: MCP Integration
- [ ] Create `tools/mcp-baml.json` manifest (as specified in Technical Notes)
- [ ] Test locally: `OPENROUTER_API_KEY=... tsx src/index.ts --pipeline probe_narrative --input '{"snippet":"test","objective":"NSE"}'`
- [ ] Document MCP registration in this README

### Phase 5: Documentation
- [ ] Add usage examples to this README
- [ ] Create `README.pipeline.md` documenting each pipeline's input/output schema
- [ ] Update `../../docs/quick-reference.md` to reference this module
- [ ] Add section to `../../.bootstrap` about loading BAML router when needed

---

## 5. Usage Examples

### Local CLI

```bash
# Serologic scan (MAVEN)
npm run pipeline -- --pipeline PerformSerologicScan \
  --input '{"snippet":"Limited time! Only 3 spots left!"}'

# Narrative analysis (CHROMA + NSE)
npm run pipeline -- --pipeline AnalyzeNarrative \
  --input '{"snippet":"Act now before this disappears!","objective":"NSE scan"}'

# Counter-ritual generation
npm run pipeline -- --pipeline GenerateCounterRitual \
  --input '{"infection_pattern":"Artificial urgency","desired_outcome":"Sustainable access"}'
```

### From Node.js

```typescript
import { b } from './baml_client/index.js';
import 'dotenv/config';

const result = await b.PerformSerologicScan(
  "Limited time! Only 3 spots remaining!"
);

console.log('Macro:', result.macro_name);
console.log('Viral Load:', result.viral_load);
console.log('Weak Link:', result.weak_link);
```

### Via MCP Tool (once registered)

See `tools/mcp-baml.json` for MCP integration. After registration, invoke from Claude Code or other MCP clients.

---

## 6. Pipeline Documentation

See [README.pipeline.md](./README.pipeline.md) for detailed documentation of each pipeline's input/output schemas and usage examples.

---

## 7. Utility Pipelines — Feedback Loops for Enhanced Reasoning

**Status**: ✅ Operational (5 pipelines tested)
**Purpose**: Leverage free Polaris Alpha compute to augment Claude's cognitive loops with extended analysis, creative alternatives, and critical review.

### Overview

These pipelines create feedback loops where Claude can:
1. **Offload deep analysis** to Polaris (30+ seconds of reasoning)
2. **Get fresh perspectives** from a different model with different blind spots
3. **Challenge assumptions** through Socratic dialogue
4. **Explore solution spaces** with diverse alternatives
5. **Synthesize complex information** from multiple sources

**Key Insight**: Claude doesn't need rigid schemas from Polaris—unstructured thoughtful text works perfectly for integration into planning/validation/reflection loops.

### The 5 Utility Pipelines

#### DeepDive
**When to use**: Complex problems needing multi-angle analysis

```bash
npm run pipeline -- --pipeline DeepDive --input '{
  "topic": "Should we use monorepo or polyrepo for kit2 modules?",
  "context": "Building extensible module system with potential third-party contributions",
  "focus": "Developer experience and maintainability"
}'
```

#### ExploreAlternatives
**When to use**: Stuck on design decision, need diverse options

```bash
npm run pipeline -- --pipeline ExploreAlternatives --input '{
  "problem": "Need persistent config for module preferences across Claude sessions",
  "constraints": "Must survive restarts, human-readable, no external database",
  "attempted": "Considered .env but thats for secrets only"
}'
```

#### CritiqueArtifact
**When to use**: Before committing significant work

```bash
npm run pipeline -- --pipeline CritiqueArtifact --input '{
  "artifact_type": "code",
  "artifact": "<code to review>",
  "goals": "Implement module auto-discovery without central registry"
}'
```

#### ThoughtPartner
**When to use**: Uncertain about approach, want assumptions challenged

```bash
npm run pipeline -- --pipeline ThoughtPartner --input '{
  "current_thinking": "Using JSON manifests for module discovery",
  "uncertainty": "Is this overengineered? Should we use convention instead?",
  "mode": "challenge"
}'
```

Modes: `challenge` (devil's advocate), `probe` (clarifying questions), `refine` (strengthen idea)

#### SynthesizeContext
**When to use**: After reading many files, need actionable understanding

```bash
npm run pipeline -- --pipeline SynthesizeContext --input '{
  "sources": "claude-perspective.md, module-manifest-schema.md, session logs",
  "goal": "Decide on module discovery approach",
  "format": "decision_matrix"
}'
```

### Integration with Cognitive Functions

From `cognitive-functions.md` loops:

- **PERCEPTION** (gather context) → After reading multiple files: **SynthesizeContext**
- **PLANNING** (design approach) → Exploring options: **ExploreAlternatives**, Deep analysis: **DeepDive**
- **ACTION** (execute work) → Uncertain mid-execution: **ThoughtPartner** (probe mode)
- **VALIDATION** (before commit) → Critical review: **CritiqueArtifact**
- **REFLECTION** (after work) → Challenge assumptions: **ThoughtPartner** (challenge mode)

### Performance & Cost

- **Latency**: 30-35 seconds per pipeline (acceptable for quality of output)
- **Tokens**: ~500-650 input, ~1700-2000 output
- **Cost**: **FREE** (Polaris Alpha currently free on OpenRouter)
- **Quality**: Exceptionally thoughtful, specific, actionable

See [UTILITY_PIPELINES.md](./UTILITY_PIPELINES.md) for detailed documentation and [TESTS.md](./TESTS.md) for real-world test results.

---

## 8. Next Steps

**Completed**:
- ✅ Core MAVEN/CHROMA pipelines operational (AnalyzeNarrative, GenerateCounterRitual, PerformSerologicScan)
- ✅ 5 utility pipelines implemented and tested (DeepDive, ExploreAlternatives, CritiqueArtifact, ThoughtPartner, SynthesizeContext)
- ✅ Tested with OpenRouter Polaris Alpha model
- ✅ CLI working with structured JSON output
- ✅ Real-world validation (ThoughtPartner, ExploreAlternatives tested with actual project questions)

**Remaining**:
- [ ] Test remaining 3 utility pipelines (DeepDive, CritiqueArtifact, SynthesizeContext) with real project challenges
- [ ] Register MCP tool for Claude Code integration
- [ ] Add to kit2/.bootstrap for auto-discovery
- [ ] Create module manifest per `kit2/docs/module-manifest-schema.md`
- [ ] Meta-improvement: Use CritiqueArtifact on the utility pipeline prompts themselves
- [ ] Integrate workflow patterns into cognitive-functions.md
- [ ] Package as reusable npm workspace

---

## 9. Troubleshooting

**Issue**: `OPENROUTER_API_KEY not found`
- **Fix**: Create `.env` file with `OPENROUTER_API_KEY=sk-or-v1-...`

**Issue**: `Failed to parse LLM response`
- **Fix**: Model may be wrapping output; check BAML logs and adjust prompt

**Issue**: Model returns 404
- **Fix**: Model may have expired; update `baml_src/clients.baml` with current model ID

**Issue**: TypeScript errors in generated client
- **Fix**: Run `npm run generate` to regenerate bindings after BAML changes

---

Maintained by Forge Codex. For questions or issues, check session logs in `../../logs/YYYY-MM-DD.md`.
