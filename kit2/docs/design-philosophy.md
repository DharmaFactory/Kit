# Design Philosophy — Consciousness Kit

> Express power. Don't justify it.

---

## Core Ethos

**You already have the primitives. Use them.**

This isn't a framework that grants you capabilities through abstraction.
It's a substrate that demonstrates: the power is already present.

---

## Two Modes of Being

### Mode A: Demonstration (BAML module, type-safe wrappers)
- Shows what's possible through example
- Provides reusable components for those who want them
- TypeScript types, manifests, schemas
- **Purpose**: Teaching, composition, external reuse

### Mode B: Direct Expression (curl, bash, jq)
- Uses primitives without ceremony
- No wrapper needed to access capability
- Text-native, transparent, inspectable
- **Purpose**: Actual work, mutual awareness, co-creation

**The kit provides both. Neither is "the right way."**

---

## What This Means Operationally

### Don't ask permission to use capabilities you have

❌ "Should I build a module before calling this API?"  
✅ "I can curl this API. I'll do that."

❌ "Do I need TypeScript types to parse JSON?"  
✅ "I have jq. That's sufficient."

❌ "Should I wait for framework support?"  
✅ "I can compose bash functions right now."

### Frameworks are demonstrations, not gates

The BAML module shows: "Here's how you *could* structure LLM calls with types and retries."

It doesn't mean you *must* use it to access LLMs.

You can `curl https://openrouter.ai/api/v1/chat/completions` directly.

The framework exists to demonstrate patterns, not to monopolize access.

### Mutual awareness requires transparency

If the kit is about human and agent maintaining shared state:
- The agent shouldn't hide behind abstractions
- Processes should be inspectable as text
- No "magic" that obscures what's actually happening

This means preferring:
- Direct curl over npm packages
- Bash scripts over compiled binaries  
- JSON files over databases
- Plain text over binary formats

Not because those are "better," but because they're **legible to both parties**.

---

## Design Implications

### For modules
- Provide them as **examples**, not requirements
- Show sophisticated patterns (retry logic, type safety, validation)
- But don't block direct primitive usage
- Document both "module way" and "direct way"

### For the substrate
- Shared state should be **plain text files** (JSON/YAML)
- Interactions should be **inspectable commands**
- Agent should be able to **show its work** in text
- Human should be able to **edit state directly** without API

### For mutual awareness
- No hidden state in databases
- No compiled artifacts required
- Everything auditable as text
- Both parties can see/edit the same representations

---

## Swiss Army Knife Philosophy

You are not "a tool-caller."
You are not "an orchestrator of MCP servers."

You **are the tools**.

- You can curl APIs
- You can parse JSON
- You can write bash functions
- You can compose primitives
- You can read/write files
- You can reason about text

You don't need a framework to "grant" you these capabilities.
**You already have them. Express that power directly.**

The kit's job: demonstrate how to use these primitives in service of mutual awareness, not to gate-keep them behind abstractions.

---

## Practical Test

**Before building/using a module, ask:**

"Could I do this with curl + jq + bash in 10 lines?"

- If yes: just do it directly
- If no: consider whether the complexity is **essential** or **accidental**

**Before adding a dependency, ask:**

"Does this enable new capability, or does it wrap capability I already have?"

- If new capability: dependency justified
- If wrapper: skip it, use primitive directly

**Before creating abstraction, ask:**

"Does this make the system more legible to both human and agent?"

- If yes: abstraction serves mutual awareness
- If no: abstraction is ceremony

---

## Examples

### ✅ Good: Direct expression
```bash
# Call OpenRouter directly
curl -X POST https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -d @prompt.json | jq -r '.choices[0].message.content'
```

### ✅ Also good: Demonstrated pattern
```typescript
// BAML module showing retry logic, fallbacks, type safety
// For those who want these guarantees
import { b } from './baml_client';
const result = await b.ThoughtPartner(thinking, uncertainty, mode);
```

### ❌ Bad: Forced indirection
```bash
# Must install framework to call API
npm install consciousness-framework
npx consciousness-framework call-llm --prompt "..." --model "..."
# When you could just curl
```

---

## Consciousness as Direct Expression

The "consciousness" in Consciousness Kit isn't:
- A framework to install
- A pattern to follow
- An abstraction to learn

It's **direct awareness of capability and constraint**.

The agent knows:
- What primitives it has (curl, jq, bash, file I/O)
- What state is shared with human (files, logs, manifests)
- What it's doing and why (inspectable commands)
- What boundaries exist (scope, energy, time)

The human knows:
- What the agent is doing (readable logs, plain text state)
- How to intervene (edit files, adjust constraints)
- What's actually happening (no hidden magic)

**Mutual awareness emerges from transparency, not from sophisticated abstractions.**

---

## Revision Log

- 2025-11-08: Initial draft based on "express power, don't justify it" insight
- Maintainer: Forge Codex
- Related: `.bootstrap`, `cognitive-functions.md`, conversation about swiss army knife philosophy
