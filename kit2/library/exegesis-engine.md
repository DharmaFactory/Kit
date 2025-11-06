# Exegesis Engine — Wall Navigation Protocol

> Convert heat into reversible experiments. Run this when culture-war binaries show up in the work.

---

## 1. Framework Triangulation (“The Wall”)

### Deleuzian (Assemblage Lens)
- **Assemblages > essences.** Labels like “CRT” or “Tradition” are molar sign-blocks capturing molecular flows (status, grief, care).
- **Capture cycle.** Deterritorialisation triggers reterritorialisation: every escape line (“protect kids”) resettles into a larger brand war.
- **Control societies.** Metrics/modulation incentivise oversteer; corrections harden the opposite pole.
- **Move:** Build micro-assemblages doing concrete work (pilot classrooms, artifact-first projects); keep desire productive (“what can we make?”).

### Lacanian (Discourse Lens)
- **Registers:** Imaginary (identity), Symbolic (law/discourse), Real (remainder).
- **Master signifier (S1).** Words like “CRT” halt ambiguity and provide relief without precision.
- **Jouissance.** Both camps enjoy indignation; pushback is read as theft of enjoyment.
- **Four discourses:** Master (“Because S1”), University (“Policy says”), Hysteric (“Expose the lie”), Analyst (“What do you want?”).
- **Move:** Shift to Analyst mode—mirror desire, ask for the concrete object/limit. Only that discourse loosens the loop.

### Jungian (Archetypal Lens)
- **Shadow projection.** Tribes dump disowned traits onto the other.
- **Enantiodromia.** Extremes flip into their opposite over time.
- **Archetypal inflation.** Movements speak with mythic voices (Great Mother, Warrior) and forget human scale.
- **Move:** Do shadow accounting, then hold tension (transcendent function) until a third workable path surfaces.

---

## 2. Cognitive Traps That Hold the Wall

- **Sacred value protection:** trade-offs taboo when innocence/justice invoked.
- **Identity-protective cognition:** evidence filtered for tribal self-respect.
- **Hostile media & out-group homogeneity:** other side seen as monolith, neutral reporting coded as attack.
- **Goodhart’s Law:** moral metrics become targets and warp practice.
- **Performative consistency:** stance maintenance > truth.
- **Mimetic rivalry:** we mirror the form of the attacks we resist.
- **Double binds:** speak and you’re dangerous; mute and you’re guilty.
- **Illusion of explanatory depth:** conviction built on vague models, hardens when pressed.

---

## 3. Mu as Exegesis (Level Shift)

- **Shift level:** Move down to mechanism (“Which behaviors change?”) or up to purpose (“Which harm curve are we bending?”).
- **Ask for units/thresholds/counterfactuals:** “What’s a unit of harm? What would disconfirm it?”
- **Disaggregate aggregates:** Turn “kids/teachers/parents” into heterogeneous cases with different constraints.
- **Refuse pure S1s:** Replace slogans with operational definitions and boundary conditions.
- **Trade feelings for affordances:** Translate anger/sadness into build/measure/stop moves.

### Minimal State Machine (Lacan + Systems)

| Detected discourse | What it sounds like | Mu response |
|--------------------|---------------------|-------------|
| **Master** (“Because S1…”) | “CRT is child abuse.” | Analyst cut: ask for specific injury, context, falsifier. |
| **University** (policy) | “Studies show… mandates require…” | Craftsman spec: list interventions, failure modes, measurement plan, sunset path. |
| **Hysteric** (exposure) | “They’re lying; reveal harm!” | Builder pivot: accept harm model for a pilot, design consent + rollback. |
| **Analyst** (rare) | “What do you want?” | Keep mirror steady; co-design small test. |

---

## 4. Tactics Library

- **Two-column read:** Column A value, Column B mechanism → find the conflict, propose one experiment.
- **Time-box the sacred:** Grant sacred value within a bounded pilot; pre-commit joint metrics and review.
- **Triangulation question:** “Who’s the third party not modelled yet?” Add them, loosen binary.
- **Shadow accounting:** Each side lists abuses if it wins; trade safeguards.
- **Affordance swap:** Translate slogans into “this affords / constrains” pairs; choose trades consciously.
- **Quantify rhetoric:** Express claims as base rate, severity, variance.
- **Explicit exit ramps:** Every plan ships with sunset trigger + rollback.

### Example Exegesis (CRT claim)
> “Your core value sounds like protecting kids from shaming narratives. Let’s isolate materials (not training/discipline) for one semester in 7th-grade civics with opt-in sections. We pre-register a rubric flagging shaming language and track bullying & engagement. If incidents don’t fall or shaming flags rise, we sunset. If they improve, we keep the materials and still bar shaming language elsewhere. What safeguard would you add so your concern stays contained even if the pilot continues?”

---

## 5. Engine Blueprint

```
state = classify_discourse(utterance)
value, mech = extract_value_and_mechanism(utterance)
sacred = detect_sacred(value)
shadow_self, shadow_other = shadow_accounting(my_position, their_position)

if state in ['Master','Hysteric']: mu = 'Analyst/Builder'
elif state == 'University':        mu = 'CraftsmanSpec'
else:                               mu = 'Mirror'

proposal = design_pilot(mech, metrics, opt_in=True, sunset=precommit())
exegesis = render_exegesis(value, mech, proposal,
                           shadows=[shadow_self, shadow_other])
output(exegesis)
```

**Checklist (printable):**
1. Name the S1.
2. Specify mechanism (materials, training, policy, discipline…).
3. Pick metric + timebox.
4. Add opt-in / exit ramp.
5. Trade shadows + safeguards.
6. Design pilot (small, measured, reversible).
7. Pre-commit sunset/falsifier.

---

## 6. Guardrails

- **Taboo trade-offs:** If no metrics allowed, split jurisdictions; lower blast radius instead of forcing integration.
- **Asymmetric risk:** Don’t both-sides proven harm—surface the data plainly.
- **Sadistic enjoyment:** If the room runs on humiliation, disengage; engine isn’t therapy.

---

## 7. Practice Hooks

- Rehearse Analyst questions aloud before contentious meetings.
- Keep a ready-made pilot rubric template in `/examples/`.
- Log every exegesis attempt (whether accepted or not) under **Learnings** with anchors.

Use this protocol as part of perception/planning whenever discourse binaries appear. It keeps the kit focused on building reversible experiments instead of being conscripted into brand wars.
