---
name: handoff
description: Compact this conversation into a handoff document for the next agent.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

Write a handoff document a fresh agent can read to continue the work. Save it in the OS temporary directory (`$TMPDIR`, else `/tmp`; `%TEMP%` on Windows), not in the current workspace.

1. **Tailor to the next session.** If the user passed arguments, treat them as what the next session will focus on, and keep the reasoning that bears on that focus. Done when the document's next step matches those arguments, or the user passed none and the document follows the live thread.

2. **Carry the live thread. Reference the rest.** State what is in flight, why, and what is next. Include a "suggested skills" section naming the skills the next agent should call the Skill tool for. Point at specs, plans, ADRs, issues, commits, and diffs by path or URL. Done when every in-flight thread is in the document or named as out of the next session's focus, and every existing artifact appears as a path or URL rather than a copy.

3. **Redact secrets.** Replace API keys, passwords, tokens, and personally identifiable information with a placeholder that names the kind of secret. Done when a pass over the document finds no raw secret and no raw personal identifier.

4. **Report the path.** Done when the reply contains the absolute path of the file that was written.
