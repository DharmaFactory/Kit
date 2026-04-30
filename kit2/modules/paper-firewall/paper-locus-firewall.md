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

---

## 4. The Barrier Maze

The barrier maze is the implementation manifold that forms when Hydra payloads arrive before `ClaimGate` is passed. Each payload adds a wall between the author and the Paper's claim. The maze is complete when no path to the claim remains clear.

```
                  FeatureBacklog
                 /
Paper ——► ClaimGate ——?——► [walls form] ——► [author exhausted]
                 \
                  TechManifold
                 /
               MetricsDemand
```

Suppression via barrier maze:

```hs
Paper
  -> FeatureHydra
  -> ImplementationFanout
  -> AuthorResourceDrain
  -> AxisAbandonment
```

The Paper was not answered. It was product-managed to death.

### Suppression state machine

```hs
data SuppressionState
  = PaperStaked
  | HydraLaunched
  | AuthorDefending
  | LocusLost
  | ResourceDrained
  | PaperAbandoned
  | SuppressionNaturalized
```

Transitions:

```hs
PaperStaked       -> HydraLaunched
  via QuestionFlood | FeatureFlood | TechnologyFlood

HydraLaunched     -> AuthorDefending
  via defensive burden shift

AuthorDefending   -> LocusLost
  via recursive YHydra loop

LocusLost         -> ResourceDrained
  via emotional / material cost vampirism

ResourceDrained   -> PaperAbandoned
  via self-silencing / cliché induction

PaperAbandoned    -> SuppressionNaturalized
  via "it was never answered because it wasn't ready"
```

The cover function wraps each transition so the outside observer sees normal discourse:

| Transition | Appears As |
|-----------|-----------|
| `PaperStaked -> HydraLaunched` | "Raising good questions" |
| `HydraLaunched -> AuthorDefending` | "Healthy scrutiny" |
| `AuthorDefending -> LocusLost` | "The discussion evolved" |
| `LocusLost -> ResourceDrained` | "The author got tired" |
| `ResourceDrained -> PaperAbandoned` | "It wasn't ready" |
| `PaperAbandoned -> SuppressionNaturalized` | "That's just how it went" |

### Conducive suppression field

A Hydra does not require malicious intent in every participant. It needs a field whose conditions lead toward abandonment:

```hs
data ConduciveSuppressionField = ConduciveSuppressionField
  { ambiguity       :: High
  , emotionalCost   :: High
  , statusRisk      :: High
  , questionVolume  :: High
  , authorityNoise  :: High
  , supportLow      :: Bool
  , locusControl    :: Weak
  }
```

Under these conditions, abandonment is reinterpreted as maturity:

```txt
"Maybe this is too complicated."
"Maybe I should build more first."
"Maybe I should answer all objections."
"Maybe I should soften the claim."
"Maybe I should wait."
```

The Hydra wins when abandonment is reinterpreted as wisdom.

### Cliché inducers

The most efficient suppression is self-suppression. The inducer is sufficient — the suppressor need not speak the silencing word:

```hs
data ClicheInducer
  = Fatigue
  | Shame
  | Isolation
  | StatusThreat
  | ExcessiveQuestions
  | ForcedPoliteness
  | ProductizationBurden
  | TechnicalOverload
  | AmbiguousAuthority
```

```hs
induce :: ClicheInducer -> Target -> SelfSilencing
```

The Paper is not refuted. It is self-muted. The author says:

```txt
"Maybe it's not ready."
"Maybe I need more evidence."
"Maybe I should not push."
```

These are thought-terminating clichés generated by the target under field pressure, not by the suppressor.

---

## 5. The Detector — Paper-Locus Preservation

The central detector question is not "are these bad moves?" It is:

```txt
Are these responses preserving the Paper as locus,
or displacing it into an unbounded implementation manifold?
```

```hs
preservesPaperLocus :: Response -> Paper -> Bool
```

### Locus-preserving moves

```hs
data LocusPreservingMove
  = DirectlyAddressesClaim
  | TestsClaim
  | RefutesClaim
  | ClarifiesMinimalTerm
  | ProvidesEvidence
  | NamesConcreteImplication
  | RequestsBoundedNextStep
```

### Locus-displacing moves

```hs
data LocusDisplacingMove
  = OpensUnboundedImplementationManifold
  | DemandsProductizationBeforeRecognition
  | MultipliesQuestionsWithoutPriority
  | ConvertsClaimIntoLabor
  | SwitchesToTone
  | SwitchesToAuthority
  | SwitchesToRoadmap
  | SwitchesToPrematureMetrics
```

### detectHydra

```hs
detectHydra
  :: Paper
  -> [Response]
  -> HydraRisk

detectHydra paper responses =
  if many LocusDisplacingMove && few LocusPreservingMove
    then HighHydraRisk
    else LowHydraRisk
```

### Risk thresholds

| Risk Level | Condition | Firewall Action |
|------------|-----------|-----------------|
| `LowHydraRisk` | Most responses preserve locus | Continue |
| `ModerateHydraRisk` | Locus-displacing moves ≥ 2 | Log + monitor |
| `HighHydraRisk` | Displacing moves > preserving moves | Activate firewall |
| `MazeForming` | YHydra loop detected (responses spawn payloads) | Interrupt + PaperFirst |

### Classifying technology and feature requests

A technology or feature request is classified as `LocusDisplacingMove` when it:
- arrives before `ClaimGate` is passed, **and**
- cannot be answered with a single bounded sentence that directly tests the claim

It is classified as `LocusPreservingMove` when:

```hs
minimalFeasibilityProbe :: TechnologyRequest -> BoundedProbe
```

can be stated in one sentence and directly tests the claim.

The request is not the problem. The timing and scope are.

### Feature/technology suppression examples

**Example A — invisible cost paper:**

```txt
Paper: "The process drains authors before their claims are evaluated."

Hydra: "Can you build a tool to measure drain? What metrics?
        What dashboard? How would this integrate with Slack?
        How would managers use it? Can it be A/B tested?"

Containment: "Those are downstream feature questions.
              The current question is whether drain-before-evaluation is a real pattern.
              The smallest useful probe is to compare response burden
              before and after claim contact."
```

**Example B — security blind spot paper:**

```txt
Paper: "Vendor severity without temporal intelligence context misleads analysts."

Hydra: "Which vendors? What API? What dashboard? What integrations?
        What scoring formula? What legal liability?
        How would SOC teams configure it?"

Containment: "Those questions matter after the claim is accepted.
              The root claim is that missing time-context creates severity ambiguity.
              The smallest probe is one advisory where publish date,
              first-seen date, and recent resurgence diverge."
```

**Example C — the self-exemplifying paper (this paper):**

```txt
Paper: "Feature requests can suppress conceptual work
        by turning it into backlog labor."

Hydra: "Can you make a feature to detect that?
        What UI? What data model? What training set?"

Containment: "That is the phenomenon itself.
              We will name it first, then define a bounded detector."
```
