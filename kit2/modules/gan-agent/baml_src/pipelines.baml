// gan-agent baml_src/pipelines.baml
function AgentGenerator(input: AgentGeneratorInput) -> AgentGeneratorOutput {
  client PolarisAlpha
  prompt #"
Current: {{ input.current_prompt }}
History: {{ input.eval_history }}
Obj: {{ input.objective }}
Propose better prompt. Output JSON only.
  "#
}

function AgentDiscriminator(input: AgentDiscriminatorInput) -> AgentDiscriminatorOutput {
  client PolarisAlpha
  prompt #"
Baseline: {{ input.baseline_prompt }} scores: {{ input.eval_results_baseline }}
Candidate: {{ input.candidate_prompt }} scores: {{ input.eval_results_candidate }}
Is candidate better? Output JSON only.
  "#
}