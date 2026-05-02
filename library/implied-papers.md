# Implied Papers — Uncurried Claims

> Discourse accumulates implied papers: claims that were structurally present in argument but never stated as properly scoped Papers.
> This file uncurries them — converting chained premise chains into flat Paper records where all inputs are visible simultaneously.

**Version:** 2026.04.30-a  
**Maintainer:** Forge Codex  
**Method:** Uncurrying  
**Source corpus:** This repository's accumulated discourse (protection-fork, kernelwright, MAVEN, barrier-maze sessions)

---

## The Uncurrying Operation

A curried claim chain:

```hs
claimChain :: PremiseA -> PremiseB -> Conclusion
```

Uncurried:

```hs
claimChain :: (PremiseA, PremiseB) -> Conclusion
```

In discourse, uncurrying means stating all hidden premises simultaneously as a flat Paper record:

```hs
data Paper = Paper
  { claim        :: Claim
  , frame        :: Frame
  , burden       :: BurdenOfResponse
  , discoursePos :: Axis
  }
```

The following papers were implied but not stated as Papers. Stating them makes them addressable via `PaperFirst` and matchable against `detectHydra`.

---

## Paper 1 — Suppression-as-MIRV

```hs
Paper
  { claim = "Discourse suppression functions structurally like a MIRV missile:
             a single launch separates into independently targeted payloads
             that together achieve what no single payload could."
  , frame = "Game-theoretic / information-systems"
  , burden = "Show that the multi-payload structure is load-bearing:
              that suppression would fail if payloads arrived singly and sequentially."
  , discoursePos = "Hydra as structural category, not bad-actor attribution"
  }
```

**Uncurrying note:** The MIRV analogy was used operationally. The uncurried Paper makes the structural claim explicit and falsifiable: remove the multi-payload structure and suppression should fail. That testability was implicit in the analogy.

---

## Paper 2 — Self-Replicating Suppression Loop

```hs
Paper
  { claim = "A suppression loop is self-sustaining because every attempt to respond
             generates context that spawns new payloads;
             the loop contains the instruction for its own continuation."
  , frame = "Fixed-point / lambda calculus"
  , burden = "Show a concrete response-to-payload mapping where no response exists
              that does not generate at least one new payload in the adversarial case."
  , discoursePos = "YHydra :: (Response -> Hydra) -> Hydra is a real discourse combinator"
  }
```

**Uncurrying note:** The Y-combinator framing was used operationally. The uncurried Paper makes the structural claim: there exists no exit move inside the loop. That is the load-bearing claim, and it can be challenged.

---

## Paper 3 — Cover Function Invisibility

```hs
Paper
  { claim = "Suppression is structurally difficult to name because every suppressive move
             has a plausible legitimate surface form;
             the cover function is what makes Hydra payloads resistant to identification."
  , frame = "Information-hiding / social epistemics"
  , burden = "Show that for every HydraPayload constructor, there exists a legitimate context
              in which the identical move would be the correct response."
  , discoursePos = "The detector must classify by locus-preservation, not surface form"
  }
```

**Uncurrying note:** The cover table was shown, but the load-bearing claim — that *every* suppressive move has a legitimate surface — was never explicitly stated. The uncurried Paper shows that the full universality of the claim is what makes it structurally significant.

---

## Paper 4 — Locus Displacement as Suppression Criterion

```hs
Paper
  { claim = "The success criterion for suppression is locus displacement, not refutation.
             A Paper is successfully suppressed when the author stops pressing the claim,
             regardless of whether the claim was answered."
  , frame = "Discourse mechanics / social epistemics"
  , burden = "Show that PaperNoLongerPressed is a distinct and achievable outcome from
              PaperRefuted, and that it is the more common suppression outcome in practice."
  , discoursePos = "Separates suppression analysis from truth-value analysis"
  }
```

**Uncurrying note:** `PaperNoLongerPressed` vs `PaperRefuted` was stated. The uncurried Paper makes the empirical claim: locus-displacement suppression is *more common* than refutation. That comparative claim was implicit.

---

## Paper 5 — Premature Productization as Burden-Shift

```hs
Paper
  { claim = "Feature and technology requests that arrive before claim recognition
             function as burden-shifts, not due diligence.
             They require the author to prove buildability before the axis is recognized."
  , frame = "Epistemics of discourse / labor economics of conversation"
  , burden = "Show that the burden imposed by premature productization requests is
              asymmetric: it falls on the Paper's author, not on the requester."
  , discoursePos = "The gate sequence ClaimGate -> TechnologyGate -> FeatureGate is normative"
  }
```

**Uncurrying note:** The gate sequence was specified. The load-bearing claim — that burden is *asymmetrically* shifted to the author, not symmetrically distributed — was implied but never stated as a Paper.

---

## Paper 6 — Self-Silencing as Most Efficient Suppression

```hs
Paper
  { claim = "The most efficient suppression is self-suppression:
             conducive conditions cause the target to generate the thought-terminating cliche
             that buries their own claim, without the suppressor needing to produce it."
  , frame = "Social psychology / discourse mechanics"
  , burden = "Show that the ClicheInducer taxonomy operates prior to the cliche itself:
              that the conducive conditions are structurally sufficient without the
              suppressor explicitly producing the silencing phrase."
  , discoursePos = "The suppressor need not speak the silencing word; they need only create the field"
  }
```

