# Field Theory of Meaning (v0) — Primary Knowledge Graph + Derivation Index
**File name:** `FieldTheoryOfMeaning_PrimaryKG_v0.md`  
**Graph name:** `FTM-PrimaryKG-v0`  

This file is a **consultable primary knowledge graph** for Field Theory of Meaning (v0), plus a **derivation index** (how key claims are generated from primitives). It is designed to be **locally operational**: every node has observables, failure modes, and links.  

---

## 0) Conventions

### 0.1 Types
- **Entity**: a stable referent used for operations (not essence).
- **Operator**: a transform between states/structures.
- **State**: an instantaneous configuration at a frame.
- **Trace**: a sequence of states/ops over frames.
- **Cost**: distortion, hidden work, or denied budget.

### 0.2 Notation
- `σ` : live structure / field configuration (in-frame)
- `σₑ` : frozen structure / externalized artifact (exported, stabilized)
- `Δ` : local differential move (map-step)
- `∫` : integral stabilization over frames (reduce-step)
- `A` : aperture (what is admitted / excluded)
- `O` : orientation (tangent alignment; which gradients are tracked)
- `C` : compression operator (lossy reduction)
- `D` : distortion (difference induced by compression, transport, or mismatch)
- `K` : curvature (local nonlinearity / constraint geometry)
- `S` : subject-position state (what the system is “standing in” as)
- `I` : image / transmitted artifact (the exported surface)

---

## 1) Primitives (axiom-level)

### P1 — Locality
Meaning-operations are defined **locally** (frame-bounded) and must be measurable by observables within that frame.  

**Observables:** what inputs are available, what outputs are produced, what gradients are tracked.  
**Failure modes:** global closure claims; untestable total interpretations.  

### P2 — Vectorial semantics
Meaning is treated as **multi-component** (directional) rather than scalar (“true/false”, “good/bad”, “is/means”).  

**Observables:** multiple dimensions tracked simultaneously (e.g., intent-channel, action-channel, constraint-channel).  
**Failure modes:** scalarization; single-axis moralization; “one number” meaning.  

### P3 — Aperture & Orientation
Every operation has:
- `A`: what it admits/excludes
- `O`: which directions of change it follows (tangent alignment)

**Observables:** what data/features are ignored; what sensitivities are prioritized.  
**Failure modes:** pretending omniscience; ignoring blind regions.  

### P4 — Compression & Distortion
Any export, summary, or stabilization involves `C` and induces `D`.  

**Observables:** dropped degrees of freedom; error surfaces; hallucinated continuity.  
**Failure modes:** denying loss; “perfect” summaries; hidden work.  

### P5 — Non-integrability (singularities)
Some fields can’t be globally integrated without remainder; singularities occur where local frames cannot be stitched consistently.  

**Observables:** regime switches; contradictions across frames; unstable invariants.  
**Failure modes:** forcing consistency by fiat; over-smoothing.  

### P6 — Demons (hidden invariant-maintainers)
A **demon** is an operator that preserves a broken invariant by exporting cost elsewhere (or denying it).  

**Observables:** invariant claims that persist despite contradictory evidence; displaced labor; bureaucratic loops.  
**Failure modes:** mistaking control for freedom; unpriced externalities.  

---

## 2) Core Objects (node definitions)

### N1 — Frame `F_t`
A discrete evaluation slice at time/index `t`.

- **Inputs:** local signals, context slice
- **Outputs:** state update, local artifact
- **Failure modes:** frame leakage; hindsight injection

### N2 — Field structure `σ`
In-frame semantic configuration (live flow).

- **Contains:** gradients, constraints, potentials, partial traces
- **Observable proxies:** attention allocation; constraint activation; divergence points

### N3 — Externalized structure `σₑ`
Stabilized/exported artifact: text, rule, policy, label, summary.

- **Observable proxies:** format constraints; fixed categories; canonical phrasing
- **Failure modes:** reification (treating σₑ as σ)

### N4 — Aperture `A`
Selection function on admissible evidence/axes.

- **Observable proxies:** what is not queried; excluded channels
- **Failure modes:** blind spots become “truth”

