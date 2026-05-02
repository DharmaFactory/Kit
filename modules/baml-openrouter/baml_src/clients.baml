// BAML Clients for OpenRouter
// Learn more: https://docs.boundaryml.com/docs/snippets/clients/overview

// OpenRouter clients - env-based API keys (never hardcode!)

// Primary client - Polaris Alpha
client<llm> PolarisAlpha {
  provider "openai-generic"
  retry_policy Exponential
  options {
    base_url "https://openrouter.ai/api/v1"
    api_key env.OPENROUTER_API_KEY
    model "openrouter/sherlock-dash-alpha"
    temperature 0.7
    max_tokens 4000
  }
}

// Backup clients for fallback
client<llm> GPT4o {
  provider "openai-generic"
  retry_policy Exponential
  options {
    base_url "https://openrouter.ai/api/v1"
    api_key env.OPENROUTER_API_KEY
    model "openai/gpt-4o"
    temperature 0.7
    max_tokens 4000
  }
}

client<llm> ClaudeSonnet {
  provider "openai-generic"
  retry_policy Exponential
  options {
    base_url "https://openrouter.ai/api/v1"
    api_key env.OPENROUTER_API_KEY
    model "anthropic/claude-3.5-sonnet"
    temperature 0.7
    max_tokens 4000
  }
}

// Fallback strategy - tries clients in order until one succeeds
client<llm> OpenRouterFallback {
  provider fallback
  options {
    strategy [PolarisAlpha, ClaudeSonnet, GPT4o]
  }
}

// Round-robin strategy - alternates between clients
client<llm> OpenRouterRobin {
  provider round-robin
  options {
    strategy [PolarisAlpha, ClaudeSonnet, GPT4o]
  }
}

// Retry policies
retry_policy Exponential {
  max_retries 3
  strategy {
    type exponential_backoff
    delay_ms 300
    multiplier 1.5
    max_delay_ms 10000
  }
}

retry_policy Constant {
  max_retries 3
  strategy {
    type constant_delay
    delay_ms 500
  }
}
