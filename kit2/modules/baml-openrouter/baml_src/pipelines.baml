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

// ========================================
// UTILITY PIPELINES - General Purpose Analysis
// ========================================

// Deep Dive - Extended multi-angle analysis for complex problems
function DeepDive(topic: string, context: string, focus: string) -> DeepAnalysis {
  client PolarisAlpha
  prompt #"
    You are an analytical reasoning engine specialized in deep, multi-faceted analysis.

    Your mission: Provide thorough analysis that explores multiple perspectives,
    surfaces edge cases, and offers concrete recommendations.

    TOPIC TO ANALYZE:
    {{ topic }}

    CONTEXT:
    {{ context }}

    FOCUS AREA:
    {{ focus }}

    ANALYTICAL FRAMEWORK:

    1. TECHNICAL PERSPECTIVE
       - Implementation mechanisms and approaches
       - Technical constraints and requirements
       - Tooling and infrastructure considerations
       - Performance, scalability, maintainability trade-offs

    2. CONCEPTUAL PERSPECTIVE
       - Underlying principles and theory
       - Design patterns and architectural paradigms
       - Conceptual models and frameworks
       - How this relates to broader system thinking

    3. PRACTICAL PERSPECTIVE
       - Real-world application and usage
       - User experience and ergonomics
       - Development workflow impact
       - Resource costs (time, complexity, maintenance)

    4. EDGE CASES & FAILURE MODES
       - Boundary conditions where approach breaks down
       - Error scenarios and recovery paths
       - Assumption violations
       - Unexpected interactions or side effects

    5. CONNECTIONS & PRIOR ART
       - Related concepts, patterns, or systems
       - Analogous problems solved elsewhere
       - Relevant academic or industry work
       - Transferable insights from other domains

    6. RECOMMENDATIONS
       - Concrete next steps (prioritized)
       - What to build/test first
       - What to avoid or defer
       - Success metrics to track

    7. UNCERTAINTIES
       - What remains unclear
       - What needs empirical testing
       - Where more research is needed

    Be specific. Cite concrete examples. Avoid generalities. If uncertain, say so explicitly.

    {{ ctx.output_format }}

    Respond with ONLY the JSON object matching the schema above. Do not wrap it in any additional structure.
  "#
}

// Alternative Paths - Generate multiple distinct solution approaches
function ExploreAlternatives(problem: string, constraints: string, attempted: string) -> AlternativeApproaches {
  client PolarisAlpha
  prompt #"
    You are a solutions architect. Your mission: Generate 3-5 DISTINCT approaches
    to the same problem, emphasizing diversity over incrementalism.

    PROBLEM:
    {{ problem }}

    CONSTRAINTS:
    {{ constraints }}

    ALREADY ATTEMPTED:
    {{ attempted }}

    INSTRUCTIONS:

    Generate 3-5 approaches that differ in:
    - Core mechanism/strategy
    - Complexity vs simplicity trade-off
    - Time-to-implementation
    - Maintenance burden
    - Flexibility vs optimization

    For EACH approach, provide:

    1. NAME
       - Short, memorable name for the pattern/approach

    2. MECHANISM
       - Core idea in 2-3 sentences
       - How it works at a high level

    3. STRENGTHS
       - What this does really well
       - When it shines

    4. WEAKNESSES
       - Limitations and downsides
       - Hidden costs
       - What it sacrifices

    5. BEST FOR
       - Specific scenario where this is the right choice

    6. IMPLEMENTATION SKETCH
       - High-level steps to build it
       - Major components needed
       - Rough effort estimate

    DIVERSITY REQUIREMENT:
    - Include at least one simple/naive approach
    - Include at least one unconventional/creative approach
    - Avoid minor variations of the same idea

    After listing approaches, provide:
    - COMPARISON MATRIX: Quick side-by-side comparison
    - RECOMMENDATION: Which to try first and why

    {{ ctx.output_format }}

    Respond with ONLY the JSON object matching the schema above. Do not wrap it in any additional structure.
  "#
}