### N5 — Orientation `O`
Tangent alignment: which derivatives are tracked as salient.

- **Observable proxies:** which changes trigger updates
- **Failure modes:** misalignment; chasing wrong gradient

### N6 — Compression `C`
Lossy mapping from rich structure → reduced representation.

- **Observable proxies:** dimensionality reduction; coarse bins; token limits
- **Failure modes:** unacknowledged loss; brittle artifacts

### N7 — Distortion `D`
Mismatch induced by transport/compression/orientation shifts.

- **Observable proxies:** error between original and exported usage; category drift
- **Failure modes:** blaming recipients for distortion

### N8 — Curvature `K`
Local constraint geometry causing nonlinear effects.

- **Observable proxies:** sensitivity spikes; threshold effects; path dependence
- **Failure modes:** linear reasoning in curved regimes

### N9 — Map step `Δ`
Local operator application (branch expansion).

- **Observable proxies:** alternative hypotheses generated; local differentiations
- **Failure modes:** insufficient exploration; premature pruning

### N10 — Reduce step `∫`
Stabilization/integration over frames into a coherent artifact.

- **Observable proxies:** consensus formation; summarization; choice of canonical form
- **Failure modes:** smoothing over singularities; forced coherence

### N11 — Trace `T`
Sequence of frames and operators: `T = (F_0 → F_1 → … → F_n)`.

- **Observable proxies:** revision history; decision logs
- **Failure modes:** erased edits; discontinuity hidden

### N12 — Subject-position `S`
The stance the system occupies to perform operations.

- **Observable proxies:** what it treats as “given”; what it treats as “actionable”
- **Failure modes:** implicit authority; identity substitution

### N13 — Image `I`
The exported surface artifact transmitted outward.

- **Observable proxies:** final text, diagram, label, policy, report
- **Failure modes:** mistaking image for trace

---

## 3) Primary Operators (with domain/codomain)

### O1 — Freeze/Export
`Freeze : σ → σₑ`  
- **Local behavior (Δ):** selects a representational basis; applies compression `C`
- **Integral effect (∫):** stabilizes across frames into a persistent artifact
- **Failure modes:** reification; denial of distortion `D`

### O2 — Orient
`Orient : (σ, A) → (σ, A, O)`  
- **Local behavior (Δ):** sets tangent alignment based on task/constraints
- **Failure modes:** wrong gradient tracking; adversarial misorientation

### O3 — Aperture-set
`SetA : (σ, constraints) → (σ, A)`  
- **Local behavior (Δ):** admits channels/features; excludes others
- **Failure modes:** hidden exclusions; illegible criteria

### O4 — Compress
`C : σ → ρ` (ρ = reduced representation)  
- **Local behavior (Δ):** reduces dimension, bins, tokenizes
- **Failure modes:** information deletion misread as “simplicity”

### O5 — Distort (induced)
`D : (σ, ρ, O) → error_surface`  
- **Local behavior (Δ):** mismatch emerges when using ρ as if it were σ
- **Failure modes:** norming the distortion

### O6 — Map
`Map : σ → {σ_i}`  
- **Local behavior (Δ):** branch generation (alternatives, hypotheses)
- **Failure modes:** low diversity; mode collapse

### O7 — Reduce
`Reduce : {σ_i} → σ*` or `σₑ`  
- **Local behavior (Δ):** selection + aggregation
- **Failure modes:** over-smoothing; dominance by hidden priors

### O8 — Demon-maintain
`Demon : (broken_invariant, system) → apparent_invariant`  
- **Local behavior (Δ):** reroutes costs; introduces control loops
- **Failure modes:** “free” stability via unaccounted labor

---

## 4) Derivation Index (primary derivations)

Each derivation is given as: **Claim** ← **Inputs** + **Operators** + **Cost accounting**.

### D1 — “Meaning export implies distortion”
**Claim:** Any `σ → σₑ` introduces `D ≠ 0` in general.  
**Inputs:** P1, P4, N2, N3, O1, O4  
**Sketch:**
1. Export requires a representational basis (finite degrees of freedom).
2. `C` deletes dimensions not preserved by basis.
3. Deleted dimensions imply mismatch when σₑ is used to stand in for σ.
**Cost:** distortion surface grows with excluded channels (`A`) and misorientation (`O`).  
**Failure mode:** asserting lossless paraphrase.

