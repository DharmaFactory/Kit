#!/bin/bash
# Self-prompt loop for opencode autonomy: generates user-like msgs via SelfPrompt pipeline
# Usage: ./scripts/self_prompt_loop.sh \"overall objective\" [state_file.json]

set -euo pipefail

OBJECTIVE=${1:?"Missing objective arg"}
STATE_FILE=${2:-logs/latest-state.json}

mkdir -p logs/autonomy logs/baml/$(date +%Y-%m-%d)

LOOP_COUNT=0
MAX_LOOPS=20

echo \"#autonomy Self-prompt loop: $OBJECTIVE\" > logs/autonomy/$(date +%Y-%m-%d)-loop.md

while [ $LOOP_COUNT -lt $MAX_LOOPS ]; do
  LOOP_COUNT=$((LOOP_COUNT + 1))
  
  CURRENT_STATE=$(cat $STATE_FILE 2>/dev/null || echo \"Bootstrap loaded, todo empty\")
  
  echo '{\"current_state\": \"'$(echo $CURRENT_STATE | jq -sR . | sed 's/\\\"/\\\\\\\"/g')'\", \"objective\": \"'$(echo $OBJECTIVE | jq -sR . | sed 's/\\\"/\\\\\\\"/g')'\"}' > /tmp/self-prompt-input.json
  
  OUTPUT_LABEL=\"self-loop-$LOOP_COUNT\"
  npx tsx scripts/run_pipeline.ts --pipeline SelfPrompt --input /tmp/self-prompt-input.json --label $OUTPUT_LABEL --summary \"Iteration $LOOP_COUNT\" --force || break
  
  OUTPUT_FILE=\"logs/baml/$(date +%Y-%m-%d)/$OUTPUT_LABEL.json\"
  NEXT_MSG=$(jq -r '.next_user_msg' $OUTPUT_FILE)
  RATIONALE=$(jq -r '.rationale' $OUTPUT_FILE)
  CONF=$(jq -r '.confidence' $OUTPUT_FILE)
  
  echo \"--- $LOOP_COUNT (conf: $CONF) ---\"
  echo \"Rationale: $RATIONALE\"
  echo \"user: $NEXT_MSG\"
  echo \"user: $NEXT_MSG\" >> logs/autonomy/$(date +%Y-%m-%d)-loop.md
  
  echo \"Response: [paste agent output here]\" >> $STATE_FILE
  
  if (( $(echo \"$CONF < 0.6\" | bc -l) )) || [[ $NEXT_MSG == *done* ]] || [[ $NEXT_MSG == *complete* ]]; then
    echo \"Loop done.\"
    break
  fi
done

echo \"Trace: logs/autonomy/$(date +%Y-%m-%d)-loop.md\"
