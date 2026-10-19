# Design it twice

When the user wants alternative interfaces for a chosen deepening candidate, use this parallel sub-agent pattern. The first idea is unlikely to be the best.

Uses the vocabulary in [SKILL.md](SKILL.md): **module**, **interface**, **seam**, **adapter**, **leverage**.

## Process

### 1. Frame the problem space

Before spawning sub-agents, write a user-facing explanation of the problem space:

- The constraints any new interface would need to satisfy
- The dependencies it would rely on, and which category they fall into (see [DEEPENING.md](DEEPENING.md))
- A rough illustrative sketch to ground the constraints. A sketch, not a proposal.

Show this to the user, then go to step 2. The user reads while the sub-agents work.

**Done when:** the constraints, the dependency categories, and the sketch are shown.

### 2. Spawn sub-agents

Spawn 3 or more sub-agents in parallel. Each produces a **radically different** interface for the deepened module.

Prompt each with a separate technical brief (file paths, coupling, dependency category from [DEEPENING.md](DEEPENING.md), what sits behind the seam). The brief is independent of the user-facing explanation in step 1. Give each agent a different design constraint:

- Agent 1: "Minimise the interface. Aim for 1 to 3 entry points. Maximise leverage per entry point."
- Agent 2: "Maximise flexibility. Support many use cases and extension."
- Agent 3: "Optimise for the most common caller. Make the default case trivial."
- Agent 4, if it applies: "Design around two adapters for a cross-seam dependency."

Include both the [SKILL.md](SKILL.md) vocabulary and `GLOSSARY.md` vocabulary so each sub-agent names things the same way.

Each sub-agent outputs:

1. Interface (methods, params, invariants, ordering, error modes)
2. A usage example showing how callers use it
3. What the implementation hides behind the seam
4. Dependency strategy and adapters (see [DEEPENING.md](DEEPENING.md))
5. Trade-offs: where leverage is high, where it is thin

**Done when:** at least three designs are back, and they are not the same interface with renamed methods.

### 3. Present and compare

Present the designs one at a time so the user can absorb each, then compare them. Contrast by **depth** (leverage at the interface), **locality** (where change concentrates), and **seam placement**.

After comparing, give your own recommendation: which design is strongest, and why. If elements from different designs combine well, propose a hybrid. Be opinionated. The user wants a strong read, not a menu.

**Done when:** the comparison names depth, locality, and seam placement, and one recommendation (or one hybrid) is stated.
