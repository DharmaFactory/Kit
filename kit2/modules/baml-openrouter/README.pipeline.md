# BAML Pipeline Documentation

Documentation for the three core MAVEN/CHROMA analysis pipelines.

---

## Pipeline Overview

| Pipeline | Input | Output | Use Case |
|----------|-------|--------|----------|
| `AnalyzeNarrative` | snippet, objective | NarrativeProbe | CHROMA semantic analysis + NSE detection |
| `GenerateCounterRitual` | infection_pattern, desired_outcome | CounterRitual | Counter-narrative generation with safety rails |
| `PerformSerologicScan` | snippet | SerologicScan | MAVEN serologic scan (macro → incentives → beneficiaries) |

---

## 1. AnalyzeNarrative

**Purpose**: Implements CHROMA (semantic chroma-key) and NSE (Narrative Scarcity Engine) detection protocols.

**Input Schema**:
```json
{
  "snippet": "Text to analyze",
  "objective": "Analysis objective (e.g., 'NSE scan', 'CHROMA analysis')"
}
```

**Output Schema (NarrativeProbe)**:
```typescript
{
  foreground: string        // Primary surface-level narrative or claim
  chroma: string           // Semantic chroma key - background assumption
  multiplicity: string[]   // Distinct narrative layers detected
  viral_load: number       // Memetic viral load score 0.0-1.0
  maven_mode: string       // Recommended MAVEN mode
  analysis: string         // Detailed analysis
}
```

**Example Usage**:
```bash
npm run pipeline -- --pipeline AnalyzeNarrative --input '{"snippet":"Act now before this opportunity disappears forever!","objective":"NSE scan"}'
```

---

## 2. GenerateCounterRitual

**Purpose**: Creates counter-narratives that treat memetic infections while maintaining full transparency about own memetic payload.

**Input Schema**:
```json
{
  "infection_pattern": "Description of the memetic pattern to counter",
  "desired_outcome": "What outcome you want to achieve"
}
```

**Output Schema (CounterRitual)**:
```typescript
{
  catalytic_option: string      // Bold counter-narrative with mechanism
  safety_rail: string           // Rollback plan, consent, measurement
  ritual_hook: string           // Repeatable action embedding immunity
  reflexive_note: string        // Transparent note about our payload
  collateral_risk: number       // Likelihood we become retrovirus (0-1)
  follow_up_trigger: string     // When to reevaluate
}
```

**Example Usage**:
```bash
npm run pipeline -- --pipeline GenerateCounterRitual --input '{"infection_pattern":"Artificial urgency via limited availability","desired_outcome":"Replace FOMO with sustainable access"}'
```

---

## 3. PerformSerologicScan

**Purpose**: MAVEN tool for mapping macro → incentives → beneficiaries to understand memetic replication machinery.

**Input Schema**:
```json
{
  "snippet": "Text snippet to scan for memetic patterns"
}
```

**Output Schema (SerologicScan)**:
```typescript
{
  macro_name: string           // Master signifier (S1) spreading
  host_identity: string        // Primary carrier demographic
  incentive_surface: string    // What drives replication
  replication_channel: string  // Primary medium enabling spread
  beneficiaries: string[]      // Who gains from spread
  weak_link: string           // Where to intervene
  viral_load: number          // Memetic viral load 0.0-1.0
}
```

**Example Usage**:
```bash
npm run pipeline -- --pipeline PerformSerologicScan --input '{"snippet":"Limited time! Only 3 spots left!"}'
```

**Example Output**:
```json
{
  "macro_name": "scarcity",
  "host_identity": "Online marketers, direct-response advertisers...",
  "incentive_surface": "Fear of missing out (FOMO), urgency-driven...",
  "replication_channel": "Digital marketing funnels...",
  "beneficiaries": [
    "Marketers running urgency-based campaigns",
    "Businesses seeking higher conversion rates",
    "Affiliate marketers rewarded per sale",
    "Ad platforms benefiting from increased spend"
  ],
  "weak_link": "Transparency injection and verification...",
  "viral_load": 0.78
}
```

---

## Pipeline Aliases

The CLI accepts multiple names for convenience:

- **AnalyzeNarrative**: `AnalyzeNarrative`, `analyze_narrative`, `probe_narrative`
- **GenerateCounterRitual**: `GenerateCounterRitual`, `generate_counter_ritual`, `draft_counter`
- **PerformSerologicScan**: `PerformSerologicScan`, `perform_serologic_scan`, `serologic_scan`

---

## Integration with MAVEN/CHROMA

These pipelines implement the core MAVEN (Memetic Anti-retroViral Extension Node) and CHROMA (semantic chroma-key) protocols from `extensions/memetic-anti-retroviral.md` and `extensions/semantic-chroma-engine.md`.

**Workflow Example**:

1. **Detect**: Use `PerformSerologicScan` to analyze a narrative snippet
2. **Analyze**: If viral_load > 0.5, use `AnalyzeNarrative` for deeper CHROMA analysis
3. **Counter**: If intervention needed, use `GenerateCounterRitual` to design response
4. **Log**: Record results in session log with `#containment` tag and MAVEN mode

---

## MCP Tool Integration

Once registered as an MCP tool (see `tools/mcp-baml.json`), you can invoke these from Claude Code:

```javascript
// From Claude Code or any MCP-compatible client
await baml_router({
  pipeline: "PerformSerologicScan",
  input: JSON.stringify({ snippet: "Your text here" })
});
```

See main README.md for MCP registration instructions.
