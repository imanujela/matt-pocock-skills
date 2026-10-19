#!/usr/bin/env bash
# Human-in-the-loop reproduction loop.
# Copy this file, edit the steps below the marker, and run it.
# The agent runs the script. The user follows prompts in their terminal.
#
# Usage:
#   bash hitl-loop.template.sh
#
# Two helpers, and only these two:
#   step "instruction"       show the instruction, wait for Enter
#   capture VAR "question"   show the question, read the response into VAR
#
# At the end, captured values print as KEY=VALUE for the agent to parse.
#
# capture prints its value back to the terminal, where the agent reads it.
# Capture observations. Leave signing in to the user as a step.
# A secret typed into capture lands in the transcript. That is a hard
# guardrail: the positive target is a step the user does off to the side.

set -euo pipefail

step() {
  printf '\n>>> %s\n' "$1"
  read -r -p "    [Enter when done] " _
}

capture() {
  local var="$1" question="$2" answer
  printf '\n>>> %s\n' "$question"
  read -r -p "    > " answer
  printf -v "$var" '%s' "$answer"
}

# --- edit below ---------------------------------------------------------

step "Open the app at the URL that shows the bug, and sign in yourself."

capture ERRORED "Perform the action that should show the bug. Did the symptom appear? (y/n)"

capture ERROR_MSG "Paste the symptom (error text, wrong value, or timing), or 'none':"

# --- edit above ---------------------------------------------------------

printf '\n--- Captured ---\n'
printf 'ERRORED=%s\n' "$ERRORED"
printf 'ERROR_MSG=%s\n' "$ERROR_MSG"
