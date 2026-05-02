# Module & Mindset Manifest Schema

> Proposed conventions for discoverable modules and mindsets in KIT2 layout.
> Version: 2025.11.06-a

---

## Purpose

Enable automated discovery and suggestion of modules/mindsets based on:
- Task context
- Trigger keywords
- Dependency relationships
- Compatibility requirements

---

## Module Manifest Schema

**Location**: `modules/[module-name]/manifest.json`

```json
{
  "name": "MAVEN",
  "fullName": "Memetic Anti-retroViral Extension Node",
  "version": "2025.11.05-alpha",
  "type": "module",
  "primaryFile": "memetic-anti-retroviral.md",
  "description": "Detects, classifies, and treats memetic retroviruses in discourse",
  "maintainer": "Forge Codex",
  "dependencies": [
    "core/cognition/cognitive-functions.md",
    "library/exegesis-engine.md"
  ],
  "triggers": {
    "keywords": ["narrative", "discourse", "memetic", "propaganda", "retrovirus"],
    "contexts": ["discourse analysis", "cultural binaries", "narrative warfare"],
    "autoLoad": false,
    "requiredFor": ["discourse work", "memetic analysis"]
  },
  "modes": [
    "Sentinel",
    "Surgical",
    "Quarantine",
    "Inoculation"
  ],
  "logTags": ["#containment", "#module"],
  "quickLoadSection": 9,
  "documentation": {
    "quickstart": "Load when memetic risk > 0.3 or cultural binaries appear",
    "integration": "Pairs with CHROMA for semantic analysis",
    "examples": ["cases/basin-of-attraction/dissection.md"]
  },
  "metadata": {
    "collateralRiskBaseline": 0.1,
    "requiresReflexiveNote": true
  }
}
```

### Required Fields

- `name`: Short identifier (matches directory name)
- `version`: Semantic version string
- `type`: `"module"` or `"mindset"`
- `primaryFile`: Main documentation file to load
- `description`: One-sentence summary
- `triggers`: When to suggest loading

### Optional Fields

- `maintainer`: Who maintains this module
- `dependencies`: Files that must load first
- `modes`: Available operational modes
- `logTags`: Tags to use when logging activation
- `quickLoadSection`: Section number in primary file with summary
- `documentation`: Links to guides/examples
- `metadata`: Module-specific metadata

---

## Mindset Manifest Schema

**Location**: `mindsets/[mindset-name].md` (YAML frontmatter or inline metadata section)

### YAML Frontmatter Option

```yaml
---
name: NSE
fullName: Narrative Scarcity Engine Disassembly
version: 2025.11.06-a
type: mindset
maintainer: Forge Codex
description: Detects and dismantles manufactured scarcity narratives
triggers:
  keywords: [scarcity, exclusivity, FOMO, artificial limits, thrill]
  contexts: [gambling, travel hype, limited drops, invite-only]
  autoLoad: false
dependencies:
  - modules/maven/memetic-anti-retroviral.md
modes:
  - Spark
  - Clarify
  - Generalize
  - Instrument
  - Replace
  - Reflect
logTags: [#mindset, #containment]
sections:
  loadRitual: 2
  heuristic: 5
  counterRitual: 7
  deactivation: 10
collateralRiskBaseline: 0.2
---
```

### Inline Metadata Section Option

If YAML frontmatter isn't feasible, include metadata section:

```markdown
## Mindset Metadata

- **Name**: NSE
- **Full Name**: Narrative Scarcity Engine Disassembly
- **Version**: 2025.11.06-a
- **Type**: mindset
- **Triggers**: scarcity, exclusivity, FOMO, artificial limits, thrill
- **Dependencies**: modules/maven/memetic-anti-retroviral.md
- **Log Tags**: #mindset, #containment
- **Collateral Risk Baseline**: 0.2
```

---

## Discovery Protocol

### 1. Bootstrap Scan

On bootstrap, agent should:

