---
name: git-guardrails-claude-code
description: Git guardrails for Claude Code. Use when the user wants dangerous git commands blocked before they run.
---

# Setup Git Guardrails

Install a PreToolUse hook that blocks dangerous git commands before Claude runs them. The blocked patterns are `DANGEROUS_PATTERNS` in [scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh). Read that array and report those patterns to the user. The script is the list.

A block exits 2 and prints a BLOCKED line to stderr, so Claude sees that it has no authority to run the command.

## Steps

### 1. Ask scope

Ask whether the guardrail covers this project (`.claude/settings.json`) or every project (`~/.claude/settings.json`).

**Done when:** the user has chosen project or global.

### 2. Copy the hook script

Copy [scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh) to the scope path and make it executable with `chmod +x`.

- Project: `.claude/hooks/block-dangerous-git.sh`
- Global: `~/.claude/hooks/block-dangerous-git.sh`

**Done when:** the destination file exists, is executable, and matches the bundled script.

### 3. Merge the hook into settings

Add the hook to the settings file for the chosen scope. When the file already exists, merge this entry into the existing `hooks.PreToolUse` array and leave every other key as it is.

The JSON shape is the same in both scopes. The command string is the only difference:

- Project: `"$CLAUDE_PROJECT_DIR"/.claude/hooks/block-dangerous-git.sh`
- Global: `~/.claude/hooks/block-dangerous-git.sh`

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "<command-string>"
          }
        ]
      }
    ]
  }
}
```

**Done when:** settings contain a `PreToolUse` matcher of `Bash` whose command is the scope string above, and every pre-existing setting is still present.

### 4. Confirm the pattern list

Ask whether any pattern should be added or removed. Edit `DANGEROUS_PATTERNS` in the copied script so it matches the answer. Leave the bundled script unchanged.

**Done when:** the user has confirmed the list, and the copied script's array matches that confirmation.

### 5. Verify

Run:

```bash
echo '{"tool_input":{"command":"git push origin main"}}' | <path-to-script>
```

**Done when:** the process exits 2 and stderr contains a BLOCKED line for that command.
