---
name: retro
description: Suggest environment improvements after a coding session, most severe first.
disable-model-invocation: true
---

# Retro

The user asked for a **retrospective**. Suggest improvements to the coding agent's **environment** so future runs go better.

## Steps

1. Call the Skill tool with "writing-for-agents" for the writing style guide.

   **Done when:** the skill has been called and its style is in use for anything you propose to write.

2. Read the primary sources for the session the user names. That may mean searching session logs on this machine. If the user names no session, use the current one.

   **Done when:** the session is identified and its primary sources have been read, or the search failed and that failure is stated.

3. Look for candidates in these categories. A category with no candidate is a finding too: say none.

- **Navigation**: how easy was it to find the right files? Are there hidden dependencies? Would a **navigation pointer** help? Use this when the session took a long time to find a piece of information.
- **Automated checks**: could a check have caught an error the agent made? Linting, typing, tests, filesystem linters? Read the repo's own check command first (`package.json` or build-tool `lint` / `check` scripts, and the CI workflow). A check that already exists but sits unwired or silently broken is the finding, not a reinvention. A repo with no **guardrail** (no pre-commit hook and no CI job running its lint, typecheck, or test command) is itself a finding. Use this when the agent made a mistake a check could have caught, or the repo has no guardrail at all.
- **Coding standards**: should the **reviewer agent** gain a rule, or lose one, or have one clarified? Classify the violation first. A **mechanical** one (a fixed syntactic pattern, a banned call, an import shape, a file-location rule) gets a deterministic check: a custom rule in the repo's linter, a pre-commit hook, or a CI job, whichever the repo's language and existing guardrail make cheapest. Build the check. Reserve `CODING_STANDARDS.md` for genuine **judgement calls** (cross-file consistency, "matches the surrounding style", anything no guardrail can substitute for). Use this when the reviewer failed to catch a mistake.
- **Global AGENTS.md**: should a steering instruction move to coding standards or to an automated check? Use this when `AGENTS.md` is large, in the repo or in the user's global scope.
- **Tool economy**: did the agent make expensive tool calls that could be streamlined? Is any custom tooling particularly token-inefficient? Use this when an expensive tool call happened.
- **No-ops**: instructions in steering files that do not change the agent's behaviour. Use this when the steering files are large.
- **Information access**: opportunities to increase the agent's access to information. Teeing dev server logs, readonly access to third-party systems. Use this when a crucial piece of information was not available.

   **Done when:** each category has a candidate or an explicit none, tied to something in the session sources.

4. Present the candidates in order of severity.

   **Done when:** the list is ordered, most severe first, and each item names the category.

## Reference

### Implementation vs review

All work goes through two stages: implementation and review. The implementation agent has the most **context pressure**. It explores, writes code, and debugs failures.

The review agent has the least context pressure. It receives a diff, so it does not explore. It often does not write code or debug.

The review agent imposes coding standards. The implementation agent does not carry that burden.

### Files

- `CLAUDE.md` / `AGENTS.md`: pushed into the context window of any agent in this repo. Use them sparingly, usually only for **navigation pointers**.
- `CODING_STANDARDS.md`: read during review, not implementation. Add navigation pointers to docs folders if it grows past 1,000 lines.
- Docs: reference files, pointed at by other files. Look for an existing doc before writing a new one.
- Skills: use skills for docs whose description enters the context window, or for user-invoked commands. Follow `writing-for-agents`.
