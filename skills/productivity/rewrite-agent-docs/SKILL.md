---
name: rewrite-agent-docs
description: Rewrite existing agent documents in place, same paths.
disable-model-invocation: true
---

Rewrite a named set of agent documents in place. The replacement is the whole file at the same path: not a new article beside it, and not an append. Without this skill, every rewrite session re-derives the file-list residual and misses files.

This skill owns the session. The writing levers live in `writing-for-agents`. Call the Skill tool with "writing-for-agents" before the first rewrite, and follow it. When a file is a skill, that reference sends you to its mechanics file. Follow that too. If that reference tells you to run this skill, you are already in it: apply the levers, and do not stop to re-invoke.

The brief names the set. A brief that names a folder names every file under it, not a sample.

1. **Inventory the set.** List every file the brief names, including formats, yaml, docs, and root pointers the folder holds. Done when every path under the brief is on the list, and no path outside the brief is on it.

2. **Lock the residual.** Each inventoried path keeps its filename. When the replacement lands, it is the whole file at that same path. Done when each inventoried path is marked unwritten, and the residual equals the inventory.

3. **Rewrite each file.** Apply `writing-for-agents` in place. Keep a skill's `name`. End every step on a completion criterion that is checkable and exhaustive. A user-invoked description is a human one-line summary, triggers stripped. A model-invoked description front-loads the trigger, one trigger per branch, and does not summarise the workflow. Read `agents/openai.yaml` before editing it: preserve unknown keys, keep `policy.allow_implicit_invocation` in agreement with `disable-model-invocation`, and change a string only when it drifted. State the action to take. A prohibition stands only as a hard guardrail, paired with that action. One meaning, one place. Cut a step only when the deletion test says it is a pass-through. When the repo has a `GLOSSARY.md`, read it and use the terms already in force. Use British spelling where the source does. Done when the file is a rewrite under those levers, or refused with a one-line cause, the edit is not a synonym swap of the first line, and the file contains no em dash (U+2014) and no en dash (U+2013).

4. **Walk one run.** Take a fresh agent's point of view and step through one realistic run of each rewritten skill or procedure. Done when each file has been walked, and every stall (a vague done-condition, a pointer that never fires, a term used before it is defined) is fixed in that file.

5. **Emit the list.** Done when the reply lists every inventoried path as rewritten or refused with a one-line cause, and the residual is empty or names the miss.

The session is done when every inventoried file is rewritten or refused with a one-line cause, and that list is in the reply.
