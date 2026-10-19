# Matt Pocock Skills

A collection of agent skills (slash commands and behaviours) loaded by the harness. Skills sit in buckets. Per-repo configuration from `/setup-matt-pocock-skills` tells them where to read and write.

## Language

**Issue tracker**:
The tool that hosts a repo's issues: GitHub Issues, GitLab Issues, a local `.scratch/` markdown convention, or another tracker you describe. `to-tickets`, `to-spec`, and `triage` read from it and write to it.
_Avoid_: backlog manager, backlog backend, issue host

**Issue**:
One tracked piece of work inside an **Issue tracker**: a bug, a task, a spec, or a slice produced by `to-tickets`.
_Avoid_: ticket (use only when quoting an external system that calls them tickets, or for a **Decision ticket**)

**Decision ticket**:
A `wayfinder` issue: a child **Issue** of a `wayfinder:map`. It holds a question. The resolution is a decision, not a slice of a build to execute. The **decision** qualifier keeps it distinct from an implementation issue. `wayfinder` introduces the term, then says "ticket".

**Triage role**:
A canonical state-machine label on an **Issue** during triage (for example `needs-triage`, `ready-for-agent`). Each role maps to a real label string in the **Issue tracker** via `docs/agents/triage-labels.md`.

## Relationships

- An **Issue tracker** holds many **Issues**
- An **Issue** carries one **Triage role** at a time
- A **Decision ticket** is an **Issue** (a child of a `wayfinder:map`)

## Flagged ambiguities

- "backlog" used to mean both the tool that hosts issues and the body of work inside it. Resolved: the tool is the **Issue tracker**. "backlog" is no longer a domain term.
- "backlog backend" and "backlog manager". Resolved: both collapsed into **Issue tracker**.
