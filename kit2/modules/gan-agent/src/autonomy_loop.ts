#!/usr/bin/env tsx
// Mock LLM calls (BAML skip for test)

async function autonomyLoop(task: string, cycles: number = 5) {
  let prompt = 'function isPrime(n) { return n > 1; } // baseline ~0.4 accuracy';
  let history = '';
  for (let i = 0; i < cycles; i++) {
    // Heuristic Generator: mutate prompt
    const gen = generateMutation(prompt, history, task);
    const baselineScore = evalPrime(prompt);
    const candidateScore = evalPrime(gen.new_prompt);
    const disc = discriminate(baselineScore, candidateScore, gen);
    if (disc.is_better && disc.score_delta > 0.1) {
      prompt = gen.new_prompt;
      history += `Cycle ${i}: +${disc.score_delta.toFixed(2)}\n`;
      console.log(`Cycle ${i}: Accepted. Score: ${candidateScore.toFixed(2)}`);
    } else {
      console.log(`Cycle ${i}: Rejected. Score: ${candidateScore.toFixed(2)}`);
    }
  }
  console.log('Final prompt:', prompt);
  console.log('Final score:', evalPrime(prompt).toFixed(2));
}

function generateMutation(current: string, history: string, task: string) {
  const mutations = [
    current.replace(/return n > 1/, 'return n > 1 && !isComposite(n)'),
    'function isPrime(n) { if (n <= 1) return false; for(let i=2; i*i<=n; i++) if(n%i==0) return false; return true; }',
    current + ' // optimized sqrt loop',
    'function isPrime(n) { return n > 1 && [2,3,5,7,11].every(p => n%p || n==p); }' // wrong
  ];
  const new_prompt = mutations[Math.floor(Math.random()*mutations.length)];
  return { new_prompt, rationale: 'mutated for better prime logic' };
}

function discriminate(baselineScore: number, candidateScore: number, gen: any) {
  const score_delta = candidateScore - baselineScore;
  return {
    is_better: score_delta > 0,
    score_delta,
    critiques: score_delta > 0 ? [] : ['No sqrt optimization'],
    suggestions: ['Add i*i<=n loop']
  };
}

function evalPrime(prompt: string): number {
  try {
    // Extract JS code from prompt (simple regex for function)
    const codeMatch = prompt.match(/function\\s+isPrime\\s*\\([^)]*\\)\\s*\\{([^}]+)\\}/s);
    if (!codeMatch) return 0.0;
    const code = `function isPrime(n) {${codeMatch[1]}}`;
    const isPrime = new Function(code + '; return isPrime;')();
    const tests = [[2,true],[3,true],[4,false],[17,true],[1,false]];
    let correct = 0;
    for (let [n, expected] of tests) {
      try {
        if (isPrime(n) === expected) correct++;
      } catch {}
    }
    return correct / tests.length;
  } catch {
    return 0.0;
  }
}

autonomyLoop(process.argv[2] || 'prime check', parseInt(process.argv[3]) || 3);