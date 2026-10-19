---
name: pressure-check
description: Walk one realistic run before calling an edited skill or agent doc done.
disable-model-invocation: true
argument-hint: "The skill or agent doc to walk"
---

# Pressure check

Walk one realistic run of an edited skill or agent doc before calling it done. Name each stall. Apply one lever. Re-walk the same run.

Without this skill, "done" is a feeling and the walk never happens.

The document is the `SKILL.md` or agent doc (`AGENTS.md`, `CLAUDE.md`) the user named. If they named a skill directory, the document is its `SKILL.md`. If they named nothing, take the one in `git status`, or the session's last edit of one of those files. If several qualify, or none do, ask once.

A **stall** is a step where the next action is not determined by the document, so the agent would have to guess. A loop is walked once, plus the exit. You do not role-play the whole session.

## Levers

Apply exactly one lever per stall, the one that removes the guess:

- **Sharpen the bound**: replace a vague done-condition with a checkable, exhaustive one.
- **Disclose the reference**: the guessed fact already lives in a file, a tool, or another skill. Point at that source. Inline the fact only when the pointer still leaves a guess.
- **Strengthen the leading word**: replace a weak restatement with a pretrained token the document already thinks in (`tight`, `red`, `seam`, `depth`, `tracer bullet`, or the document's own leading word).
- **Cut the no-op**: delete a sentence that does not change behaviour versus the default. Delete the whole sentence.

A prohibition earns a place only as a hard guardrail, paired with the positive action in the same step.

## Steps

1. Write the run down: one user message, the files that exist or are absent, and what finished looks like to the caller. **Done when** that run is in the reply, and a second scenario has not been substituted.
2. Walk every step the document names, in order, until its own done-condition or the first stall you cannot yet fix. **Done when** each step is either determined by the document or named as a stall, with the guess quoted.
3. Apply one lever per stall, in the document. If you cannot edit the document, name each stall and the lever, and the missing edit is the residual. **Done when** each stall has one lever applied in the document, or is named residual because no lever removes the guess or the edit could not land.
4. Re-walk the same run. **Done when** the run completes without a guess, or the reply names the remaining stall as residual. A new scenario is not a re-walk.

Call the document done only when step 4 holds.
