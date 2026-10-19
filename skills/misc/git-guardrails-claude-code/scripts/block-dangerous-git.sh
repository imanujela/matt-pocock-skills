#!/bin/bash

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command')

# Extended regexes, matched with grep -E. Keep the unprefixed
# "push --force" and "reset --hard": "git push" misses a flag that is
# not adjacent to git, such as `git -C dir push --force`. Keep
# "git clean -fd" ahead of "git clean -f" so the longer pattern is the
# one named in the BLOCKED line when both match.
DANGEROUS_PATTERNS=(
  "git push"
  "git reset --hard"
  "git clean -fd"
  "git clean -f"
  "git branch -D"
  "git checkout \."
  "git restore \."
  "push --force"
  "reset --hard"
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$pattern"; then
    echo "BLOCKED: '$COMMAND' matches dangerous pattern '$pattern'. The user has prevented you from doing this." >&2
    exit 2
  fi
done

exit 0
