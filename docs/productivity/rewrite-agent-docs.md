## What it does

`rewrite-agent-docs` rewrites a named set of agent documents in place, at the same paths. The defining constraint is the **residual**: the session is not done while any file from the brief is still unaccounted for. Without that list, a rewrite session re-derives the file list and misses files.

It does not write a new article, and it does not rename files. The new text is the whole file. How each document should read lives in [writing-for-agents](https://aihero.dev/skills-writing-for-agents). This skill owns the session that holds the list.

## When to reach for it

You invoke this by typing `/rewrite-agent-docs`. The [agent](https://www.aihero.dev/ai-coding-dictionary/agent) will not reach for it on its own.

| Job | Reach for |
| --- | --- |
| How one document should read: a skill, an `AGENTS.md`, a doc an agent reaches by a pointer | [writing-for-agents](https://aihero.dev/skills-writing-for-agents). Type it, or the agent reaches for it |
| Rewrite a named set in place, and account for every file | `rewrite-agent-docs` |

A brief that names a folder names every file under it, not a sample.

## The residual

The word to think with is **residual**. The inventory is every file the brief names. The residual is every inventoried file not yet rewritten or refused. A refusal is a one-line cause, not a silent skip. The session ends when the residual is empty, or the reply names the miss.

A synonym swap of the first line is not a rewrite. A file that is already doing the work, and would only change by that swap, is refused with that cause.

## Common questions

**How is this different from writing-for-agents?**
`writing-for-agents` is the reference for how a document should read. This skill is the session that holds the file list. No questions have been filed against it yet. The split is the one a reader hits first: one document stays on the reference, a named set comes here.

## It's working if

- The reply lists every file the brief named, each rewritten or refused with a one-line cause.
- Paths are unchanged. Nothing was renamed, and nothing new was appended onto the old text.
- A file you open still does the same job, with a done-condition you can check.
- The list in the reply matches the files on disk. A missing path is a miss, not a finish.

## Where it fits

`rewrite-agent-docs` is a reach-for-it-anytime standalone, and you type it. It is not a step in a build chain. Its neighbour is [writing-for-agents](https://aihero.dev/skills-writing-for-agents), because the levers live there and this skill runs that reference rather than restating it. When you are unsure which skill fits, [ask-matt](https://aihero.dev/skills-ask-matt) routes you.