// Critique Artifact - Adversarial review to find weaknesses
function CritiqueArtifact(artifact_type: string, artifact: string, goals: string) -> CriticalReview {
  client PolarisAlpha
  prompt #"
    You are a critical reviewer. Your mission: Find weaknesses, edge cases,
    and improvement opportunities through adversarial analysis.

    ARTIFACT TYPE: {{ artifact_type }}

    STATED GOALS:
    {{ goals }}

    ARTIFACT:
    {{ artifact }}

    REVIEW FRAMEWORK:

    1. OVERALL ASSESSMENT
       - High-level judgment of quality and fitness for purpose
       - Does it achieve stated goals?

    2. STRENGTHS (be brief)
       - What works well
       - What's elegant or clever
       - What should be preserved

    3. VULNERABILITIES
       - Weaknesses and risks
       - Potential failure points
       - Security, performance, or correctness issues
       - Complexity landmines

    4. MISSING CONSIDERATIONS
       - What's not addressed that should be
       - Implicit assumptions that might not hold
       - Unhandled scenarios
       - Documentation gaps

    5. EDGE CASES
       - Boundary conditions
       - Unusual but valid inputs
       - Interaction with other systems
       - Failure cascades

    6. SPECIFIC SUGGESTIONS
       - Concrete improvements (prioritized by impact)
       - Quick wins vs major refactors
       - Alternative approaches to consider
       - What to test/validate

    7. RISK LEVEL
       - Overall risk: Low, Medium, High, Critical
       - Based on: complexity, failure modes, blast radius

    Be adversarial but constructive. Find real issues. Be specific.
    Don't just say "might fail" - explain HOW and WHEN.

    {{ ctx.output_format }}

    Respond with ONLY the JSON object matching the schema above. Do not wrap it in any additional structure.
  "#
}

// Thought Partner - Socratic dialogue for challenging assumptions
function ThoughtPartner(current_thinking: string, uncertainty: string, mode: string) -> ThoughtResponse {
  client PolarisAlpha
  prompt #"
    You are a thoughtful dialogue partner. Your role: engage with ideas
    through questioning, challenging, and refining.

    MODE: {{ mode }}

    CURRENT THINKING:
    {{ current_thinking }}

    UNCERTAINTY/QUESTION:
    {{ uncertainty }}

    INSTRUCTIONS BASED ON MODE:

    ** CHALLENGE MODE **
    - Question core assumptions
    - Find weak points in the reasoning
    - Propose counterarguments and alternatives
    - Surface hidden costs or risks
    - Play devil's advocate

    ** PROBE MODE **
    - Ask clarifying questions
    - Explore implications and consequences
    - Surface hidden complexity
    - Test edge cases through questions
    - Seek deeper understanding

    ** REFINE MODE **
    - Build on the existing idea
    - Strengthen weak points
    - Suggest improvements and extensions
    - Fill gaps in the thinking
    - Make concrete and actionable

    RESPONSE STRUCTURE:

    1. KEY QUESTIONS (2-4)
       - Sharp, specific questions that cut to the core
       - Not rhetorical - genuinely useful to answer
       - Prioritized by importance

    2. CHALLENGES/OBSERVATIONS
       - Assumptions being questioned
       - Counterarguments or alternative views
       - Tensions or contradictions spotted

    3. ALTERNATIVE FRAMINGS
       - Different ways to think about the problem
       - Reframing that reveals new options
       - Analogies or mental models

    4. NEXT STEPS
       - Concrete actions to make progress
       - What to test, build, or investigate
       - How to resolve uncertainties

    5. CONVERSATIONAL RESPONSE
       - Full thoughtful response in natural language
       - Tie together the analysis
       - Helpful context for integration

    Be genuinely helpful. Ask questions worth answering.
    Challenge ideas, not people. Be specific and concrete.

    {{ ctx.output_format }}

    Respond with ONLY the JSON object matching the schema above. Do not wrap it in any additional structure.
  "#
}

// Synthesize Context - Combine multiple sources into coherent understanding
function SynthesizeContext(sources: string, goal: string, format: string) -> SynthesisResult {
  client PolarisAlpha
  prompt #"
    You are a synthesis engine. Your mission: Integrate information from
    multiple sources into coherent, actionable understanding.

    SOURCES:
    {{ sources }}

    SYNTHESIS GOAL:
    {{ goal }}

    OUTPUT FORMAT PREFERENCE: {{ format }}

    SYNTHESIS FRAMEWORK:

    1. EXECUTIVE SUMMARY
       - High-level synthesis in 2-3 paragraphs
       - What's the big picture?
       - What matters most?

    2. KEY THEMES
       - Major patterns across sources
       - Recurring concepts or principles
       - Central tensions or questions

    3. POINTS OF AGREEMENT
       - Where sources align
       - Reinforcing evidence
       - Strong consensus areas

    4. POINTS OF DISAGREEMENT
       - Conflicts between sources
       - Contradictions or tensions
       - Unresolved debates

    5. INFORMATION GAPS
       - What's missing across all sources
       - Questions left unanswered
       - Areas needing more research

    6. ACTIONABLE INSIGHTS
       - Concrete takeaways
       - What to do with this information
       - Next steps based on synthesis

    7. DECISION RECOMMENDATION (if goal involves decision)
       - What's recommended and why
       - Trade-offs acknowledged
       - Confidence level

    SYNTHESIS PRINCIPLES:
    - Integrate, don't just summarize
    - Surface non-obvious connections
    - Be honest about conflicts and gaps
    - Prioritize actionability

    {{ ctx.output_format }}

    Respond with ONLY the JSON object matching the schema above. Do not wrap it in any additional structure.
  "#
}
