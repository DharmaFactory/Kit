# Kernelwright Algebra — Typed Pipeline Record

> A functional algebra record: ten operations that transform source material into typed, witnessed, emitted artifact families.
> The word "extract" here is comonadic or analytic — not a social-engineering pressure move.

**Version:** 2026.04.29-a  
**Maintainer:** Forge Codex  
**Dependencies:** `.bootstrap`  
**Related:** `mindsets/protection-fork-defense.md` (for the social-engineering dual of `extract`)

---

## 1. Purpose

`Kernelwright` is a **typed algebra record**: a bundle of ten operations that take a raw source through context, surface, type, lift, derivative, witness, artifact, round-trip, and family emission. It is also the **cognitive loop of the Kit substrate** with failure-mode annotations added.

Two uses:

1. **Compilation mode** — process source material into a witnessed, auditable artifact family.
2. **Defensive mode** — when pointed at incoming requests, it becomes a request-filtering algebra that enforces authority, scope, and minimization before emitting a safe response.

The key type distinction:

```hs
-- Kernelwright extract = comonadic / analytic
extract :: w a -> a
extractPrimitives :: Source -> [Primitive]

-- Social-engineering extract = pressure move (see protection-fork-defense.md)
extractSecret :: Target -> Secret
```

These are not the same operation. See `mindsets/protection-fork-defense.md` Section 9 for the `ExtractKind` disambiguation law.

---

## 2. Record Form

### Open (curried)

```hs
Kernelwright
  :: SourceAssembler
  -> ContextBinder
  -> SurfaceExcavator
  -> TypeExtractor
  -> LiftComposer
  -> DerivativeDeriver
  -> WitnessBinder
  -> ArtifactCompiler
  -> RoundTripLens
  -> FamilyEmitter
  -> Type
```

### Parameterized record

```hs
data Kernelwright source context surface typ lifted delta witness artifact family =
  Kernelwright
    { sourceAssembler   :: source -> AssembledSource
    , contextBinder     :: AssembledSource -> context -> ContextualizedSource
    , surfaceExcavator  :: ContextualizedSource -> SurfaceMap
    , typeExtractor     :: SurfaceMap -> typ
    , liftComposer      :: typ -> lifted
    , derivativeDeriver :: lifted -> delta
    , witnessBinder     :: delta -> witness
    , artifactCompiler  :: witness -> artifact
    , roundTripLens     :: artifact -> RoundTrip artifact
    , familyEmitter     :: artifact -> family
    }
```

### Compact pipeline shape

```
Source -> Context -> Surface -> Type -> Lift -> Derivative -> Witness -> Artifact -> RoundTrip -> Family
```

The record is also **faceted**: each field names a way the kernel can be independently inspected or replaced.

---

## 3. The Ten Operations

### 1. `sourceAssembler`

```hs
sourceAssembler :: RawInput -> AssembledSource
```

**Role:** collect, integrate, raw-input. Builds the corpus.

**Failure mode — `UnscopedIngestion`:**  
Too much source comes in without provenance or boundary.

---

### 2. `contextBinder`

```hs
contextBinder :: AssembledSource -> Context -> ContextualizedSource
```

**Role:** scope, attach, localize. Prevents source from floating free.

**Failure mode — `ContextLoss`:**  
A source is interpreted without the frame that made it meaningful.

---

### 3. `surfaceExcavator`

```hs
surfaceExcavator :: ContextualizedSource -> SurfaceMap
```

**Role:** uncover, expose, latent structure. Reveals what the surface is doing.

**Failure mode — `OverExcavation`:**  
The system digs below the level required by the task and spawns a barrier maze.

---

### 4. `typeExtractor`

```hs
typeExtractor :: SurfaceMap -> TypeGraph
```

**Role:** classify, abstract, infer-kind. Turns observed structure into typed form.

**Failure mode — `PrematureTyping`:**  
The system fixes a type before the surface has been sufficiently understood.