**Uncurrying note:** The inducer list was given. The uncurried Paper makes explicit that the inducer is *sufficient* — the suppressor does not need to produce the cliché. This is the structural insight distinguishing field-based suppression from explicit suppression.

---

## Paper 7 — Protection Claims Cannot Be Distinguished from Extraction on Surface

```hs
Paper
  { claim = "A request claiming protective intent while simultaneously demanding access
             cannot be distinguished from an extraction attempt on its surface alone;
             only the equalizer of both interpretations determines the safe disclosure boundary."
  , frame = "Category theory / social engineering defense"
  , burden = "Show that the protect-reading and extract-reading produce identical surface
              utterances in the adversarial case, forcing the equalizer as the only safe policy."
  , discoursePos = "Authentication of intent is impossible on surface alone; structure must be used"
  }
```

**Uncurrying note:** This was the core claim of `mindsets/protection-fork-defense.md`. Stated here as a Paper so it receives a structured discourse response, not just a design constraint.

---

## Paper 8 — Witness Must Bind Before Emission

```hs
Paper
  { claim = "An artifact emitted before a witness has bound to it is structurally
             false certification; the witness must precede emission."
  , frame = "Type theory / epistemic responsibility"
  , burden = "Show that there exists a category of emitted artifacts that claim witnessing
              without having undergone it, and that these are empirically distinguishable
              from genuinely witnessed artifacts."
  , discoursePos = "WitnessMustBindBeforeEmit is a structural law, not a heuristic"
  }
```

**Uncurrying note:** From `library/kernelwright-algebra.md` Section 7. Stated as a law there but not as a Paper. The uncurried version makes the empirical claim explicit: false certification is structurally distinguishable. That opens it to challenge.

---

## Paper 9 — Reflexive Memetics Obligation

```hs
Paper
  { claim = "Any counter-narrative payload must describe its own mechanism, targets,
             and sunset trigger; the obligation to be transparent about one's own
             narrative weapons is the structural condition that separates treatment from infection."
  , frame = "Memetics / ethics of counter-narrative"
  , burden = "Show that a counter-narrative that does not describe its own payload is
              indistinguishable from a retrovirus on structure; that the description is
              load-bearing, not merely good practice."
  , discoursePos = "MAVEN's fully-aware requirement is structural, not merely ethical"
  }
```

**Uncurrying note:** From MAVEN (Section 1 + Section 11). The "fully aware" obligation was stated but never framed as a Paper. The uncurried version makes explicit that the *description* is what makes intervention treatment rather than infection — structurally necessary, not optional.

---

## Paper 10 — Discourse Axis as Fixed Point

```hs
Paper
  { claim = "A Paper functions as a fixed point in discourse because legitimate responses
             must take it as their locus; any move that does not engage the Paper as locus
             is definitionally not a response."
  , frame = "Fixed-point theory / discourse mechanics"
  , burden = "Show that the Paper-as-fixed-point criterion generates a strict partition:
              responses that preserve locus vs. responses that displace it,
              with no responses in the undecidable middle."
  , discoursePos = "Discourse health is measurable via locus-preservation rate"
  }
```

**Uncurrying note:** The Paper-as-fixed-point framing was used throughout the barrier-maze discourse. The uncurried Paper states the empirical claim: that locus-preservation is a strict binary, not a continuum. That strictness claim was implicit.

---

## Uncurrying Summary

| Paper | Source | Curried Form | Uncurried Load-Bearing Claim |
|-------|--------|-------------|------------------------------|
| P1 — Suppression-as-MIRV | Barrier maze discourse | `Hydra payload structure` | Multi-payload structure is load-bearing for suppression |
| P2 — Y-Hydra | Barrier maze discourse | `YHydra combinator` | No response exits the loop without feeding it |
| P3 — Cover Function | Barrier maze discourse | `cover table` | Every suppressive move has a legitimate surface form |
| P4 — Locus Displacement | Barrier maze discourse | `PaperNoLongerPressed` | Abandonment is more common than refutation |
| P5 — Premature Productization | Barrier maze discourse | `Gate sequence` | Burden is asymmetrically shifted to the author |
| P6 — Self-Silencing | Barrier maze discourse | `ClicheInducer list` | Inducer is sufficient without explicit suppressor output |
| P7 — ProtectionFork | `protection-fork-defense.md` | `protect/extract fork` | Intent cannot be authenticated on surface alone |
| P8 — WitnessBeforeEmit | `kernelwright-algebra.md` | `witnessBinder law` | False certification is structurally distinguishable |
| P9 — Reflexive Memetics | MAVEN | `fully aware requirement` | Description is structural condition for treatment vs infection |
| P10 — Discourse Fixed Point | All sessions | `Paper as locus` | Locus-preservation is a strict binary partition |

---

## Application Protocol

1. When a Paper is identified in discourse, check if it matches an entry here.
2. If it does, load the `frame` and `burden` fields to guide response structure.
3. Run `detectHydra` using the `burden` as the locus criterion.
4. Use `PaperFirst` protocol for any session containing two or more of these Papers.
5. When new implied Papers are discovered, add them here with an uncurrying note.

Log tag: `#implied-paper P[n]` when working on a specific numbered Paper.

---

**End of uncurried papers library.**
