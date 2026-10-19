---
name: ask-matt
description: Ask which skill or flow fits your situation. A router over the skills in this repo.
disable-model-invocation: true
---

# Ask Matt

You do not remember every skill, so ask.

Before stating what a skill does, or recommending that a step be skipped, read that skill's SKILL.md. The lines here are for orientation only.

A **flow** is a path through the skills. Most paths run along one **main flow**. Two **on-ramps** merge onto it. Everything else is standalone, or a vocabulary layer underneath.

Reply with the next slash command, the branch that picked it, and stop. This skill recommends. It does not start the work.

**Done when:** the reply names one next command, says why the neighbour is wrong, and has not invoked that command.

## The main flow: idea to ship

The route most work travels. You have an idea and want it built.

1. **`/grill-with-docs`** sharpens the idea by interview. Start here when you are **working in a working directory**: it keeps what it learns in `GLOSSARY.md` and ADRs. No working directory? Use `/grill-me` (Standalone). Both run `/grilling`. `grill-with-docs` is the one that leaves a paper trail, so it is the better of the two whenever a repo is there to leave it in.
2. **Branch: can conversation settle every question?** If a question needs a runnable answer (state, business logic, a UI you have to see), detour through a prototype, bridged by **`/handoff`** both ways. A prototype lives in its own directory, which is what `/handoff` is for (see Phase boundaries):
   - **`/handoff`** out, then open a fresh session against that file,
   - **`/prototype`** to answer the question with throwaway code,
   - **`/handoff`** back what you learned, and reference it from the original idea thread.
3. **Branch: is this a multi-session build?**
   - **Yes** -> **`/to-spec`**, then **`/to-tickets`**. Each ticket is a tracer bullet and declares its **blocking edges**. Then work the tickets one of two ways:
     - **`/implement`** per ticket, **`/clear`ing context between each one**. On a local tracker that is one file per ticket under `.scratch/<feature>/issues/`, worked blockers-first. On a real tracker the edges become native blocking links, so any ticket whose blockers are done can be grabbed.
     - **`/implement-spec`** for the whole spec in one run. It reads the tickets as a **task graph** and lands the work on one **integration branch**. Reach for it when you would rather orchestrate the build than drive each ticket yourself.
   - **No** -> **`/implement`** in this same context window.

   Either way, the code is built by driving **`/tdd`** (one red-green slice at a time) and closes with **`/code-review`** (Standards and Spec). `/implement` runs both per ticket. `/implement-spec` has each implementer drive `/tdd`, then runs one `/code-review` over the integration branch. Reach for **`/tdd`** alone when you want one behaviour test-first without a full spec, and **`/code-review`** alone when you want to review a branch or PR against a fixed point.

   When the work goes up as a pull request, **`/pr`** shapes the body. It is model-invoked, so the agent reaches for it when it writes a PR.

4. **`/retro`** closes the loop. After a build, and especially one that went sideways, it looks back at the session and suggests changes to the agent's **environment**, not the code. The next build starts from a better environment.

### Context hygiene

Keep steps 1 to 3 in **one unbroken context window** (do not compact or clear until after `/to-tickets`) so the grilling, the spec, and the tickets share the same thinking. Each `/implement` then starts fresh, working from the ticket. Run `/retro` in the session it looks back on, before you clear. After clearing, point it at that session's log.

