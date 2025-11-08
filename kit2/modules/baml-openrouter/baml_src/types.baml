// BAML Type Definitions for MAVEN/CHROMA workflows
// These classes define structured outputs from our pipelines

// NarrativeProbe - for probe_narrative pipeline
// Used to analyze narrative snippets for CHROMA/NSE detection
class NarrativeProbe {
  // Foreground narrative elements
  foreground string @description("Primary surface-level narrative or claim")

  // Chroma key analysis - what background is being assumed/composited
  chroma string @description("Semantic chroma key - what background assumption enables this foreground")

  // Multiplicity detection - are multiple narratives being layered?
  multiplicity string[] @description("List of distinct narrative layers or competing frames detected")

  // Risk assessment for memetic virality
  viral_load float @description("Memetic viral load score 0.0-1.0")

  // Recommended MAVEN mode
  maven_mode string @description("Recommended MAVEN mode: Sentinel, Surgical, Quarantine, or Inoculation")

  // Analysis summary
  analysis string @description("Detailed analysis of narrative structure and risks")
}

// CounterRitual - for draft_counter pipeline
// Used to generate counter-narratives with safety rails
class CounterRitual {
  // The catalytic counter-narrative option
  catalytic_option string @description("Bold counter-narrative with clear mechanism")

  // Safety mechanisms
  safety_rail string @description("Rollback plan, consent boundaries, and measurement approach")

  // Ritual hook - repeatable action that embeds immunity
  ritual_hook string @description("Repeatable action or practice that embeds counter-narrative immunity")

  // Reflexive note - our own memetic payload
  reflexive_note string @description("Transparent note about what memetic vector we are deploying and why")

  // Collateral risk assessment
  collateral_risk float @description("Likelihood our counter-narrative becomes a new retrovirus (0.0-1.0)")

  // Follow-up trigger
  follow_up_trigger string @description("Time or condition that triggers reevaluation")
}

// SerologicScan - for serologic_scan pipeline (MAVEN tool)
// Maps macro → incentives → beneficiaries for memetic analysis
class SerologicScan {
  // The macro/S1 identified
  macro_name string @description("The empty signifier or master signifier (S1) spreading")

  // Host identity - who is carrying/spreading this
  host_identity string @description("Primary demographic or identity group hosting the meme")

  // Incentive surface - why it spreads
  incentive_surface string @description("What incentives drive replication (status, fear, belonging, etc)")

  // Replication channel - how it spreads
  replication_channel string @description("Primary medium/channel enabling spread")

  // Beneficiaries - cui bono
  beneficiaries string[] @description("List of parties who gain from this narrative's spread")

  // Weak link - where to intervene
  weak_link string @description("Most vulnerable point in the replication cycle for intervention")

  // Overall viral load
  viral_load float @description("Memetic viral load score 0.0-1.0")
}

// Generic analysis result for flexible pipelines
class AnalysisResult {
  output string @description("Primary analysis output")
  confidence float @description("Confidence score 0.0-1.0")
  metadata string @description("Additional context or metadata as JSON string")
}

// ========================================
// UTILITY PIPELINES - General Purpose Analysis
// ========================================

// DeepAnalysis - Extended multi-angle analysis
// Used for complex problems requiring extended reasoning
class DeepAnalysis {
  summary string @description("1-2 paragraph executive summary of the analysis")

  technical_perspective string @description("Technical implementation considerations and mechanisms")

  conceptual_perspective string @description("Conceptual framework and theoretical grounding")

  practical_perspective string @description("Real-world application, trade-offs, and constraints")

  edge_cases string[] @description("List of edge cases, failure modes, and boundary conditions")

  connections string[] @description("Related concepts, patterns, or prior art to consider")

  recommendations string[] @description("Concrete actionable recommendations (prioritized)")

  uncertainties string[] @description("What remains uncertain or needs further investigation")
}

// Approach - Single solution approach
class Approach {
  name string @description("Short name for this approach/pattern")

  mechanism string @description("Core idea and how it works (2-3 sentences)")

  strengths string[] @description("What this approach does well")

  weaknesses string[] @description("Limitations, costs, or downsides")

  best_for string @description("Scenario where this approach shines")

  implementation_sketch string @description("High-level steps to implement")
}

// AlternativeApproaches - Multiple solution paths
// Used when exploring different ways to solve a problem
class AlternativeApproaches {
  approaches Approach[] @description("List of 3-5 distinct approaches")

  comparison_matrix string @description("Quick comparison highlighting key differences")

  recommendation string @description("Which approach to try first and why")
}

// CriticalReview - Adversarial analysis
// Used to find weaknesses before committing work
class CriticalReview {
  overall_assessment string @description("High-level judgment of the artifact's quality")

  strengths string[] @description("What works well (be specific)")

  vulnerabilities string[] @description("Weaknesses, risks, and potential failure points")

  missing_considerations string[] @description("What's not addressed that should be")

  edge_cases string[] @description("Scenarios this doesn't handle well")

  specific_suggestions string[] @description("Concrete improvements (prioritized by impact)")

  risk_level string @description("Overall risk: Low, Medium, High, Critical")
}

// ThoughtResponse - Dialogue partner response
// Used for Socratic questioning and assumption challenging
class ThoughtResponse {
  mode string @description("The mode used: challenge, probe, or refine")

  key_questions string[] @description("2-4 sharp clarifying or challenging questions")

  challenges string[] @description("Assumptions being challenged or counterarguments")

  alternative_framings string[] @description("Different ways to think about the problem")

  next_steps string[] @description("Concrete next steps to make progress")

  conversational_response string @description("Full conversational text (for context)")
}

// SynthesisResult - Integrated analysis from multiple sources
// Used to combine information and extract actionable insights
class SynthesisResult {
  executive_summary string @description("High-level synthesis in 2-3 paragraphs")

  key_themes string[] @description("Major themes across all sources")

  points_of_agreement string[] @description("Where sources align or reinforce each other")

  points_of_disagreement string[] @description("Conflicts, tensions, or contradictions")

  information_gaps string[] @description("What's missing or unclear across sources")

  actionable_insights string[] @description("Concrete takeaways and next steps")

  decision_recommendation string @description("If goal was a decision, what's recommended and why")
}
