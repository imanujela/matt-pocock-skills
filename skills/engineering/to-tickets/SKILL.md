---
name: to-tickets
description: Break a plan into tracer-bullet tickets, each declaring its blocking edges.
disable-model-invocation: true
---

# To Tickets

Break a plan, spec, or conversation into **tickets**: tracer-bullet vertical slices, each declaring the tickets that **block** it.

The issue tracker and triage label vocabulary should have been provided to you. If not, tell the user to run `/setup-matt-pocock-skills`.

One ticket interface, two adapters. Every ticket carries the same three facts: what to build, acceptance criteria, blocked by. The adapter only changes how the blocking edge is stored: a cross-reference in a local file, or a native link on a real tracker.

## Process

### 1. Gather context

Work from what is already in the conversation. If the user passes a reference (a spec path, an issue number, or a URL), fetch it and read the full body and comments.

**Done when:** the source has been read in full, or the conversation already holds it and no reference was passed.

### 2. Explore the codebase (optional)

If you have not already explored, do so. Ticket titles and descriptions use the project's domain glossary and respect ADRs in the area.

Look for a prefactor that makes the implementation easier. Make the change easy, then make the easy change.

**Done when:** titles can be written in glossary vocabulary, or the conversation already holds that exploration.

### 3. Draft vertical slices

Break the work into **tracer bullet** tickets.

<vertical-slice-rules>

- Each slice cuts a narrow but complete path through schema, interface, UI, and tests. Vertical, not a horizontal slice of one part of the path.
- A completed slice is demoable or verifiable on its own.
- Each slice fits in a single fresh context window.
- Prefactoring comes first.

</vertical-slice-rules>

Give each ticket its **blocking edges**: the other tickets that must complete before it can start. A ticket with no blockers can start immediately.

**Wide refactors are the exception to vertical slicing.** A **wide refactor** is one mechanical change (rename a column, retype a shared symbol) whose **blast radius** fans across the codebase, so a single edit breaks callers everywhere and no vertical slice can land green. Sequence it as expand, then contract. First expand: add the new form beside the old so nothing breaks. Then migrate callers in batches sized by blast radius (per package, per directory). Each batch is its own ticket, blocked by the expand, and CI stays green because the old form still exists. Finally contract: delete the old form once no caller remains, in a ticket blocked by every migrate batch. When even the batches cannot stay green alone, keep the sequence and let them share an integration branch that all block a final integrate-and-verify ticket. Green is promised only there.

**Done when:** every ticket is a vertical slice or an expand, migrate, or contract step, and every ticket names its blockers or says none.

### 4. Quiz the user

Present the breakdown as a numbered list. For each ticket show:

- **Title**: short descriptive name
- **Blocked by**: which other tickets must complete first
- **What it delivers**: the end-to-end behaviour this ticket makes work

Ask whether the granularity feels right, whether each blocking edge genuinely gates the ticket, and whether any ticket should merge or split. Iterate until the user approves.

**Done when:** the user has approved the breakdown.

### 5. Publish

Publish the approved tickets. The tickets are the same either way. Only the blocking-edge encoding changes:

- **Local files** -> one file per ticket under `.scratch/<feature-slug>/issues/<NN>-<slug>.md`, numbered from `01` in dependency order (blockers first). "Blocked by" lists numbers and titles. One ticket per file. Never a single combined file.
- **A real issue tracker (GitHub, GitLab, and the rest)** -> one issue per ticket, blockers first, so each edge can reference a real identifier. Use the platform's native blocking relationship where it has one. Otherwise set "Blocked by" to the blocking issues. If the source was an existing issue, make each ticket its sub-issue (the tracker doc's operation). Apply the `ready-for-agent` triage label unless instructed otherwise.

Work the **frontier**: any ticket whose blockers are all done. A purely linear chain means top to bottom.

Leave any parent issue open and unmodified. That is a hard guardrail: the parent stays the spec. The tickets are the slices.

**Done when:** every approved ticket exists in the tracker, each blocking edge resolves to a real ticket, `ready-for-agent` is applied unless the user said otherwise, and the parent issue is unchanged.

<ticket-interface>

**What to build:** the end-to-end behaviour this ticket makes work, from the user's perspective. Not a part-by-part implementation list.

**Blocked by:** the tickets that gate this one, or "None (can start immediately)". On a real tracker, omit this section when the edges were set as native links.

**Acceptance criteria:**

- [ ] Criterion 1
- [ ] Criterion 2

</ticket-interface>

Local files add a title line `# <NN>: <Ticket title>` and `**Status:** ready-for-agent`. Tracker issues add a Parent section when the source was an existing issue, and omit it otherwise.

In either adapter, keep specific file paths and code snippets out. They go stale. Exception: a prototype snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape) may be inlined, with a note that it came from a prototype. Trim to the decision-rich parts.
