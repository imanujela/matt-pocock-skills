# MISSION.md Format

`MISSION.md` lives at the workspace root. It captures the reason the user is learning this topic. Every teaching decision (what to teach next, which resources to surface, which exercises to design) traces back to this file.

## Template

```md
# Mission: {Topic}

## Why
{1-3 sentences. The concrete real-world goal the user is chasing. What changes in their life or work when they have this skill? Push past "to understand X" to the outcome underneath.}

## Success looks like
- {A specific, observable thing the user will be able to do}
- {Another specific thing}
- {...}

## Constraints
- {Time, budget, prior commitments, learning preferences, anything that bounds the approach}

## Out of scope
- {Adjacent topics the user has said they do not want to chase right now, so the zone of proximal development stays protected}
```

## Rules

- **One mission per workspace.** Two unrelated topics are two workspaces.
- **Concrete over abstract.** "Run a half marathon by October" beats "get fitter." "Ship a Rust CLI to my team" beats "learn Rust."
- **Interview before a vague mission lands.** If the user cannot say why, question them before writing the file. A bad mission steers worse than a missing one.
- **Revise when the goal moves.** Update this file when reality shifts. A stale mission will steer the next session.
- **Keep it to one screen.** Past that, it has stopped being a compass and started being a plan.

A mission file is done when every template heading is present, Why is a concrete outcome the user has confirmed, and the file fits on one screen.
