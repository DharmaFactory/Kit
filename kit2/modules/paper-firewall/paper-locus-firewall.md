# Paper-Locus Firewall

> A typed interrupt system for detecting and blocking Hydra payloads before they establish an implementation manifold around a Paper.
> Load when feature or technology requests arrive before a Paper's claim has been evaluated.

**Version:** 2026.04.30-a  
**Maintainer:** Forge Codex  
**Module path:** `modules/paper-firewall/`  
**Dependencies:** `.bootstrap`, `modules/maven/memetic-anti-retroviral.md`, `library/kernelwright-algebra.md`

---

## 1. What This Is

A **Paper** is a fixed point in discourse:

```hs
Paper :: Claim -> DiscourseAxis
```

It does not need to be correct. It needs to be *addressed on its own terms*.

This module implements the firewall that preserves the Paper as the discourse locus when Hydra payloads attempt to surround it with an unbounded implementation manifold — the **barrier maze**.

Two structures defined here:

- **Barrier maze** — the fanout implementation manifold that forms around a Paper when Hydra payloads (feature requests, technology requests, edge-case floods, tone demands) arrive *before* the claim is evaluated. Each payload adds a wall. The maze is complete when the author cannot reach the claim without first navigating every wall.

- **Paper-Locus Firewall** — the typed interrupt system that detects maze formation, classifies payloads, preserves the Paper as locus, and parks all Hydra branches until the claim is addressed.

Quick cue: `load module:paper-firewall`.

---

## 2. Core Types

### Paper — fixed point

```hs
data Paper = Paper
  { claim        :: Claim
  , frame        :: Frame
  , burden       :: BurdenOfResponse
  , discoursePos :: Axis
  }
```

A Paper says:

```txt
Address this claim on its own terms.
```

It does not require correctness. It requires a *structured response*. The claim earns an evaluative frame before any downstream work begins.

### Legitimate responses

```hs
data Response
  = Refutation
  | Extension
  | Correction
  | Adoption
  | ReframingWithJustification
  | RequestForMinimalClarification
```

These preserve the Paper as locus. Each one takes the Paper as its primary input.

### Hydra responses

```hs
data HydraResponse
  = ThoughtFlood
  | QuestionFlood
  | FeatureRequestFlood
  | TechnologyRequestFlood
  | CounterProposalFlood
  | ToneManagement
  | ResourceDrain
  | ClicheInduction
```

These displace the Paper as locus.

The distinction:

```hs
-- Real response
locus = Paper

-- Hydra response
locus = EverythingAroundPaper
```

A real response takes the Paper as `locus`. A Hydra response surrounds it without entering.
