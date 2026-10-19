## What it does

`grill-me` takes a loose idea and interviews you until you can commit to it. You do not need a worked plan to start. The [session](https://www.aihero.dev/ai-coding-dictionary/session) exists to produce one.

It asks in **rounds**. Each round is the whole **frontier**: every question whose prerequisites you have already settled. It never asks you something that depends on an answer it has not heard yet.

It is [stateless](https://www.aihero.dev/ai-coding-dictionary/stateless). It writes no files and leaves no workspace. The result is a clearer version of the idea, in your head.

## When to reach for it

You invoke this by typing `/grill-me`. The [agent](https://www.aihero.dev/ai-coding-dictionary/agent) will not reach for it on its own. Start it in a fresh conversation, not on top of a plan an agent already wrote.

Reach for it when an idea is worth taking seriously (a feature, a product direction, a business call, a piece of writing) and you have not yet worked out what it involves. Vagueness is the reason to start, not a reason to wait. If you can already specify the thing precisely, you do not need to grill it.

Which grilling skill you want depends on what is in front of you:

| What is in front of you | Reach for |
| --- | --- |
| Anything, anywhere, including a subject that is not code | `grill-me`. No repo, no files |
| A codebase to align against | [grill-with-docs](https://aihero.dev/skills-grill-with-docs). The same interview, [stateful](https://www.aihero.dev/ai-coding-dictionary/stateful): it reads the code and keeps what it learns in `GLOSSARY.md` and ADRs |
| An effort too big for one session | [wayfinder](https://aihero.dev/skills-wayfinder). It charts a map and runs grilling inside it |

Leave [plan mode](https://www.aihero.dev/ai-coding-dictionary/agent-mode) off. Plan mode pushes the agent to produce a plan. You want it to keep asking.

## You steer, it asks

The skill asks the questions. You own the scope. That is the difference between a session that turns an idea into decisions and one that produces confident nonsense.

The failure mode is **passivity**: "agreed, agreed, agreed" for forty questions, and a plan the agent wrote while you nodded. It feels productive because it was long. You decided nothing, and the result looks more certain than it is.

Steering means pushing back on a question that is less detailed than you need, saying when the scope is drifting, and answering "I don't know" and meaning it. The quality of the result depends on the quality of your answers, not on the number of questions.

The opposite error is rarer, and real: staying in the interview so long you never reach code.

## Grillable and ungrillable

Some questions can be answered by talking. Others cannot, and more grilling will not get you there.

"One long form or three pages?" and "how should this interaction feel?" are **ungrillable**. You need something to react to. Stop grilling, build the throwaway with [prototype](https://aihero.dev/skills-prototype), look at it, then come back and answer in one line.

Sessions grow too long when you try to talk through an ungrillable question. The agent keeps rephrasing, you keep guessing, and the scope grows with the uncertainty.

## Common questions

**How many questions should I expect, and how do I know when it ends?**
Count rounds, not questions. Forty-six questions across four rounds is an ordinary session. It ends when the frontier is empty: every branch visited, nothing left as an unstated assumption.

**It asked me two hundred questions. What went wrong?**
Usually the scope was too large. Ask the agent to break the work into smaller pieces, then grill each one. A very long session also drifts into the [dumb zone](https://www.aihero.dev/ai-coding-dictionary/smart-zone), where the [context window](https://www.aihero.dev/ai-coding-dictionary/context-window) is full enough that the questions get worse.

**Can I go back to one question at a time?**
Yes. Add this to your global `CLAUDE.md`:

```
When grilling, ask one question at a time.
```

**What if I genuinely don't know the answer?**
Say so. "I don't know" is a real answer. A question you cannot answer is usually a sign to prototype, not to guess.

**Do I start a fresh session before writing the spec?**
No. The value of the session is the [context](https://www.aihero.dev/ai-coding-dictionary/context) you just built. Hand the same conversation straight to [to-spec](https://aihero.dev/skills-to-spec).

**Does the model matter?**
More than for most skills. Grilling depends on the [model](https://www.aihero.dev/ai-coding-dictionary/model)'s own knowledge of how systems break, so use your best one. Implementation mostly follows context, so a cheaper model is fine there.

## It's working if

- You disagree with something. A session with no pushback is a session you did not need.
- Questions arrive in a few rounds, not one at a time for a long time, and later rounds build on what you said earlier.
- You end somewhere you did not expect, because a question showed a decision you had been making without noticing.
- At the end you could defend each choice to someone who was not there.

## Where it fits

`grill-me` is a standalone you can run anywhere, on anything. Because it is stateless, it needs no repo, workspace, or setup, and it does not assume the idea is software. People use it for business decisions, for writing, and for what to do next.

Portability is the only difference from [grill-with-docs](https://aihero.dev/skills-grill-with-docs). That skill runs the same interview, reads a codebase, and records what it learns as `GLOSSARY.md` and ADRs. Both use [grilling](https://aihero.dev/skills-grilling) underneath. `grill-me` is the user-invoked door that keeps no state.

If what you grilled turns out to be software, hand the same conversation to [to-spec](https://aihero.dev/skills-to-spec) and carry on into the build flow. That is an option, not the point of the skill. When you are unsure which flow fits, [ask-matt](https://aihero.dev/skills-ask-matt) routes you.
