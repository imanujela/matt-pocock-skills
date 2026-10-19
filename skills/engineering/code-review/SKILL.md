---
name: code-review
description: Use when the user wants a review of a branch, a PR, work in progress, or the diff since a fixed point.
---

Two-axis review of the diff between `HEAD` and a fixed point the user supplies:

- **Standards**: does the code conform to this repo's documented coding standards?
- **Spec**: does the code faithfully implement the originating issue or spec?

Both axes run as **parallel sub-agents** so they do not pollute each other's context. This skill aggregates their findings.

The issue tracker should have been provided to you. If not, tell the user to run `/setup-matt-pocock-skills`.

## Process

### 1. Pin the fixed point

Whatever the user said is the fixed point (a commit SHA, a branch name, a tag, `main`, `HEAD~5`). If they did not specify one, ask for it and stop.

Capture the diff command once: `git diff <fixed-point>...HEAD` (three-dot, so the comparison is against the merge-base). Note the commits via `git log <fixed-point>..HEAD --oneline`.

Confirm the fixed point resolves (`git rev-parse <fixed-point>`) and the diff is non-empty before going further. A bad ref or an empty diff fails here, not inside two parallel sub-agents.

**Done when:** `git rev-parse` succeeds, the three-dot diff is non-empty, and the commit list is captured. Otherwise you have asked for a fixed point or reported the empty diff.

### 2. Identify the spec source

Look for the originating spec, in this order:

1. Issue references in the commit messages (`#123`, `Closes #45`, GitLab `!67`), fetched via the workflow in the tracker doc.
2. A path the user passed as an argument.
3. A spec file under `docs/`, `specs/`, or `.scratch/` matching the branch name or feature.
4. If nothing is found, ask the user where the spec is. If they say there is not one, the Spec sub-agent skips and reports "no spec available".

**Done when:** the spec path or body is in hand, or the user has said there is no spec.

### 3. Identify the standards sources

Search the repo for every file that documents how code should be written. When `CODING_STANDARDS.md` or `CONTRIBUTING.md` exists, it is on the list.

On top of whatever the repo documents, the Standards axis reads the smell baseline in [SMELL-BASELINE.md](SMELL-BASELINE.md). That file is the implementation. This skill does not restate it. A documented repo standard overrides that file. Each smell is a judgement call. Skip anything tooling already enforces.

**Done when:** the standards-source list is complete (including `CODING_STANDARDS.md` or `CONTRIBUTING.md` if either exists), and the Standards prompt names `SMELL-BASELINE.md` instead of carrying the smell definitions.

### 4. Spawn both sub-agents in parallel

Issue both sub-agent calls together, in the foreground, and aggregate the reports they return.

**Standards sub-agent prompt** includes:

- The full diff command and commit list.
- The list of standards-source files from step 3, plus the path to `SMELL-BASELINE.md` beside this skill. The sub-agent reads that file. The prompt does not paste the smell definitions.
- The brief: "Report, per file or hunk where relevant, (a) every place the diff violates a documented standard: cite the standard (file plus the rule); and (b) any baseline smell you spot: name it and quote the hunk. Distinguish hard violations from judgement calls: documented-standard breaches can be hard, but baseline smells are always judgement calls, and a documented repo standard overrides the baseline. Skip anything tooling enforces. Under 400 words."

**Spec sub-agent prompt** includes:

- The diff command and commit list.
- The path or fetched contents of the spec.
- The brief: "Report: (a) requirements the spec asked for that are missing or partial; (b) behaviour in the diff that was not asked for (scope creep); (c) requirements that look implemented but where the implementation looks wrong. Quote the spec line for each finding. Under 400 words."

If the spec is missing, skip the Spec sub-agent and note that in the final report.

**Done when:** both reports are back, or the Spec axis is explicitly skipped because there is no spec.

### 5. Aggregate

Present the two reports under `## Standards` and `## Spec` headings, verbatim or lightly cleaned. Keep the findings unmerged and unreranked. The two axes are deliberately separate (see Why two axes).

End with a one-line summary: total findings per axis, and the worst issue within each axis (if any). Leave a single winner across axes unpicked. That reranking is what the separation exists to prevent.

**Done when:** both headings are present, findings are not merged, and the one-line summary names a count and a worst issue per axis.

## Why two axes

A change can pass one axis and fail the other:

- Code that follows every standard but implements the wrong thing: **Standards pass, Spec fail.**
- Code that does exactly what the issue asked but breaks the project's conventions: **Spec pass, Standards fail.**

Reporting them separately stops one axis from masking the other.
