# Engineering

Skills for daily code work.

## User-invoked

Reachable only when you type them (Claude Code: `disable-model-invocation: true`; Codex: `policy.allow_implicit_invocation: false` in `agents/openai.yaml`).

- **[ask-matt](./ask-matt/SKILL.md)**: Ask which skill or flow fits your situation. A router over the user-invoked skills in this repo.
- **[grill-with-docs](./grill-with-docs/SKILL.md)**: Grill a plan in a repo and write the glossary and ADRs as terms resolve.
- **[triage](./triage/SKILL.md)**: Move issues through a state machine of triage roles.
- **[improve-codebase-architecture](./improve-codebase-architecture/SKILL.md)**: Survey a codebase for deepening opportunities and write an HTML report.
- **[deepen-picked](./deepen-picked/SKILL.md)**: Deepen one already-chosen module until the interface is small and the behaviour sits behind it.
- **[setup-matt-pocock-skills](./setup-matt-pocock-skills/SKILL.md)**: Configure this repo for the engineering skills (issue tracker, triage labels, domain doc layout). Run once per repo.
- **[to-spec](./to-spec/SKILL.md)**: Turn the current conversation into a spec and publish it to the issue tracker.
- **[to-tickets](./to-tickets/SKILL.md)**: Break a plan, spec, or conversation into tracer-bullet tickets, each declaring its blocking edges.
- **[implement](./implement/SKILL.md)**: Build the work in a spec or set of tickets, driving tdd at pre-agreed seams and closing with code-review before committing.
- **[implement-spec](./implement-spec/SKILL.md)**: Implement a whole spec on one integration branch, working the tickets as a task graph.
- **[wayfinder](./wayfinder/SKILL.md)**: Chart a huge effort as decision tickets on the issue tracker and resolve them one at a time.
- **[retro](./retro/SKILL.md)**: Suggest improvements to the coding agent's environment after a session, most severe first.

## Model-invoked

Model- or user-reachable. The description carries the trigger so the model can reach for them.

- **[prototype](./prototype/SKILL.md)**: Throwaway code that answers one design question: state and logic, or several UI variations.
- **[diagnosing-bugs](./diagnosing-bugs/SKILL.md)**: Diagnosis loop for hard bugs and performance regressions. Build a tight loop that goes red on this bug before theorising.
- **[research](./research/SKILL.md)**: Investigate a question against high-trust primary sources and leave a cited Markdown file.
- **[tdd](./tdd/SKILL.md)**: Red-green loop. One vertical slice at a time, tests at the agreed seam.
- **[domain-modeling](./domain-modeling/SKILL.md)**: Sharpen the domain model: challenge terms, stress-test scenarios, update `GLOSSARY.md` and ADRs inline.
- **[codebase-design](./codebase-design/SKILL.md)**: Shared vocabulary for deep modules: small interfaces, clean seams, tests through the interface.
- **[code-review](./code-review/SKILL.md)**: Two-axis review of the diff since a fixed point: Standards and Spec, in parallel.
- **[pr](./pr/SKILL.md)**: The shape of a pull request body: the smallest visual that makes the change clear, before/after evidence, and a merge-danger call.
- **[wizard](./wizard/SKILL.md)**: An interactive bash wizard for steps only a human can perform.
