---
name: implement-spec
description: Implement a whole spec on one integration branch.
disable-model-invocation: true
---

# Implement Spec

You have a spec. It should have tickets that describe how to implement it.

The issue tracker should have been provided to you. If not, tell the user to run `/setup-matt-pocock-skills`.

The goal is the entire spec on a single **integration branch**, with every ticket resolved the way the issue tracker closes work.

The tickets are a **task graph** with blocking relationships, not a list of steps. There is always a **frontier** of tickets ready to grab.

Communication to and from subagents stays sparse. Communicate through **context pointers**: the spec, the tickets, research notes, previous commits. Leave information that a pointer already reaches out of the prompt. That is a hard guardrail paired with the positive target: pointers, not copies.

Run **implementer subagents** in the background where the harness allows it, so the frontier can move in parallel. If background is unavailable, run them in the foreground and say so.

## Steps

1. Read the spec and the tickets until the task graph is clear: which tickets exist, which block which, which are on the frontier.

   **Done when:** you can name the frontier and the blocked set without opening every ticket body again.

2. Optional: use an **exploration subagent** for codebase files or external documentation the tickets require. It must be able to save files. It saves markdown notes in a directory outside the repo, readable by later subagents, so implementers implement rather than explore.

   **Done when:** the notes exist outside the repo, or no exploration was required.

3. Create the integration branch. If the issue tracker closes work through PRs, or the user asks for one, open a draft PR after the first merge in step 5. A branch with no commits ahead of main cannot open one. Mark the PR as closing the spec and the tickets.

   **Done when:** the integration branch exists, and a draft PR exists after the first merge if a PR was required.

4. Use **implementer subagents** for each frontier ticket, each in its own worktree on its own branch. Each implementer:
   - confirms its worktree is based on the integration branch before starting, and resets onto it if not
   - calls the Skill tool with "tdd" to build the ticket
   - merges the integration branch tip into its own branch before reporting done

   **Done when:** every frontier ticket has an implementer, and each report says the worktree was based on the integration branch and then updated to its tip.

5. When an implementer completes, merge its work to the integration branch with a **merger subagent**.

   **Done when:** the implementer's branch is merged into the integration branch.

6. If the merge changes the frontier, start implementers for the newly ready tickets.

   **Done when:** every newly unblocked ticket has an implementer, or the frontier is empty.

7. When every ticket is complete, call the Skill tool with "code-review" on the integration branch. Fix every issue the review raises in a single implementer subagent.

   **Done when:** code-review has been called, and every issue it raised is fixed or explicitly left with the user's agreement.

8. If a draft PR exists, mark it ready for review. Otherwise resolve each ticket the way the issue tracker closes work, and report the integration branch.

   **Done when:** the PR is ready, or each ticket is closed the tracker's way and the branch name has been reported.

9. Clean up every implementer worktree.

   **Done when:** no implementer worktree from this run remains.
