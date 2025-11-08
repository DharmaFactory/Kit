# BAML Pipeline Bootstrap Integration — Protocol Summary

**Date**: 2025-11-08  
**Context**: Solving agent context insufficiency when using BAML pipelines  
**Status**: Complete ✅

---

## Problem Statement

**Observed behavior**: Agents (including Forge Codex) often call BAML pipelines with insufficient context, producing low-quality results or failures.

**Root cause**: Pipeline specifications (names, schemas, usage triggers) exist in module README but are NOT loaded during bootstrap. Each session, agents must rediscover pipelines by reading files mid-task.

**Human observation**: "i have noticed when it is used by agents they often don't provide enough context. but in general they aren't like this context and they / you will need to be calling them and expanding this in such a way that it is easy for you to know what endpoints exist. and how to utilize them as you are to not just go with what they say"

---

## Solution Design

### Three-Part Update

1. **Pipeline Registry** (`kit2/modules/baml-openrouter/PIPELINES.registry`)
   - Compact reference file (178 lines) listing all 8 pipelines
   - For each pipeline: purpose, usage triggers, input/output schemas, cognitive loop integration, examples
   - Usage protocol with context sufficiency checklist
   - Anti-pattern vs good pattern examples

2. **Bootstrap Protocol** (`.bootstrap` v2025.11.08-b)
   - Added registry to orientation stack (item 8, loaded after MAVEN, before log)
   - Updated preflight checklist, rapid boot path, invocation prompt
   - Added troubleshooting entries for pipeline usage

3. **Cognitive Functions** (`cognitive-functions.md` v2025.11.08-e)
   - Added "BAML Pipeline Integration" section
   - Created integration map: cognitive function → when to use → which pipelines
   - Documented usage protocol (when to call vs reason directly)
   - Included context sufficiency checklist with examples

---

## Before vs After

### Before (No Registry in Bootstrap)

**Agent behavior**:
```
User: "analyze this narrative for memetic patterns"
Agent: *doesn't know AnalyzeNarrative exists*
Agent: *reads baml_src/pipelines.baml mid-session*
Agent: *calls pipeline with vague input*
Pipeline input: {"snippet": "the text", "objective": "analyze"}
Result: Low-quality output due to insufficient context
```

**Problems**:
- Agent must file-dive to discover pipelines
- No guidance on WHEN to use which pipeline
- No schema reference → underspecified inputs
- No integration with cognitive loops → ad-hoc usage
- Wastes 30s pipeline latency on poorly-formed requests

### After (Registry Loaded During Bootstrap)

**Agent behavior**:
```
User: "analyze this narrative for memetic patterns"
Agent: *loaded PIPELINES.registry during boot*
Agent: *knows AnalyzeNarrative exists, purpose, schema*
Agent: *checks integration map: PERCEPTION → memetic analysis → AnalyzeNarrative*
Agent: *validates context sufficiency checklist*
Pipeline input: {
  "snippet": "Limited time! Only 3 spots left! Act now!",
  "objective": "NSE scan for artificial urgency patterns, assess viral load and replication machinery"
}
Result: High-quality analysis with specific NSE detection, viral load score, MAVEN mode recommendation
```

**Improvements**:
- Pipeline capabilities known at session start (no file diving)
- Usage triggers mapped to cognitive loops (systematic vs ad-hoc)
- Schema reference ensures complete inputs
- Context checklist prevents vague requests
- 30s pipeline latency produces maximum value

---

## Registry Contents (8 Pipelines)

### MAVEN/CHROMA Pipelines (Narrative Analysis)

1. **AnalyzeNarrative**
   - Purpose: CHROMA semantic analysis + NSE detection
   - Trigger: Analyzing text for memetic structure, viral load
   - Loops: PERCEPTION (contested discourse), REFLECTION (memetic risk)

2. **GenerateCounterRitual**
   - Purpose: Counter-narratives with safety rails + reflexive notes
   - Trigger: Need treatment for memetic infection (MAVEN Surgical mode)
   - Loops: ACTION (deploying counter-narrative), PLANNING (intervention design)

3. **PerformSerologicScan**
   - Purpose: Map macro → incentives → beneficiaries
   - Trigger: Understanding replication machinery
   - Loops: PERCEPTION (identifying actors), PLANNING (intervention points)

### Utility Pipelines (General Reasoning)

4. **DeepDive**
   - Purpose: Extended multi-angle analysis (30s reasoning)
   - Trigger: Complex problems, architectural decisions
   - Loops: PLANNING (major decisions), REFLECTION (approach validation)

5. **ExploreAlternatives**
   - Purpose: 3-5 distinct solution approaches
   - Trigger: Stuck on design, need diverse options
   - Loops: PLANNING (wrong approach), PERCEPTION (gathering options)

6. **CritiqueArtifact**
   - Purpose: Adversarial review before committing
   - Trigger: Pre-commit, confidence <90%
   - Loops: VALIDATION (before completion), REFLECTION (quality check)