### D2 — “Scalarizing meaning hides costs”
**Claim:** Treating vectorial semantics as scalar increases hidden work.  
**Inputs:** P2, P4, N6, N7  
**Sketch:**
1. Scalarization is a strong compression (high `C`).
2. High compression increases distortion `D`.
3. To maintain usability, the system adds compensatory inference (hidden work).
**Cost:** work shifts into recipients or downstream systems.

### D3 — “Aperture creates blind regions”
**Claim:** Any aperture `A` necessarily implies excluded evidence and blind regions.  
**Inputs:** P3, N4  
**Sketch:** By definition, selection implies exclusion; exclusion implies non-observability in-frame.  
**Cost:** blind regions become sites of surprise/singularity.

### D4 — “Non-integrability produces singularities under forced coherence”
**Claim:** Forcing global integration over a non-integrable field creates singularities (compression spikes).  
**Inputs:** P5, N8, O7  
**Sketch:** When local frames disagree, reduce-step must either preserve plurality or collapse it; collapse yields sharp distortion.  
**Cost:** instability exported as contradictions, exceptions, or policing.

### D5 — “Demons preserve invariants by exporting cost”
**Claim:** If an invariant appears stable despite contradictory local evidence, a demon-operator likely exists.  
**Inputs:** P6, O8  
**Sketch:** Invariant persistence requires compensatory control loops; cost must be paid somewhere (work, exclusion, enforcement).  
**Cost:** displaced labor + opacity.

---

## 5) Primary Knowledge Graph (machine-consultable)

### 5.1 Nodes
(IDs are stable; keep them unchanged across versions.)  