The limit is the **[smart zone](https://www.aihero.dev/ai-coding-dictionary/smart-zone)**: the window (about 150k tokens on state-of-the-art models) inside which the model still reasons sharply. If a session approaches it before `/to-tickets`, do not push on degraded. `/compact` at the nearest phase boundary and carry on (see Phase boundaries).

## On-ramps

A starting situation that generates work, then merges onto the main flow.

- **Bugs and requests piling up** -> **`/triage`**. It moves issues through triage roles and produces agent-ready issues, which **`/implement`** later picks up.

  Triage is only for issues **you did not create**: bug reports, incoming feature requests, anything that arrives raw. Tickets that `/to-tickets` produced are already agent-ready, so leave them out of triage.

- **Something is broken** -> **`/diagnosing-bugs`**. For the hard ones: the bug that resists a first glance, the intermittent flake, the regression between two known-good states. It builds a **tight feedback loop** (one command that already goes red on *this* bug) before it theorises, then fixes with a regression test. Once the fix is in, run **`/retro`** in the same session. Where the finding is that no seam can lock the bug down, that is **`/improve-codebase-architecture`**, then **`/deepen-picked`** once a candidate is chosen.

- **A huge, foggy effort** (a greenfield project or a huge feature, too big for one session) -> **`/wayfinder`**. It charts a **shared map** of **decision tickets** on the issue tracker and resolves them one at a time, producing **decisions, not deliverables**, until the way is clear. `/grill-with-docs` sharpens an idea you can hold in one session. Wayfinder is for the idea you cannot. Save it for that. A well-scoped feature does not need it.

  When the map clears, **it hands off, it does not build**. Merge onto the main flow at **`/to-spec`**, which collapses the linked decisions into a buildable plan, then `/to-tickets` and `/implement` as usual. Go straight to `/implement` only when the effort turned out genuinely small.

## Codebase health

Not feature work. Upkeep.

- **`/improve-codebase-architecture`** surveys the code for **deepening opportunities** and writes an HTML report. It stops there.
- **`/deepen-picked`** takes one already-chosen candidate and deepens that module. Reach for it after the survey, or whenever the module is already named. It is not a second survey.
- **`/codebase-design`** (below) is the vocabulary both of those speak. Picking a candidate does not start a grill. The deepening skill writes the change or a spec fragment. A spec fragment re-enters the main flow at `/to-spec`.

## Vocabulary underneath

Two model-invoked references. Each is the source of truth for its vocabulary. Reach for them when the **words**, not the process, are the problem, or let the skills above pull them in.

- **`/domain-modeling`**: sharpen the project's domain language. Challenge a fuzzy term, resolve an overloaded word, record a hard-to-reverse decision as an ADR. `/grill-with-docs` drives it to keep `GLOSSARY.md` a clean glossary.
- **`/codebase-design`**: the deep-module vocabulary (module, interface, depth, seam, adapter, leverage, locality). `/tdd`, `/improve-codebase-architecture`, and `/deepen-picked` speak it.

## Phase boundaries

A **phase** is a chunk of work inside a session: the grilling, the implementation, the QA. At the **boundary** between two of them you have five options:

- **Continue**: stay put. Costs nothing, loses nothing.
- **`/clear`**: empty the window, when nothing here matters to what is next.
- **`/handoff`** writes a portable markdown file. Narrow: a **new harness**, a **new directory**, a **colleague**, or a side task forked **mid-phase**.
- **Subagent**: send a tightly scoped task to its own window and get a report back.
- **`/compact`** compresses this context and seeds a fresh session with it. The **default**, at the bottom of the tree rather than the first reach.

Read [PHASE-BOUNDARIES.md](PHASE-BOUNDARIES.md) for the ordered tree. Make the decision **at** a boundary. Mid-phase, continue, or split the rest into subagents.

## Standalone

Off the main flow entirely.

- **`/grill-me`**: the same interview as `/grill-with-docs`, but **stateless**. It saves nothing locally and builds no `GLOSSARY.md`. Reach for it when you are **not working in a working directory**. In a working directory, use `/grill-with-docs`.
- **`/grilling`** is the interview primitive: rounds, the frontier, facts are the agent's job and decisions are yours. `/grill-me` and `/grill-with-docs` are the two named ways in. `/triage` and `/wayfinder` run it internally. Reach for it directly only when you want the interview with no wrapper.
- **`/prototype`** is throwaway code that answers one design question. Throwaway is a constraint on how the code is written, not a promise to destroy it. The answer folds into the real code. The prototype stays as a **primary source** on a `prototype/<name>` branch, pointed at from the implementation issue.
- **`/research`**: a **background agent** investigates a question against **primary sources** and leaves a cited Markdown file. The file is material for `/grill-with-docs`. Research feeds the thinking. It does not replace it.
- **`/to-questionnaire`** is for when the blocker is in **someone else's** head. It writes them a questionnaire. It is the inverse of `/grill-me`: it interviews you about the **send**, and aims the questions at the gap. What comes back is material for `/grill-with-docs` or `/to-spec`.
- **`/wizard`** is for steps only a **human** can take: provisioning, credentials, CI secrets, an unfamiliar dashboard, a one-off migration or cutover. It generates an interactive bash script. If the agent can do the step itself, it should. This is for where a human is genuinely in the loop.
- **`/wait-what`** is the corrective for a message that did not land. Use it mid-conversation, inside any other skill. The agent re-pitches in plain English, using the `GLOSSARY.md` vocabulary. `/grill-with-docs` is the upfront cure.
- **`/teach`**: learn a concept over multiple sessions, using the current directory as a stateful workspace.
- **`/writing-for-agents`** is the reference for documents agents consume: skills, AGENTS.md, pointed-at docs.
- **`/rewrite-agent-docs`**: rewrite a named set of existing agent documents in place (same paths, whole file, no rename). User-invoked. Reach for it when the job is the session that must account for every file. `/writing-for-agents` stays the reference for how each document should read.
- **`/pressure-check`** (in-progress, not promoted): before you call an edited skill or agent doc done, walk one realistic run.
- **`/simplify-diff`** (misc, not promoted): clean up a recent diff without hunting bugs. The user ordered this add. `misc/` is otherwise frozen.

## Precondition

**`/setup-matt-pocock-skills`**: run before your first engineering flow so the issue tracker, triage labels, and doc layout exist. Custom issue trackers also work.
