---
name: claude-handoff
description: Hand this conversation to a background agent that continues the work.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

Write a handoff summary and launch a fresh background agent seeded with it. The job starts in the current working directory. The user manages it with `claude agents`.

If the user passed arguments, they are what the next session focuses on. Shape the summary around that focus.

## Steps

1. Write the summary into the OS temporary directory (`$TMPDIR`, else `/tmp`; `%TEMP%` on Windows), as `claude-handoff-<slug>.md`. `<slug>` is the `--name` lowercased, with spaces turned into hyphens. The workspace is not the destination: the summary becomes the agent's prompt, and a workspace copy would land in the repo.

   The file holds:

   - the focus, the decisions already made, and the next action
   - a **suggested skills** section. A skill is user-invoked when its frontmatter has `disable-model-invocation: true`; otherwise it is model-invoked. Read that flag. A model-invoked skill is named as a Skill tool call. A user-invoked skill is named as a human instruction (`/name`), not as a Skill tool call. If none apply, the section says none.
   - a path or URL for each spec, plan, ADR, issue, commit, and diff the next agent needs. The summary holds only what those artefacts do not already say.
   - a placeholder (`<API-KEY>`, `<PASSWORD>`, `<TOKEN>`, or `<PII>`) wherever an API key, password, token, or a person's name, email, or phone number would have appeared

   The launch reads the file with `cat`. That keeps the shell from expanding backticks or `$` inside the summary.

   **Done when** the file exists at a path you can name, a read-back shows the suggested-skills section, every existing artefact is a pointer rather than a paste, and the read-back contains no raw secret or personally identifiable information.

2. Launch in the same shell that can `cat` the file, so the path is one the command can read:

   ```bash
   claude --bg --name "<descriptive name>" -- "$(cat <summary file>)"
   ```

   `--name` is the display name in the job list, session picker, and terminal title. On Windows, run that line through `bash -lc` so `$(cat ...)` expands. Pass the summary path in the form that shell can read.

   **Done when** `claude agents` lists a job under that exact name, started in the current working directory. If `claude` is not on `PATH`, or the launch exits non-zero after one retry, stop, quote the error, give the summary path, and name that as residual. A different agent runner is not a substitute.