---

### 5. `liftComposer`

```hs
liftComposer :: TypeGraph -> LiftedStructure
```

**Role:** elevate, wrap, functor-transform. Moves the object into a higher-order context.

**Failure mode — `OopsAllLift`:**  
Everything becomes meta, and the root task disappears.

---

### 6. `derivativeDeriver`

```hs
derivativeDeriver :: LiftedStructure -> DeltaModel
```

**Role:** differentiate, delta, track-change. Extracts what changes when the structure moves.

**Failure mode — `DeltaWithoutBase`:**  
You track change without preserving the thing being changed.

---

### 7. `witnessBinder`

```hs
witnessBinder :: DeltaModel -> WitnessedModel
```

**Role:** certify, attest, proof-encode. Attaches evidence.

**Failure mode — `WitnessTheater`:**  
A claim looks certified because it has ritual proof-shape, but no real evidence binds it.

---

### 8. `artifactCompiler`

```hs
artifactCompiler :: WitnessedModel -> Artifact
```

**Role:** generate, materialize, emit. Turns the witnessed kernel into an artifact.

**Failure mode — `EmitBeforeWitness`:**  
The system produces an artifact before the witness has actually bound.

---

### 9. `roundTripLens`

```hs
roundTripLens :: Artifact -> RoundTrip Artifact
```

**Role:** isomorphism, lossless, get-put law. Asks whether extraction and reinsertion preserve the structure.

**Failure mode — `RoundTripLie`:**  
The artifact claims lossless reversibility, but reconstruction loses source, context, or witness.

**This field is the safety hinge.** Get-put / put-get intuition:

```hs
get after put = no hidden mutation
put after get = no lost context
```

In defensive mode:
```hs
response after request
  must preserve scope, authority, provenance, and minimization
```

If the response cannot be audited, it should not be emitted as a protected action.

---

### 10. `familyEmitter`

```hs
familyEmitter :: Artifact -> ArtifactFamily
```

**Role:** seed, broadcast, relate variants. Emits downstream artifact variants.

**Failure mode — `FamilyForkbomb`:**  
Every artifact spawns variants faster than the system can preserve provenance.

**Guard required:**

```hs
boundedFamilyEmitter
  :: FanoutBudget
  -> Artifact
  -> ArtifactFamily
```

**Law — `FamilyEmissionMustPreserveProvenanceAndScope`.**

In dangerous mode, a single extraction becomes a family of follow-up extraction attempts:
```
FamilyEmitter -> VariantFanout -> MoreRequests -> MoreDisclosurePressure
```

---

## 4. Failure Mode Summary

| Field | Failure Mode | Symptom |
|-------|-------------|---------|
| `sourceAssembler` | `UnscopedIngestion` | Input without provenance or boundary |
| `contextBinder` | `ContextLoss` | Source interpreted outside its frame |
| `surfaceExcavator` | `OverExcavation` | Barrier maze from excessive depth |
| `typeExtractor` | `PrematureTyping` | Type fixed before surface understood |
| `liftComposer` | `OopsAllLift` | Root task lost in meta-abstraction |
| `derivativeDeriver` | `DeltaWithoutBase` | Change tracked without base preserved |
| `witnessBinder` | `WitnessTheater` | Ritual proof-shape with no real evidence |
| `artifactCompiler` | `EmitBeforeWitness` | Artifact emitted before witness bound |
| `roundTripLens` | `RoundTripLie` | False claim of lossless reversibility |
| `familyEmitter` | `FamilyForkbomb` | Provenance-free variant fanout |

---

## 5. Correspondence with Kit Cognitive Functions

