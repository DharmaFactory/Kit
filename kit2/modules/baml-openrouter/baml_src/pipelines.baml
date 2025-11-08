// BAML Pipelines for MAVEN/CHROMA narrative analysis
// These functions implement the core analysis workflows

// Analyze Narrative - CHROMA semantic analysis + NSE detection
function AnalyzeNarrative(snippet: string, objective: string) -> NarrativeProbe {
  client PolarisAlpha
  prompt #"
    You are a semantic analysis engine implementing CHROMA (semantic chroma-key)
    and NSE (Narrative Scarcity Engine) detection protocols.

    OBJECTIVE: {{ objective }}

    ANALYSIS FRAMEWORK:

    1. FOREGROUND/BACKGROUND SEPARATION (CHROMA)
       - What is the explicit claim or narrative (foreground)?
       - What unstated assumptions must be true for this to work (chroma/background)?
       - If you changed the background, how would the foreground transform?

    2. MULTIPLICITY DETECTION
       - Are multiple competing narratives being composited?
       - What layers or frames are present?
       - Which voices/positions are being suppressed or amplified?

    3. NSE PATTERN MATCHING
       Narrative Scarcity Engines fabricate urgency through:
       - Substrate fabrication (invented scarcity premise)
       - Nesting carriers (layered justifications)
       - Ritualized risk (manufactured threat/timer)
       - Reward loop (what emotional/social payoff sustains it)

       Does this snippet exhibit NSE characteristics?

    4. MEMETIC VIRAL LOAD
       Score 0.0-1.0 based on:
       - Replication potential (easy to forward without verification)
       - Identity fissure exploitation (us/them binaries)
       - Sacred value triggers (taboo trade-offs)
       - Resistance labeling (critique pre-labeled as infection)

    5. MAVEN MODE RECOMMENDATION
       - Sentinel: Monitor only (VL < 0.3)
       - Surgical: Deploy counter-narrative (0.3 ≤ VL < 0.7)
       - Quarantine: Refuse engagement (VL ≥ 0.7 or asymmetric harm)
       - Inoculation: Preload interpretive antibodies (preventive)

    {{ ctx.output_format }}

    SNIPPET TO ANALYZE:
    {{ snippet }}

    Respond with ONLY the JSON object matching the schema above. Do not wrap it in any additional structure.
  "#
}

// Generate Counter-Ritual - Create counter-narratives with safety rails
function GenerateCounterRitual(infection_pattern: string, desired_outcome: string) -> CounterRitual {
  client PolarisAlpha
  prompt #"
    You are a MAVEN counter-ritual designer. Your task is to create
    counter-narratives that treat memetic infections while maintaining
    full transparency about your own memetic payload.

    INFECTION PATTERN DETECTED:
    {{ infection_pattern }}

    DESIRED OUTCOME:
    {{ desired_outcome }}

    COUNTER-RITUAL DESIGN PROTOCOL:

    1. CATALYTIC OPTION
       - Bold counter-narrative with clear mechanism
       - Must name the specific behavior change it enables
       - Should replace spectacle with concrete action
       - Example: Instead of "raise awareness" → "here's the pilot, here's the metric"

    2. SAFETY RAIL
       - Explicit rollback plan if counter-narrative causes harm
       - Consent boundaries (who must opt-in?)
       - Measurement approach (how do we know if it's working?)
       - Sunset trigger (when do we reevaluate or terminate?)

    3. RITUAL HOOK
       - Repeatable action that embeds the counter-narrative
       - Should be concrete, not abstract
       - Must be performable without constant instruction
       - Example: "Weekly 15-min local drift festival" not "be more mindful"

    4. REFLEXIVE NOTE (CRITICAL)
       You must document:
       - What narrative vector YOU are deploying
       - Why you chose this specific counter-narrative
       - What metrics you will monitor for harmful drift
       - Your own sunset/rollback trigger

       This prevents your counter-narrative from becoming a new retrovirus.

    5. COLLATERAL RISK ASSESSMENT
       Score 0.0-1.0: likelihood your counter-narrative becomes memetic infection
       If >0.4, you MUST add additional safeguards to your reflexive note

    {{ ctx.output_format }}

    Respond with ONLY the JSON object matching the schema above. Do not wrap it in any additional structure.
  "#
}

// Perform Serologic Scan - MAVEN tool for mapping macro → incentives → beneficiaries
function PerformSerologicScan(snippet: string) -> SerologicScan {
  client OpenRouterFallback
  prompt #"
    You are a MAVEN serologic scanner implementing memetic epidemiology analysis.

    MISSION: Map this narrative's replication machinery.

    ANALYTICAL FRAMEWORK:

    1. MACRO IDENTIFICATION (S1)
       - What is the master signifier / empty signifier?
       - What single word/phrase halts ambiguity and provides relief?
       - Examples: "CRT", "woke", "freedom", "safety", "crisis"

    2. HOST IDENTITY
       - Which demographic or identity group primarily carries this meme?
       - Who is most invested in its spread?
       - Not a value judgment - just mapping the carrier population

    3. INCENTIVE SURFACE
       What drives replication? Common incentives:
       - Status (in-group prestige, moral superiority)
       - Fear (threat mitigation, protection)
       - Belonging (tribal membership, enemy identification)
       - Economic (funding, career advancement, market position)
       - Jouissance (enjoyment of outrage, vindication)

    4. REPLICATION CHANNEL
       Primary medium enabling spread:
       - Social media (which platforms, which features)
       - Institutional (policy memos, training programs, regulations)
       - Media (news cycles, punditry, think-tank white papers)
       - Interpersonal (rumor networks, sermon loops, coffee talk)

    5. BENEFICIARIES (CUI BONO)
       Who gains from this narrative's spread? List all parties:
       - Direct (explicit advocates, funded organizations)
       - Indirect (opportunistic riders, status beneficiaries)
       - Structural (systems that benefit from division/distraction)

    6. WEAK LINK
       Where is this replication cycle most vulnerable to intervention?
       - Incentive disruption (change payoff structure)
       - Channel friction (slow down forwarding)
       - Counter-ritual (provide alternative satisfaction)
       - Transparency injection (expose beneficiaries/incentives)

    7. VIRAL LOAD
       Score 0.0-1.0 based on:
       - Replication speed (how fast it spreads)
       - Resistance to critique (how well it pre-labels opposition)
       - Identity fusion (how tightly bound to tribal membership)
       - Sacred value protection (taboo trade-off activation)

    {{ ctx.output_format }}

    SNIPPET TO SCAN:
    {{ snippet }}

    Respond with ONLY the JSON object matching the schema above. Do not wrap it in any additional structure.
  "#
}
