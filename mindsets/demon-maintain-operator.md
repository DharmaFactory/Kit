# Demon-Maintain Operator — Formal Specification

> **Operator ID**: O8  
> **Framework**: Field Theory of Meaning (v0)  
> **Status**: Operational specification with scan templates

---

## Formal Definition

**Signature**: `Demon : (broken_invariant, system) → apparent_invariant`

**Domain**: `(I_broken : failed_constraint, S : operational_system)`  
**Codomain**: `I_apparent : sustained_facade`

**Core mechanism**: Preserves the appearance of invariant `I` by:
1. **Cost export**: Displacing maintenance work to hidden locations
2. **Control loops**: Adding compensatory mechanisms that mask failure
3. **Aperture manipulation**: Excluding evidence that would expose the break

---

## Local Behavior (Δ)

### Detection signatures
When scanning frame `F_t` for demon activity:

```yaml
signals:
  - invariant_claim: "X always holds" 
  - contradictory_evidence: observable violations of X
  - persistence_mechanism: X-claims continue despite violations
  - cost_displacement: work appears elsewhere (staff, users, environment)
  - control_overhead: bureaucratic loops that "maintain standards"
```

### Observable patterns
- **Semantic gymnastics**: Redefinition to preserve claim ("that's not real X")
- **Gatekeeping**: Entry/exit barriers that exclude disconfirming cases  
- **Buffer zones**: Intermediate layers that absorb/transform contradictions
- **Ritual maintenance**: Repeated actions that don't address root cause
- **Scapegoating**: Blame exported to users/implementers for "misuse"

---

## Integral Effects (∫)

### System-level stabilization
Over time frames, demon-maintain produces:

1. **Institutional capture**: Original purpose subordinated to invariant-preservation
2. **Reality drift**: Growing gap between stated function and actual operation
3. **Cost accumulation**: Maintenance overhead compounds
4. **Fragility**: System becomes sensitive to demon-exposure
5. **Meta-demons**: Higher-order demons to hide the first-order ones

### Termination conditions
Demons collapse when:
- Cost export locations saturated/exhausted
- Control loop overhead exceeds benefit
- External audit penetrates aperture manipulation
- Competing system offers cheaper invariant-maintenance

---

## Distortion Profile

**Primary distortions**:
- **Authority confusion**: Who/what actually maintains the invariant becomes opaque
- **Causal reversal**: Effects (control mechanisms) presented as causes (natural properties)  
- **Metric gaming**: Measures optimized to show invariant rather than actual performance
- **Responsibility diffusion**: No single point accountable for maintenance costs

**Distortion measurement**:
```
D_demon = cost_hidden / cost_acknowledged + contradictions_suppressed / contradictions_total
```

---

## Scan Templates

### Template 1: Institutional Demon Scan
**Target**: Organizations, policies, procedures

```yaml
invariant_claimed: "[What does the system claim always works?]"
observable_failures: "[Where does it actually break?]"
cost_exports:
  - to_staff: "[Unpaid emotional labor, workarounds, burnout]"
  - to_users: "[Training burden, compliance costs, blamed outcomes]" 
  - to_environment: "[Externalized resources, pollution, debt]"
control_mechanisms:
  - gatekeeping: "[Who/what gets excluded to maintain the claim?]"
  - redefinition: "[How are violations reclassified as non-violations?]"
  - ritual: "[What repeated actions substitute for actual fixes?]"
demon_maintenance_cost: "[Resources devoted purely to preserving appearance]"
```

### Template 2: Narrative Demon Scan  
**Target**: Claims, slogans, ideologies

```yaml
narrative_invariant: "[What story must never change?]"
contradictory_evidence: "[What facts threaten this story?]"
aperture_manipulation:
  - excluded_voices: "[Who is not allowed to speak?]"
  - excluded_timeframes: "[What historical periods are ignored?]"
  - excluded_scales: "[What levels of analysis are forbidden?]"
compensation_mechanisms:
  - explanation_work: "[How much effort goes into maintaining story coherence?]"
  - enforcement_work: "[What happens to people who point out contradictions?]"
  - ritual_reinforcement: "[What ceremonies/practices keep story alive?]"
```

### Template 3: Technical Demon Scan
**Target**: Code, systems, specifications

```yaml
technical_invariant: "[What property must the system always have?]"
actual_violations: "[Where does the system actually violate this?]"
workarounds:
  - user_burden: "[What do users have to do to make it work?]"
  - maintenance_overhead: "[Hidden complexity to preserve interface?]"
  - performance_costs: "[Speed/resource penalties for invariant maintenance?]"
abstraction_leaks:
  - error_confusion: "[Do error messages reflect actual causes?]"
  - interface_lies: "[What does the API promise vs deliver?]"
  - documentation_gaps: "[What critical details are omitted?]"
```

---

## Applied Example: Higher Education "Meritocracy" Demon

**Invariant claimed**: "Academic success reflects individual merit and effort"

**Observable failures**:
- Strong correlation with family income, zip code, parental education
- Advantage compounds across institutions (prep schools → elite colleges → grad schools)
- Same student performance rated differently based on perceived demographics

**Cost exports**:
- **To students**: Debt, stress, self-blame for structural barriers
- **To families**: Financial strain, relationship tension around "achievement"  
- **To society**: Talent waste, inequality reproduction, social instability

**Control mechanisms**:
- **Gatekeeping**: SAT/testing apparatus excludes discussion of structural advantages
- **Redefinition**: Advantages reclassified as "background" or "preparation" rather than unfairness
- **Ritual**: Endless individual advice ("work harder", "get tutoring") substitutes for structural change

**Demon maintenance cost**: 
- Multi-billion testing industry
- Admissions bureaucracy focused on "holistic" evaluation that preserves outcomes
- Counseling/therapy industry for student stress/failure attribution

**Measurement**: `D_demon ≈ 0.8` (high hidden costs, high contradiction suppression)

---

## Usage Protocol

1. **Select target system** (institution, narrative, technical artifact)
2. **Apply relevant scan template** 
3. **Map cost flows** using aperture analysis (what's excluded?)
4. **Trace control loops** that preserve invariant despite violations
5. **Calculate demon maintenance overhead** vs. alternative approaches
6. **Document distortion profile** and termination conditions

**Output format**: Structured demon profile with observables, costs, and intervention points

---

## Integration Notes

- Pairs with **AnalyzeNarrative** BAML pipeline for narrative demon detection
- Uses **Aperture** analysis (N4) to identify excluded evidence
- Feeds into **Counter-ritual** design for demon disruption
- Links to **Cost accounting** primitives (P4, P6)

**File created**: 2026-01-18  
**Next**: Apply scan templates to concrete systems