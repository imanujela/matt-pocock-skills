## What it does

`deepen-picked` takes one module you have already chosen and deepens it: a small interface, the behaviour behind it. It writes the change, or a spec fragment when the change does not fit the named module. A pass-through is refused in one line.

It does not survey. The candidate is already named. Without this skill the survey stops at a report, and every caller re-derives the deepening.

## When to reach for it

You invoke this by typing `/deepen-picked`, and the [agent](https://www.aihero.dev/ai-coding-dictionary/agent) will not reach for it on its own.

| Your situation | Skill |
| --- | --- |
| A candidate is already named, from a report or by you | This one |
| You do not yet know which module to deepen | [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture) |
| You need the vocabulary, not a change | [codebase-design](https://aihero.dev/skills-codebase-design) |

## Prerequisites

A named candidate: the module, the files, and the friction. The skill reads that code. It writes the change in the repo, or a spec fragment if you ask for one or the change outgrows the module. A new glossary term, or a refusal that is hard to reverse, goes through [domain-modeling](https://aihero.dev/skills-domain-modeling).

## The deletion test

The leading idea is the **deletion test**. Imagine deleting the module. If the complexity vanishes, it was a pass-through and the skill refuses it. If the complexity reappears across callers, the module was earning its keep, and the skill shrinks the interface until tests and callers cross the same seam.

Depth is a property of that interface. The implementation can stay large. The caller-facing surface gets smaller. Callers and tests cross the same seam.

## It's working if

- The reply names one seam and the interface that remains.
- Tests are described as crossing that seam, or the candidate is refused in one line.
- You can see either a code change or a spec fragment, not a fresh survey.

## Where it fits

A chain step after [improve-codebase-architecture](https://aihero.dev/skills-improve-codebase-architecture). A spec fragment re-enters the build flow at [to-spec](https://aihero.dev/skills-to-spec). A change that fits the named module is the work itself. [codebase-design](https://aihero.dev/skills-codebase-design) owns the vocabulary this skill speaks. For which skill fits a situation, [ask-matt](https://aihero.dev/skills-ask-matt) is the map.