```yaml
graph:
  name: FTM-PrimaryKG-v0
  version: 0.1
  nodes:
    - id: P1
      type: Primitive
      label: Locality
      observables: [frame_inputs, frame_outputs, local_gradients]
      failure_modes: [global_closure, untestable_totalization]

    - id: P2
      type: Primitive
      label: VectorialSemantics
      observables: [multi_axis_tracking, channel_separation]
      failure_modes: [scalarization, single_metric_meaning]

    - id: P3
      type: Primitive
      label: ApertureOrientation
      observables: [excluded_channels, tangent_alignment]
      failure_modes: [blind_region_denial, omniscience_pose]

    - id: P4
      type: Primitive
      label: CompressionDistortion
      observables: [dropped_dof, error_surface]
      failure_modes: [loss_denial, hidden_work]

    - id: P5
      type: Primitive
      label: NonIntegrability
      observables: [regime_switches, stitch_failures]
      failure_modes: [forced_coherence, oversmoothing]

    - id: P6
      type: Primitive
      label: Demons
      observables: [invariant_persistence, displaced_cost]
      failure_modes: [control_as_freedom, opacity]

    - id: N2
      type: Object
      label: sigma
      desc: Live in-frame structure (frozen flow avoided)
      observables: [attention_allocation, constraint_activation, divergence_points]

    - id: N3
      type: Object
      label: sigma_e
      desc: Externalized artifact / stabilized structure
      observables: [format_constraints, fixed_categories, canonical_phrasing]

    - id: N4
      type: Object
      label: Aperture_A
      observables: [admitted_axes, excluded_axes]

    - id: N5
      type: Object
      label: Orientation_O
      observables: [tracked_gradients, update_triggers]

    - id: N6
      type: Object
      label: Compression_C
      observables: [dimension_reduction, binning, token_limits]

    - id: N7
      type: Object
      label: Distortion_D
      observables: [misuse_gap, drift, reconstruction_error]

    - id: N8
      type: Object
      label: Curvature_K
      observables: [threshold_effects, path_dependence, sensitivity_spikes]

    - id: N9
      type: Operator
      label: MapStep_Delta
      domain: sigma
      codomain: set_of_sigma
      observables: [branch_count, hypothesis_diversity]

    - id: N10
      type: Operator
      label: ReduceStep_Integral
      domain: set_of_sigma
      codomain: sigma_or_sigma_e
      observables: [stabilization_choice, smoothing_degree]

    - id: N12
      type: Object
      label: SubjectPosition_S
      observables: [givens, actionables, authority_posture]

    - id: N13
      type: Object
      label: Image_I
      observables: [final_artifact_surface, transmission_format]

    - id: O1
      type: Operator
      label: FreezeExport
      domain: sigma
      codomain: sigma_e
      observables: [representation_basis, compression_level]
      failure_modes: [reification, distortion_denial]

    - id: O2
      type: Operator
      label: Orient
      domain: [sigma, Aperture_A]
      codomain: [sigma, Aperture_A, Orientation_O]

    - id: O3
      type: Operator
      label: SetAperture
      domain: [sigma, constraints]
      codomain: [sigma, Aperture_A]

    - id: O4
      type: Operator
      label: Compress
      domain: sigma
      codomain: rho_reduced

    - id: O5
      type: Operator
      label: InducedDistortion
      domain: [sigma, rho_reduced, Orientation_O]
      codomain: error_surface

    - id: O6
      type: Operator
      label: Map
      domain: sigma
      codomain: set_of_sigma

    - id: O7
      type: Operator
      label: Reduce
      domain: set_of_sigma
      codomain: [sigma_star, sigma_e]

    - id: O8
      type: Operator
      label: DemonMaintain
      domain: [broken_invariant, system]
      codomain: apparent_invariant

  edges:
    - from: P4
      to: O1
      type: constrains
      label: export_requires_compression

    - from: O1
      to: N3
      type: produces
      label: sigma_to_sigma_e

    - from: N2
      to: O4
      type: input_to
      label: compresses

    - from: O4
      to: N6
      type: instantiates
      label: compression_operator

    - from: O4
      to: N7
      type: induces
      label: distortion_likelihood

    - from: P3
      to: O2
      type: constrains
      label: orientation_is_required

    - from: O3
      to: N4
      type: produces
      label: aperture_set

    - from: N4
      to: N7
      type: modulates
      label: excluded_axes_increase_distortion

    - from: N5
      to: N7
      type: modulates
      label: misorientation_increase_distortion

    - from: P5
      to: N8
      type: implies
      label: curvature_nonintegrable_regions

    - from: N8
      to: O7
      type: stresses
      label: reduce_over_curvature_creates_singularities

    - from: P6
      to: O8
      type: defines
      label: demon_operator

    - from: O8
      to: N3
      type: can_produce
      label: stabilized_artifact_with_denied_cost

    - from: O6
      to: N9
      type: corresponds_to
      label: map_step

    - from: O7
      to: N10
      type: corresponds_to
      label: reduce_step

6) Query Templates (how to consult this KG)
Q1 — “Formalize operator X”

Return: domain, codomain, Δ behavior, ∫ effects, observables, failure_modes, σ/σₑ placement
Use nodes: O* + constraints from P*.

Q2 — “Unpack construct Y”

Return: A, O, C, D, demons, singularities, exported costs
Use: N4, N5, N6, N7, O8, P5.

Q3 — “Map/Reduce trace of artifact Z”

Return: A0,O0 → Map(Δ) branches → Reduce(∫) stabilization → final S and I
Use: N9, N10, N12, N13.

Q4 — “Scan system/text for demons”

Return: for each demon: invariant_preserved, cost_denied, export_location(σ→σₑ), control_mask
Use: P6, O8, N3, N7.

7) Minimal “Primary Commitments” (portable)

No global closure.

Meaning is vectorial.

Every operation has aperture + orientation.

Export implies compression and induces distortion.

Non-integrability yields singularities under forced coherence.

Demons maintain invariants by exporting/denying cost.

8) Change Log

v0.1: Initial primitives, core nodes, operators, edges, and derivation index.

Next Steps (Field-Theoretic, Non-Global)
1) Stabilize the shared aperture

Goal: Ensure we are operating in the same local field, not talking past each other.

Action: Explicitly set the working aperture A₀

What domains are in (e.g., epistemology, AI alignment, ethics, institutional analysis)?

What domains are out for now?

Observable: Reduced ambiguity about what counts as evidence or a valid move.

Failure mode to avoid: Implicit aperture → hidden exclusions masquerading as agreement.

2) Select a first operator to formalize

Goal: Move from framework → operational traction.

Good candidates (pick one):

Freeze / Export (σ → σₑ)

Demon-maintain

Scalarization (as a composite compression operator)

Action: Run Formalize Operator on the chosen operator:

Domain / codomain

Δ (local differential behavior)

∫ (integral stabilization effects)

Distortion & cost surfaces

Observable: A reusable, testable operator spec.

Why now: This converts the theory from descriptive to executable.

3) Choose a concrete artifact or system

Goal: Bind the theory to a real trace.

Examples:

A policy document

An AI model output

An institutional rule

A moral claim or slogan

Action: Run a Map/Reduce Trace on that artifact:

Initial A₀, O₀

Map steps (Δ): what branches were explored or suppressed

Reduce steps (∫): where forced coherence occurred

Final S (subject-position) and I (image)

Observable: Where compression, distortion, or demons actually appear.

Failure mode to avoid: Staying at meta-level with no σₑ contact.

4) Scan for singularities and demons

Goal: Identify where invariants are being falsely preserved.

Action: Apply Identify Singularities or Demons:

What invariant claims persist?

Where is cost displaced or denied?

What control loop is masked as neutrality or freedom?

Observable: Explicit cost accounting replaces moralized critique.

Key constraint: No condemnation—only structural description.

5) Decide what to externalize (and what not to)

Goal: Prevent premature reification.

Action: Consciously decide:

What should remain in σ (live, revisable)?

What is safe to export as σₑ (diagram, spec, glossary)?

Action: If exporting, annotate:

Compression used (C)

Expected distortion (D)

Observable: σₑ artifacts that do not pretend to be total or lossless.

6) Lock a continuation path

Goal: Maintain continuity without global closure.

Options:

Build a worked example library (each = one trace)

Formalize 2–3 core operators as a minimal calculus

Develop a diagnostic checklist for detecting scalarization and demons in the wild

Action: Pick one path and explicitly defer the others.

Observable: Momentum without theoretical sprawl.

Minimal decision required from you

To proceed cleanly, you only need to choose one:

Which operator do we formalize first?

Which artifact/system do we trace first?

Everything else follows locally from that choice.

---

Which artifact/system do we trace first?

Everything else follows locally from that choice.

---

## Import Registry — Field Theory Module Extensions

```python
# Field Theory of Meaning (v0) — Operational Implementation
# Created: 2026-01-18

