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