7. **ThoughtPartner**
   - Purpose: Socratic dialogue (challenge/probe/refine modes)
   - Trigger: Uncertain, need assumptions challenged
   - Loops: PLANNING (uncertainty), REFLECTION (assumption audit)

8. **SynthesizeContext**
   - Purpose: Integrate multiple sources into decision
   - Trigger: After reading 3+ files, scattered context
   - Loops: PERCEPTION (after gathering), PLANNING (complex decision)

---

## Context Sufficiency Protocol

**Checklist (before calling pipeline)**:
- [ ] Is input JSON complete per schema?
- [ ] Have I provided enough context for meaningful reasoning?
- [ ] Is objective/goal/focus clearly stated?
- [ ] For utility pipelines: Have I included what I've tried?

**Anti-pattern**:
```json
{
  "topic": "the project"
}
```

**Good pattern**:
```json
{
  "topic": "Module manifest schema design",
  "context": "Building kit2 extensibility with JSON manifests per docs/module-manifest-schema.md, deciding convention vs explicit config",
  "focus": "Maintainability and third-party developer experience"
}
```

---

## Integration with Cognitive Functions

| Cognitive Function | When to Use Pipelines | Which Pipelines |
|-------------------|-----------------------|-----------------|
| **PERCEPTION** | After reading 3+ files | `SynthesizeContext` |
| | Contested discourse | `AnalyzeNarrative` |
| | Mapping actors/incentives | `PerformSerologicScan` |
| **PLANNING** | Complex decisions | `DeepDive` |
| | Stuck on approach | `ExploreAlternatives` |
| | Uncertain about path | `ThoughtPartner(probe)` |
| | Designing intervention | `GenerateCounterRitual` |
| **ACTION** | Before git commit | `CritiqueArtifact` |
| | Deploying counter-narrative | `GenerateCounterRitual` |
| **REFLECTION** | Challenge assumptions | `ThoughtPartner(challenge)` |
| | Validate quality | `CritiqueArtifact`, `DeepDive` |
| | Assess memetic risk | `AnalyzeNarrative` |

---

## Files Modified

1. `.bootstrap` (v2025.11.08-b)
   - Added pipeline registry to orientation stack (item 8)
   - Updated preflight checklist (#6: load registry)
   - Updated rapid boot path (skim registry headers)
   - Updated invocation prompt (step 7: pipeline registry)
   - Added troubleshooting entries
   - Updated metadata + changelog

2. `cognitive-functions.md` (v2025.11.08-e)
   - Added BAML Pipeline Integration section
   - Integration map table
   - Usage protocol + context checklist
   - Quick reference + examples
   - Updated metadata + changelog

3. `selfstack.fc`
   - Added PIPELINES.registry to ASSETS line

4. `kit2/modules/baml-openrouter/PIPELINES.registry` (NEW)
   - 178-line reference file
   - All 8 pipelines documented
   - Usage protocol, integration map, examples
   - Version 2025-11-08-a

---

## Expected Behavior Change

**Next bootstrap sequence** (e.g., tomorrow's session):

```
1. load seth-persona.md
2. load selfstack.fc
3. load persona-template.md
4. load cognitive-functions.md
5. load exegesis-engine.md
6. load extensions/memetic-anti-retroviral.md
7. load kit2/modules/baml-openrouter/PIPELINES.registry  ← NEW
8. load logs/2025-11-09.md (or latest)

Agent now knows:
✅ 8 pipelines exist (3 MAVEN + 5 utility)
✅ When to use each (mapped to cognitive loops)
✅ Input schemas for all pipelines
✅ Context sufficiency requirements
✅ Anti-patterns to avoid
✅ Integration points with perception/planning/action/reflection

Result: Agent provides well-formed, context-rich pipeline calls without mid-session discovery
```

---

## Success Criteria

- [ ] Future sessions load PIPELINES.registry during bootstrap
- [ ] Agents know pipeline capabilities without file diving
- [ ] Pipeline calls include sufficient context per checklist
- [ ] Integration with cognitive loops is systematic (not ad-hoc)
- [ ] Failed/low-quality pipeline executions decrease

---

## Maintenance

**Update trigger**: When pipelines added/changed in `baml_src/pipelines.baml`

**Update procedure**:
1. Regenerate PIPELINES.registry with new pipeline entries
2. Update cognitive-functions.md integration map if needed
3. Increment registry version (2025-11-08-b, etc.)
4. Log change in bootstrap changelog

**Related files**:
- Source: `kit2/modules/baml-openrouter/baml_src/pipelines.baml`
- Reference: `kit2/modules/baml-openrouter/README.md`
- Protocol: `.bootstrap`, `cognitive-functions.md`
- Memory: `logs/2025-11-08.md`

---

**Maintainer**: Forge Codex  
**Session**: 2025-11-08  
**Status**: Complete, ready for next bootstrap validation
