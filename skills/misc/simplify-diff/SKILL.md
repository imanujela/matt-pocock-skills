---
name: simplify-diff
description: Clean up a recent diff without hunting bugs.
disable-model-invocation: true
---

# Simplify Diff

Cleanup of a recent diff. The code already works. This pass is not a bug hunt.

**Deletion test:** without this skill, a cleanup session either skips the pass or mixes it with a bug hunt.

## Steps

### 1. Capture the diff

Take the diff the user named. When they named none, use `git diff`, then `git diff HEAD` when that is empty. A scoped request uses the matching command: `--staged`, `HEAD~1`, `main...HEAD`, or a path.

**Done when:** you hold the full diff text, or you have stopped because there is no diff and no named files.

### 2. Review four angles

Review the diff for reuse, quality, efficiency, and altitude. Search the repo for the existing function or constant before flagging a duplicate. Before deleting a line, read `git blame` for it. When you cannot tell why a line exists, keep it and mark confidence low.

When you cannot dispatch reviewers, work all four angles yourself in this context, and say so in the summary. Dispatch four reviewers only when you can actually spawn them.

- **Reuse:** duplicated logic. Name the existing thing to call. Do not invent a helper that nothing else calls.
- **Quality:** redundant state, copy-paste-with-variation, stringly-typed codes where a constant exists, nested condition pyramids, comments that restate the next line, defensive checks on already-validated inputs.
- **Efficiency:** repeated reads, sequential independent ops, TOCTOU pre-checks, empty catches. Leave a `pass` in place inside a function whose job is a guaranteed exit. Leave a timeout out when the same key also arrives via a spread dict.
- **Altitude:** a special case at a call site while siblings keep the same flaw, or a wrapper added to avoid editing the thing that needs editing. Name the deeper fix. Leave shared infrastructure you do not own unedited.

A finding names the file, the line, the cost, a confidence (high, medium, or low), and a risk tier. SAFE means behaviour unchanged. CAREFUL means clearer, same semantics. RISKY means it may change behaviour or a public contract.

**Done when:** each finding has an angle, a cost, a confidence, and a risk tier, and the summary states whether the review was inline or four dispatched reviewers.

### 3. Apply SAFE, then CAREFUL

Apply SAFE fixes first. Then apply CAREFUL fixes one file at a time. Leave every RISKY finding unapplied, and name it with its cause.

Report a correctness bug as its own note. Leave it for a `code-review` pass.

**Done when:** every applied edit is SAFE or CAREFUL, and every RISKY finding is still unapplied.

### 4. Verify

Run the repo's check when one exists: its `package.json` `check` or `lint` script, or the CI command that covers the touched files. When a fix fails that check, revert that fix and name it.

**Done when:** the check exits 0, or there is no such command and you have said so, and any reverted fix is named.

### 5. Report

List applied fixes by angle and risk tier. Name each skipped finding with its cause.

**Done when:** the summary lists every applied fix by angle and risk tier, and every skipped finding by name and cause.
