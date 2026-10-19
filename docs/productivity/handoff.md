## What it does

`handoff` compacts the conversation you are in into a **handoff document**: one markdown file, written to your OS temporary directory rather than the workspace, that a fresh [agent](https://www.aihero.dev/ai-coding-dictionary/agent) can read to pick the work up. The skill reports the absolute path when it writes the file.

What it gives you is portability, not compression, so the skill is narrower than it sounds. You need a file only when the work has to travel: to a new [harness](https://www.aihero.dev/ai-coding-dictionary/harness), a new directory, a colleague, or a side task you want to fork off. If nothing is travelling, you do not need a handoff. Staying in the [session](https://www.aihero.dev/ai-coding-dictionary/session), `/clear`, a [subagent](https://www.aihero.dev/ai-coding-dictionary/subagent), and `/compact` cover the ordinary end of a phase. `/compact` covers it more often than this skill does.

## When to reach for it

You invoke this by typing `/handoff`. The agent will not reach for it on its own. Pass a note about what the next session is for, and the skill writes the document for that purpose.

There are four triggers, and only four:

| Situation | Why a file |
| --- | --- |
| Swapping harness (Claude to Codex) | The new harness cannot see the old [context](https://www.aihero.dev/ai-coding-dictionary/context) |
| Moving to a different directory or repo | A prototype directory is the common case |
| Sending the work to a colleague | They need something they can read |
| Forking a side task found mid-phase | You keep working. A second agent takes the fork |

For anything else (same harness, same directory, you are done [grilling](https://www.aihero.dev/ai-coding-dictionary/grilling) and moving to implementation), use `/compact`. [ask-matt](https://aihero.dev/skills-ask-matt) has the ordered tree over all five options at a phase boundary.

## Branching is the use people skip

Read as session resumption, the skill looks like a worse `/compact`, so people skip it. The fork is the case worth knowing. You stay in your session and hand a copy of the accumulated context to a second agent working in parallel.

That is the detour [prototype](https://aihero.dev/skills-prototype) uses. You are deep in a design conversation, you hit a question only running code will settle, and you do not want to spend the thread you built on finding out. Hand off to a prototype session, get the answer, hand the answer back, and reference it from the original thread. The work crosses over twice. Your original conversation stays live. You re-explain nothing.

Three of the five options at a phase boundary preserve different things. `/compact` preserves your intent. `/clear` preserves nothing. `/handoff` preserves the work's ability to move.

## What travels, and what does not

The document carries the live thread (what is in flight, why, and what is next) plus a **suggested skills** section naming what the next agent should reach for. The skill replaces secrets with placeholders before it writes the file.

It does not carry anything already written down. Specs, plans, ADRs, issues, commits, and diffs appear as paths or URLs, never as copies. The file stays small, and the settled detail stays in one place.

## Common questions

**Handoff or compact?**
`/compact` unless something is travelling. Staying on the same task is a compact, not a handoff. When the harness and directory stay the same and you need to stay in the loop, the phase-boundary tree ends at `/compact` most days. `/handoff` does not summarise better. Its advantage is a file you can carry somewhere `/compact` cannot reach.

**So what's the actual difference between compact, clear and handoff?**
Each one preserves something different. `/compact` compresses this context and continues in a fresh window, so your intent survives. `/clear` empties the window and starts from nothing. That is correct when everything behind you is disposable, and you cannot undo it if it is not. `/handoff` writes a portable file, so the work survives the move. All three turn a [primary source](https://www.aihero.dev/ai-coding-dictionary/primary-source) (the conversation as it happened) into a [secondary source](https://www.aihero.dev/ai-coding-dictionary/secondary-source) (a summary of it). Continuing is the only option that does not, which is why you rule it out first.

**Where did my handoff file go?**
It goes to the temp directory, which is the most-reported problem with the skill. The skill resolves it as `$TMPDIR`, else `/tmp` (`%TEMP%` on Windows), and reports the absolute path. The paths are still long. Keep that path before you move on. Temp is deliberate: a handoff is a document in transit, not an artifact you maintain. Temp is also not durable, as the next question explains.

**My handoff vanished between sessions.**
Some environments clear temp between sessions (Codex is the reported case), and a reboot empties `/private/tmp`. If the next session is not starting within the hour, or is starting under a different harness, copy the file somewhere durable as soon as it is written. The same applies to anything the document points at. If a dispatch references other files in temp, the next agent cannot follow it.

**How do I actually hand it to the next agent?**
Open the fresh session and point it at the path: read this file, then continue. Point at the file rather than pasting the summary into a shell command. The shell mangles a summary that contains backticks or `$(...)` when you interpolate it into `claude "<summary>"`. The usual result is silent truncation rather than an error, so the new agent starts with an incomplete brief and nothing tells you.

**Is this the same as `/branch`, `--fork-session`, or the built-in `/handoff`?**
They are similar, not identical. `/branch` is not a shipped skill here. `/handoff` is the canonical name. A fork inherits an exact copy of the context. This skill produces a targeted compression aimed at a stated next task, in a file. Where a fork will do (same machine, same harness, same directory), a fork is less work. The file is the better choice when the destination is somewhere the fork cannot go.

**When does something belong in `CLAUDE.md` instead?**
Ask whether it is true next month. `CLAUDE.md` is standing context about the project, loaded into every session whether it is relevant or not. A handoff is about one piece of work in flight and is useless once that work lands. A fact you keep re-explaining belongs in `CLAUDE.md`. A half-finished task belongs in a handoff.

**It captures the what, not the why.**
This is a fair criticism, and people raise it often. Two things help. Pass the argument (tell it what the next session is for), so the skill keeps the reasoning that bears on that rather than flattening it. And watch for confident claims the session never verified, such as "X isn't built" or "Y is done". The next agent trusts the document and does not re-check it, so a belief written as a fact becomes a false premise. Read the document before you hand it over, and downgrade anything you only assumed.

**Why is it a skill rather than a slash command?**
Both work. They suit different situations. As a skill, it ships and updates through the same install path as everything else here, which makes it shareable. Its frontmatter, not the mechanism, is what stops the agent from firing it on its own.

## It's working if

- The document is a small fraction of the conversation, and the specs, issues, and diffs appear as paths and URLs rather than copied text.
- You can read it cold, without the original session open, and know what to do next.
- The fresh agent starts working instead of asking you to re-explain the setup.
- In the fork case, your original session is unchanged when you come back to it.
- The suggested-skills section names the skill you would have reached for yourself.
- Nothing in it is a key, a token, or a password.
- You have the absolute path in the reply, and you kept it.

## Where it fits

`handoff` is a reach-for-it-anytime standalone. It works between sessions rather than inside a build chain. It is a narrow one, and you will use it less often than the other four options at a phase boundary. Its closest neighbour is [prototype](https://aihero.dev/skills-prototype), because a prototype lives in its own directory and the round trip out and back is the move this skill is for. When you are at a boundary and unsure whether to continue, clear, hand off, delegate, or compact, [ask-matt](https://aihero.dev/skills-ask-matt) has the tree that orders those five, and routes you across the rest of the set.
