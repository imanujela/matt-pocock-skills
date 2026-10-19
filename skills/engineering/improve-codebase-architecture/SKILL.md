---
name: improve-codebase-architecture
description: Survey a codebase for deepening opportunities and write them up as an HTML report.
disable-model-invocation: true
---

# Improve Codebase Architecture

Survey architectural friction and propose **deepening opportunities**: places a shallow module can become a deep one. The aim is testability and AI-navigability. This skill stops at the report. Deepening a chosen candidate is `/deepen-picked`.

The survey uses the project's domain model and a shared design vocabulary:

- Call the Skill tool with "codebase-design" for **module**, **interface**, **depth**, **seam**, **adapter**, **leverage**, **locality**, and for the deletion test, "the interface is the test surface", and "one adapter means a hypothetical seam, two adapters means a real one". Use those words in every suggestion.
- Read `GLOSSARY.md` for the domain language that names good seams. Read ADRs in the area you are touching so the survey does not re-litigate them.

## Process

### 1. Explore

Deepening pays off where the code keeps changing, so weight recent change over quiet code. Decide where to look before you look.

- If the user named a direction (a module, a subsystem, a pain point), take it.
- Otherwise walk `git log --oneline` far enough to see the hot spots, and let those paths pull attention first. If the changes are scattered with no hot spot, widen the net.

Read `GLOSSARY.md` and any ADRs in the area first.

Then walk the codebase. Note friction as you meet it:

- Understanding one concept requires bouncing between many small modules.
- A module is **shallow**: the interface is nearly as complex as the implementation.
- Pure functions were extracted for testability, and the real bugs hide in how they are called (no **locality**).
- Tightly coupled modules leak across their seams.
- A part of the codebase is untested, or hard to test through its current interface.

Apply the **deletion test**. Deleting a pass-through makes complexity vanish. Deleting a module that earns its keep makes complexity reappear across callers. Keep the second kind.

**Done when:** each friction point names its files, says vanish or reappear, and records whether the direction came from the user or from `git log`.

### 2. Present candidates as an HTML report

Write a self-contained HTML file outside the repo. Resolve the temp dir from `$TMPDIR`, falling back to `/tmp` (or `%TEMP%` on Windows), and write `<tmpdir>/architecture-review-<timestamp>.html`. Open it (`xdg-open` on Linux, `open` on macOS, `start` on Windows) and tell the user the absolute path.

Follow [HTML-REPORT.md](HTML-REPORT.md) for the scaffold, the diagram patterns, and the styling. Tailwind and Mermaid come from CDNs. Mix Mermaid with hand-built visuals. Each candidate gets a before/after diagram.

Each card carries files, the problem, the solution, wins in locality and leverage, the before/after diagram, and a badge: `Strong`, `Worth exploring`, or `Speculative`.

End with a **Top recommendation**: which candidate to deepen first, and why.

Use `GLOSSARY.md` for domain nouns and the codebase-design vocabulary for the architecture. If the glossary defines Order, say "the Order intake module".

Surface a candidate that contradicts an ADR only when the friction is real enough to reopen that ADR. Mark the card: "contradicts ADR-NNNN, but worth reopening because...". Leave theoretical refactors an ADR forbids off the report.

Propose no interfaces here. The report describes the deepening. It does not design the interface.

**Done when:** the HTML file exists outside the repo, it has been opened or the open failure is stated with the absolute path, every card has a before/after diagram and a badge, and the top recommendation is present.

### 3. Hand off the chosen candidate

Ask which candidate to deepen. Wait for a name.

When the user names one, give them `/deepen-picked` plus the candidate title, the files, and the one-line problem. `/deepen-picked` is user-invoked, so the human runs it. This skill does not call it and does not start the deepening.

When the user rejects a candidate for a reason a future survey would need, call the Skill tool with "domain-modeling" and let that skill offer the ADR. Skip ephemeral reasons ("not now") and self-evident ones.

**Done when:** the user has the `/deepen-picked` line for one named candidate (title, files, one-line problem), or a rejection is recorded as an ADR offer or an ephemeral skip, and this skill has proposed no interface.
