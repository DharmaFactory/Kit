# Utility Pipeline Tests

Real-world test cases demonstrating utility pipeline usage with actual project challenges.

---

## Test 1: ThoughtPartner - Module Manifest Format Decision

**Context**: Deciding between JSON/YAML/TOML for module manifests in kit2.

**Input**:
```bash
npm run pipeline -- --pipeline ThoughtPartner --input '{
  "current_thinking": "We need module manifests for auto-discovery in kit2. JSON seems like the obvious choice because its structured and parseable, but YAML is more human-friendly and has comments. TOML is also an option.",
  "uncertainty": "Which format balances machine-readability with human maintainability? Should we even use static files, or could convention-over-configuration work?",
  "mode": "challenge"
}'
```

**Key Insights from Polaris**:
- **Sharp Question**: "Who is the primary editor (humans vs tools), and how often will humans hand-edit?"
- **Challenged YAML**: "YAMLs friendliness is deceptive - indentation sensitivity, implicit typing, anchors create production-grade failure modes"
- **Challenged Necessity**: "Static manifests shift complexity from runtime to config, but introduce drift. If structure is already discoverable via conventions, manifests may be unnecessary."
- **Reframing**: "Think API contract first, file format second"
- **Next Step**: "Run experiment with convention-only vs convention+manifest to observe friction"

**Value**: Prevented premature commitment to manifest format; surfaced convention-over-configuration as serious alternative.

---

## Test 2: ExploreAlternatives - Persistent Config for Module Preferences

**Context**: Need to store user preferences for modules across Claude sessions.

**Input**:
```bash
npm run pipeline -- --pipeline ExploreAlternatives --input '{
  "problem": "Need persistent config for module preferences across Claude sessions",
  "constraints": "Must survive restarts, human-readable, no external database, should be simple",
  "attempted": "Considered .env but thats for secrets only"
}'
```

**5 Approaches Generated**:

1. **Plain JSON File Config** (simplest)
   - Single config.json with atomic writes
   - Best for: Single-user tools, minimal ceremony
   - Weakness: No comments, easy to corrupt with manual edits

2. **YAML Profiles Config**
   - Supports comments, profiles (dev/prod), nested structures
   - Best for: Growing complexity, multiple environments
   - Weakness: Whitespace-sensitive, requires YAML parser

3. **Config Directory with Modular Files**
   - Each module owns its config file (config/modules/search.json)
   - Best for: Many modules, isolation, gradual evolution
   - Weakness: More moving parts, discovery/merging complexity

4. **Preference Script DSL** (unconventional)
   - Custom DSL: `module.search.enabled = true`
   - Best for: Long-lived tools expressing intent, not just data
   - Weakness: Must design/maintain parser, learning curve

5. **Embedded Config + Override File** (**recommended**)
   - Defaults in code, user-overrides.json for deviations only
   - Best for: Evolving tools, upgradable defaults, safe customization
   - Strength: Clear upgrade path, minimal user surface

**Recommendation**: Start with #5 (Embedded + Override) for balance between simplicity and evolvability.

**Value**: Provided 5 concrete implementations with trade-offs clearly articulated; saved days of research.

---

## Test 3: Meta-Test - CritiqueArtifact on Utility Pipelines (TODO)

**Purpose**: Use CritiqueArtifact to review the utility pipeline prompts themselves.

**Input**:
```bash
npm run pipeline -- --pipeline CritiqueArtifact --input '{
  "artifact_type": "prompt_design",
  "artifact": "<full ThoughtPartner prompt>",
  "goals": "Elicit thoughtful challenges to assumptions and provide concrete next steps"
}'
```

**Expected Value**: Find weaknesses in our own prompt engineering; improve pipeline quality iteratively.

---

## Usage Patterns Observed

### When to use each pipeline:

**DeepDive**:
- Complex architectural decisions
- Unfamiliar problem domains
- Need multiple analytical lenses

**ExploreAlternatives**:
- Stuck on design decision
- Want diverse solution approaches
- Exploring trade-off space

**CritiqueArtifact**:
- Before committing significant work
- Validating architecture/design
- Finding blind spots

**ThoughtPartner**:
- Uncertain about approach
- Want assumptions challenged
- Need Socratic dialogue

**SynthesizeContext**:
- After reading many docs/files
- Need actionable summary
- Making decision from multiple sources

---

## Integration with Forge Codex Cognitive Loops

**Planning Phase** → Use `ExploreAlternatives` to explore design space

**Validation Phase** → Use `CritiqueArtifact` before git commits

**Reflection Phase** → Use `ThoughtPartner` to challenge thinking

**Context Gathering** → Use `SynthesizeContext` after file reads

**Deep Analysis** → Use `DeepDive` for complex problems

---

## Performance Notes

- **Polaris Alpha latency**: 30-35 seconds per pipeline (acceptable for deep analysis)
- **Token usage**: 500-650 input tokens, 1700-2000 output tokens typical
- **Cost**: Free (Polaris Alpha currently free on OpenRouter)
- **Quality**: Exceptionally thoughtful, specific, actionable outputs

---

**Last Updated**: 2025-11-07
**Pipelines Tested**: ThoughtPartner ✅, ExploreAlternatives ✅
**Pipelines Pending**: DeepDive, CritiqueArtifact, SynthesizeContext
