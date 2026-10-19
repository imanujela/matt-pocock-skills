---
name: wizard
description: Use when a step only a human can perform is in the way: provisioning, credentials, CI secrets, an unfamiliar dashboard, or a one-off migration or cutover.
---

# Wizard

A **wizard** is a bash script that walks a human, step by step, through a manual procedure that is tedious to do by hand and tedious to re-explain. It opens each URL, says exactly what to click and copy, captures the values, writes them where they belong (`.env`, GitHub secrets), confirms at every stage, and shows how many stages are left. It might configure third-party systems, run a one-off migration, or move the project from one state to another.

The UX is already solved by [template.sh](template.sh): stage-by-stage progress, confirmation gates, cross-platform URL opening (including WSL), hidden secret entry, idempotent `.env` upserts, `gh secret` and `gh variable` writes, and a closing summary. Your job is to scope the procedure and author its stages. The library above the `STAGES` marker is identical in every wizard. That consistency is the point. Leave the library as it stands. That is a hard guardrail paired with the positive target: author only the stages below the marker.

A wizard is ephemeral by default: built for one run, saved to a scratch or `scripts/` path, deleted when the job is done. Commit it only when the user wants a repeatable setup path in the repo.

If the agent can perform the step itself, do the step. A wizard is for where a human is genuinely in the loop.

## Process

### 1. Scope the procedure

Work out every manual step the human must take and every value captured along the way. Read the repo first:

- For setup: `.env`, `.env.example`, `.env.*`, `README`, `docker-compose*`, framework config, and `.github/workflows/*`. Every `secrets.*` or `vars.*` reference is a value the wizard must produce.
- For a migration or transition: the current state, the target state, and the irreversible actions between them.

Then show the user the ordered list of stages and the values each produces, and confirm. They may add, drop, or reorder.

**Done when:** every stage is named in order, and for each captured value you know (a) where the human gets it, (b) where it is written (`.env`, a GitHub secret, both, or nowhere), and (c) whether it is secret or public.

### 2. Map each stage's journey

For each stage, write the precise path a human follows: which URL to open, what to do there, where a value is shown, which variable it fills. Where you do not know the current UI or the exact command, say so and ask the user or check the docs. Inventing a click that may not exist is a hard guardrail: the positive target is a path you have checked.

**Done when:** every stage traces to concrete instructions a stranger could follow, and every unknown UI step is marked as asked or checked.

### 3. Author the wizard

Copy the `template.sh` that sits beside this skill to the target path. Replace the example stage with one `stage` per step, in dependency order. Use the library helpers: `stage`, `say`, `step`, `open_url`, `ask`, `ask_secret`, `write_env`, `set_secret`, `set_var`, `pause`, `confirm`. Set `TOTAL_STAGES` to the number of stages you wrote.

Hold the bar the template sets: open the URL before asking for its value, use `ask_secret` for anything secret, `write_env` every persisted value, `set_secret` only the values CI actually needs, and `confirm` before any irreversible action. Each `stage` clears the screen, so keep a stage to one focused task.

**Done when:** the target script exists, `TOTAL_STAGES` matches the `stage` calls, and the library above the marker is unchanged.

### 4. Verify and hand off

- `bash -n <script>`. Run `shellcheck` if it is available.
- `chmod +x <script>`.
- Trace it statically. It opens browsers and blocks on human input, so an end-to-end run is the human's. Every value from step 1 is captured and lands where step 1 said, and every `set_secret` name matches a `secrets.*` reference in CI.
- Tell the user how to run it. If it is a repeatable setup path, commit it and link it from the README so the next person runs the script.

**Done when:** `bash -n` passes, the static trace matches step 1, and the user has the run command.
