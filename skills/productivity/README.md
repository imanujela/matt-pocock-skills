# Productivity

General workflow tools, not code-specific.

## User-invoked

Reachable only when you type them (Claude Code: `disable-model-invocation: true`; Codex: `policy.allow_implicit_invocation: false` in `agents/openai.yaml`).

- **[grill-me](./grill-me/SKILL.md)**: Relentless interview that settles a plan or design.
- **[handoff](./handoff/SKILL.md)**: Compact this conversation into a handoff document for the next agent.
- **[rewrite-agent-docs](./rewrite-agent-docs/SKILL.md)**: Rewrite existing agent documents in place, same paths.
- **[teach](./teach/SKILL.md)**: Teach one topic across sessions, in this workspace.
- **[to-questionnaire](./to-questionnaire/SKILL.md)**: A questionnaire that pulls a blocked decision from the one person who can answer it.
- **[wait-what](./wait-what/SKILL.md)**: Re-pitch the message that did not land.

## Model-invoked

Model- or user-reachable. The description is the trigger, not a summary of the steps.

- **[grilling](./grilling/SKILL.md)**: Grill a plan, a decision, or an idea, including when you say grill.
- **[writing-for-agents](./writing-for-agents/SKILL.md)**: Reference for a skill, an AGENTS.md or CLAUDE.md, or a doc an agent reaches by a pointer.