```
1. List modules/ directory
2. For each subdirectory:
   - Check for manifest.json
   - If present, parse and cache metadata
   - If absent, scan primary .md file for metadata section
3. List mindsets/ directory
4. For each .md file:
   - Check for YAML frontmatter or metadata section
   - Parse and cache metadata
```

### 2. Context Matching

When task context is established:

```
1. Extract keywords from task description
2. Match against module/mindset triggers
3. Score matches:
   - Exact keyword match: +2
   - Context match: +1
   - Dependency already loaded: +1
   - autoLoad=true: +3
4. Sort by score
5. Present top 3 suggestions to human
```

### 3. Activation Protocol

When human approves module/mindset:

```
1. Load dependencies first (recursive)
2. Load primary file
3. Log activation with specified tags
4. If module has modes, suggest default mode
5. If mindset has load ritual, execute it
```

---

## Example Discovery Session

**Task**: "Analyze the recent AI safety discourse for memetic patterns"

**Agent reasoning**:
```
Keywords extracted: analyze, discourse, memetic, patterns
Scanning modules/...
  - MAVEN: triggers match ["discourse", "memetic"] → score: 4
  - CHROMA: triggers match ["discourse"] → score: 1
Scanning mindsets/...
  - NSE: triggers match ["discourse"] (weak) → score: 1
  - Emberkind: no match → score: 0

Suggestion: Load MAVEN (score: 4) for memetic discourse analysis.
Optional: Load CHROMA (score: 1) if metaphor-heavy.
```

**Human**: "Load MAVEN"

**Agent executes**:
```
1. Check dependencies: cognitive-functions.md ✓, exegesis-engine.md ✓
2. Load modules/maven/memetic-anti-retroviral.md
3. Log: ['] `#containment #module` — MAVEN engaged (Sentinel mode)
4. Ready for memetic analysis
```

---

## Module/Mindset Toggling Mechanism

### Config File Option

**Location**: `kit2/.config.json`

```json
{
  "modules": {
    "maven": {
      "enabled": true,
      "autoLoad": false,
      "defaultMode": "Sentinel"
    },
    "chroma": {
      "enabled": true,
      "autoLoad": false
    }
  },
  "mindsets": {
    "nse": {
      "enabled": true,
      "autoLoad": false
    },
    "emberkind": {
      "enabled": true,
      "autoLoad": false
    }
  },
  "discovery": {
    "enabled": true,
    "suggestionThreshold": 2
  }
}
```

### Bootstrap Command Option

Add commands to bootstrap interaction:

```
load module:maven           # Load MAVEN explicitly
load mindset:nse            # Load NSE mindset
list modules                # Show available modules
list mindsets               # Show available mindsets
suggest modules [context]   # Suggest based on context
toggle module:chroma on     # Enable module for auto-discovery
```

### Recommended Approach

**Hybrid**:
1. Use `.config.json` for persistent preferences (which modules are enabled)
2. Use discovery protocol for suggestions (triggered by task context)
3. Use log tags for session-specific activation (what's currently loaded)
4. Use bootstrap commands for manual control

---

## Implementation Checklist

- [ ] Create manifest.json for MAVEN module
- [ ] Create manifest.json for CHROMA module
- [ ] Add YAML frontmatter to NSE mindset
- [ ] Add YAML frontmatter to Emberkind mindset
- [ ] Create .config.json template
- [ ] Document bootstrap commands in .bootstrap
- [ ] Test discovery protocol with sample task contexts
- [ ] Add discovery automation to tools/ directory

---

## Future Enhancements

1. **Compatibility Matrix**: Track which modules/mindsets work well together
2. **Version Dependencies**: Specify minimum versions for dependencies
3. **Performance Metrics**: Track effectiveness (viral load reduction, coherence scores)
4. **Community Registry**: Shared catalog of community-contributed modules/mindsets
5. **Hot-Reload**: Update modules without full bootstrap restart
6. **Module Composition**: Combine multiple modules into meta-modules

---

**Document version**: 2025.11.06-a
**Author**: Claude (Forge Codex substrate)
**Status**: Proposal for KIT2 infrastructure
**Next**: Create sample manifests, test discovery, iterate schema
