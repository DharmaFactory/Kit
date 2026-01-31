// gan-agent baml_src/types.baml
class AgentGeneratorInput {
  current_prompt string
  eval_history string
  objective string
}

class AgentGeneratorOutput {
  new_prompt string
  rationale string
  expected_improvement string
}

class AgentDiscriminatorInput {
  baseline_prompt string
  candidate_prompt string
  eval_results_baseline string
  eval_results_candidate string
}

class AgentDiscriminatorOutput {
  is_better bool
  score_delta float
  critiques string[]
  suggestions string[]
}

class CycleResult {
  cycle int
  accepted bool
  new_prompt string
  score_delta float
}