---
name: loop-me
description: Grill workflow specs for the loops you want to delegate, in this workspace.
disable-model-invocation: true
argument-hint: "A workflow to design, or nothing to go find one"
---

Run a stateful interview whose only output is **workflow** specs. Call the Skill tool with "grilling" for the interview (rounds, the frontier, a recommended answer on each question). This skill supplies the lens, the vocabulary, and the files. Writing a spec is the output of the interview, not acting on it. Implementing the workflow is a later session.

## Lens

A **loop** is a recurring pattern in the user's life: a career, a week, a morning, one repeated activity. Loops within loops are what make a life predictable enough to **delegate**. Propose loops the user has not named.

A **workflow** is the spec of one loop. You run a workflow on a loop: the loop is the running instantiation. Specs live in `workflows/*.md` and are the source of truth.

## Vocabulary

Reach for a term only when the workflow calls for it. Add an AI step, a checkpoint, or a schedule only when the grilling shows the workflow needs it.

- **Trigger**: what fires each run. An **event** (a new email, a new issue) or a **schedule** (every morning). An event trigger is usually the more efficient; pick the one the grilling supports.
- **Checkpoint**: a human-in-the-loop point where the user verifies or decides. Some workflows have none and run on their own; some use no AI at all.
- **Push right**: defer the checkpoint as far as it will go. Do the maximal work first, so the user is asked once, late, with everything prepared.
- **Brief**: what a checkpoint presents. A **tight**, decision-ready summary: what was produced, why, and a link to the asset. The user reads a brief, not a draft.

## Definition of done

A spec is done when an implementer, given only that file, can name the trigger, the steps, each checkpoint or the explicit absence of one, each brief or the explicit absence of one, and the tools, with no blank left for them to invent.

## Steps

1. Orient. Create `NOTES.md` at the workspace root if it is absent, then read it and `workflows/`. The note holds the user's world: tools, channels, and their own terms for both. It is thin when it does not name the tools and channels this workflow touches. Interview and record those before specifying. Sharpen a fuzzy term into a canonical one as it surfaces, and record it here. **Done when** `NOTES.md` names the tools, channels, and terms this session is using, or the user has said they have nothing to add and the note records that.
2. Choose the loop. If the user named one, that is the subject. If they did not, propose the loops you can see from `NOTES.md` and the files, and let them pick. Recommend `workflows/<slug>.md`. Yes accepts the recommendation. **Done when** that path is agreed, whether the file exists yet or not.
3. Grill that workflow. Call the Skill tool with "grilling". Each frontier question is about the lens, the vocabulary, or a blank the definition of done still has. After each round that settles a decision, the file on disk matches the decision. Create, edit, or delete spec files as decisions land. **Done when** grilling's frontier is empty and the definition of done holds for the spec at the agreed path, and any spec this session deleted is absent from `workflows/`. If the Skill tool cannot load grilling, quote the error and stop; a home-grown interview is not a substitute.