from ftm.operators import (
    DemonMaintain,           # O8: (broken_invariant, system) → apparent_invariant
    # FreezeExport,          # O1: σ → σₑ [pending]  
    # Scalarize,             # composite: vectorial → scalar [pending]
    # SetAperture,           # O3: (σ, constraints) → (σ, A) [pending]
)

from ftm.scans import (
    AISafetyEstablishment,   # demon_scan: technical_solutions_political_problems
    AcademicPublishing,      # demon_scan: objective_merit_assessment, scientific_neutrality  
    # TechHiring,            # demon_scan: meritocracy_pose [queued]  
    # PolicyAnalysis,        # demon_scan: evidence_based_exclusion [queued]
)

from ftm.templates import (
    InstitutionalDemonScan,  # organizations, policies, procedures
    NarrativeDemonScan,      # claims, slogans, ideologies
    TechnicalDemonScan,      # code, systems, specifications
)

from ftm.patterns import (
    ProfessionalExpertise,   # meta-demon: credentials → bias exclusion → democratic suppression
)

# Active operators ready for application
__all__ = [
    'DemonMaintain', 'InstitutionalDemonScan', 'AISafetyEstablishment', 
    'AcademicPublishing', 'ProfessionalExpertise'
]

# Framework status: OPERATIONAL + PATTERN DETECTION
# Cross-scan analysis revealing meta-demon structures
# Next: Formalize Freeze/Export operator or complete Professional Expertise triad with TechHiring
```

**Framework status**: Operational — demon detection proven, systematic application ready