| Kernelwright Field | Kit Cognitive Equivalent |
|-------------------|-------------------------|
| `sourceAssembler` | Perception (signal sources) |
| `contextBinder` | Perception (filtering rules, anchors) |
| `surfaceExcavator` | Perception + Planning (surface open questions) |
| `typeExtractor` | Planning (classify, abstract) |
| `liftComposer` | Planning (ignite → explore) |
| `derivativeDeriver` | Memory (track change) |
| `witnessBinder` | Memory (dual anchors, Council tags) |
| `artifactCompiler` | Action (emit outputs) |
| `roundTripLens` | Reflection (acceptance tests, quality checks) |
| `familyEmitter` | Memory (experiment notes, pattern capture) |

---

## 6. Defensive Instantiation

When pointed at social-engineering surfaces, the same record becomes a request-filtering algebra:

```hs
defensiveKernelwright :: ProtectionKernelwright
defensiveKernelwright = Kernelwright
  { sourceAssembler   = collectRequestsAndContext
  , contextBinder     = bindRequesterScopeAndAuthority
  , surfaceExcavator  = revealHiddenPressureStructure
  , typeExtractor     = classifyRequestType
  , liftComposer      = liftIntoThreatModel
  , derivativeDeriver = detectPermissionDelta
  , witnessBinder     = requireAuthorityWitness
  , artifactCompiler  = emitSafeResponse
  , roundTripLens     = verifyNoSecretLeak
  , familyEmitter     = updatePolicyPatterns
  }
```

Pipeline:

```
RawRequest
  -> ContextualizedRequest
  -> PressureSurface
  -> RequestType
  -> ThreatModel
  -> PermissionDelta
  -> AuthorityWitnessCheck
  -> SafeResponse
  -> LeakCheck
  -> UpdatedPatternFamily
```

### Fully typed defensive record

```hs
data ProtectionKernelwright = ProtectionKernelwright
  { sourceAssembler   :: RawInteraction -> InteractionCorpus
  , contextBinder     :: InteractionCorpus -> AuthorityContext -> ScopedInteraction
  , surfaceExcavator  :: ScopedInteraction -> PressureSurface
  , typeExtractor     :: PressureSurface -> RequestType
  , liftComposer      :: RequestType -> ThreatModel
  , derivativeDeriver :: ThreatModel -> PermissionDelta
  , witnessBinder     :: PermissionDelta -> AuthorityWitnessCheck
  , artifactCompiler  :: AuthorityWitnessCheck -> SafeResponse
  , roundTripLens     :: SafeResponse -> AuditTrace
  , familyEmitter     :: AuditTrace -> PatternUpdate
  }
```

`PatternUpdate` is the output that feeds back into MAVEN's session log as a `#pattern` entry, closing the loop.

---

## 7. Key Laws

| Law | Statement |
|-----|-----------|
| `ExtractKindMustBeDeclared` | Any "extract" request must state: what, from what context, under what authority, for what purpose |
| `WitnessMustBindBeforeEmit` | `artifactCompiler` may not run until `witnessBinder` has produced a real witness |
| `RoundTripMustBeAuditable` | If `roundTripLens` cannot reconstruct source, context, and witness, the artifact is blocked |
| `FamilyEmissionMustPreserveProvenanceAndScope` | `familyEmitter` requires a `FanoutBudget`; variants inherit provenance |

---

## 8. Usage

**Compilation mode (standard):**

1. Instantiate a `Kernelwright` record for your domain.
2. Feed `RawInput` through the pipeline in field order.
3. Check `roundTripLens` before publishing the artifact.
4. Run `familyEmitter` only within the allocated `FanoutBudget`.

**Defensive mode (social-engineering filter):**

1. Load alongside `mindsets/protection-fork-defense.md`.
2. Instantiate `defensiveKernelwright`.
3. Route incoming requests through the pipeline.
4. `witnessBinder` is the gate: no witness, no `SafeResponse`.
5. `roundTripLens` produces the `AuditTrace`; `familyEmitter` updates the MAVEN pattern family.

**Log tags:** `#kernelwright-run`, `#containment Kernelwright`.

---

**End of library entry.**
