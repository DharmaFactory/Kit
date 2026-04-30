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

---

## 3. Hydra — MIRV Taxonomy

A Hydra is launched at a Paper. It separates into independently targeted payloads, each rational in isolation, collectively forming a SuppressionField.

```hs
Hydra :: Paper -> NonEmpty HydraPayload -> SuppressionField
```

```hs
data HydraPayload
  = ThoughtPayload        Thought
  | QuestionPayload       Question
  | FeaturePayload        FeatureRequest
  | TechnologyPayload     TechnologyRequest
  | CounterProposalPayload Proposal
  | TonePayload           ToneDemand
  | ProcessPayload        ProcessDemand
  | SocialPayload         SocialPressure
```

The Hydra's success condition is not:

```hs
PaperRefuted
```

It is:

```hs
PaperNoLongerPressed
```

That distinction is crucial. The Paper is not answered. It is rendered inert by surrounding it.

### Cover function

Each Hydra payload has a legitimate surface form. This is what makes it difficult to name:

```hs
cover :: SuppressionMove -> LegitimateSurface
```

| Suppression Move | Legitimate Surface |
|------------------|--------------------|
| `QuestionFlood` | Due diligence |
| `FeatureFlood` | Product thinking |
| `TechnologyFlood` | Engineering rigor |
| `ToneManagement` | Civility |
| `CounterProposal` | Collaboration |
| `Delay` | Prudence |
| `EmotionalDrain` | Care / Concern |
| `ProcessDemand` | Governance |

The detector cannot ask "are questions bad?" It must ask: *are these preserving the Paper as locus, or displacing it into an unbounded manifold?*

### Y-Hydra — self-replicating suppression loop

```hs
yHydra :: (Response -> Hydra) -> Hydra
```

Every attempt to answer a Hydra payload generates new payloads:

```hs
answerQuestion       -> MoreQuestions
describeFeature      -> MoreFeatureRequests
nameConstraint       -> MoreEdgeCases
clarifyTone          -> MoreToneDemands
proposePrototype     -> MoreTechnologyQuestions
showEvidence         -> MoreEvidenceStandards
```

The suppression loop:

```hs
HydraPayload
  -> DefensiveResponse
  -> NewHydraPayloads
  -> MoreDefensiveResponse
  -> Exhaustion
```

The loop contains the instruction for its own continuation. The author cannot isolate the loop from inside it — the very act of answering supplies the next branch.

### Technology Hydra

```hs
data TechnologyHydra = TechnologyHydra
  { requestedMechanisms :: [Mechanism]
  , unresolvedClaim     :: Paper
  , burdenShift         :: BurdenShift
  }
```

Failure mode: **`ImplementationBeforeRecognition`**.

The pattern:

```txt
"Interesting claim. Can you build the tool?
 Can it scale? What stack? What APIs?
 What about edge cases? What about compliance?
 What about adversarial use?"
```

Each question is rational in isolation. Together they are a MIRV. The Paper asked whether an axis is real; the Hydra demands that the axis be implemented before that question is answered.

### Feature Hydra

```hs
data FeatureHydra = FeatureHydra
  { featureRequests        :: NonEmpty FeatureRequest
  , displacedPaper         :: Paper
  , productizationPressure :: Pressure
  }
```

The move:

```txt
Your claim matters only if it becomes a feature.
```

The Paper asked: "What is true about this system?"  
The Hydra replies: "What would the UI look like?"

That is a category shift — from epistemics to product.

### Product suppression variants

```hs
data ProductSuppression
  = TechnologyManifoldSuppression
  | FeatureBacklogSuppression
  | MetricsDemandSuppression
  | RoadmapDeferralSuppression
  | FeasibilityBurdenSuppression
```

All five are instances of `DeflectClaimIntoImplementationManifold`.
