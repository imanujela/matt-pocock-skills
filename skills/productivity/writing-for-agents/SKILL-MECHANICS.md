# Skill mechanics

The skill-specific branch of [`writing-for-agents`](SKILL.md): frontmatter, the invocation choice, and router skills. How to write the document is the reference in `SKILL.md`.

## Invocation

Two choices. Each spends a different load.

- A **model-invoked** skill keeps a description, so the agent can fire it, and other skills can reach it. The human can still type the name: model-invocation includes user reach. A description only adds agent discovery. It never removes the human's. The description is the skill's top-level context pointer, forced to stay loaded: context load paid for discoverability. A model-invoked skill whose content is all reference is also one home for shared reference, because another skill can invoke it. Mechanics: omit `disable-model-invocation`. Write a model-facing description that carries one trigger per branch. The pointer rules in `SKILL.md` apply in full. Done when the description names each branch once, front-loads the trigger, and does not summarise the workflow.
- A **user-invoked** skill is reachable only by the human typing its name. No other skill can reach it. Context load is zero. Cognitive load is the price: the human is the index that must remember it exists. Mechanics: set `disable-model-invocation: true`. The description is human-facing: a one-line summary, trigger lists stripped. Done when that flag is set and the description is one line a person can scan.

Pick model-invocation only when the agent must reach the skill on its own, or another skill must. If it only ever fires by hand, make it user-invoked and pay no context load.

Shared reference that two user-invoked skills both need can live in neither: with no model-reachable description, neither can fire the other. Put it in a plain file outside the skill system, external reference any skill can point at.

Done when the invocation choice matches who must reach the skill, and any shared reference two user-invoked skills need sits in a plain file both can point at.

## Splitting by invocation

The sequence cut lives in `SKILL.md`. This is the invocation cut. Split off a model-invoked skill when a distinct leading word should trigger it on its own (a word you actually use in prompts), or another skill must reach it. The new always-loaded description costs context load, so that independent reach has to be worth the cost.

Done when each split skill has a leading word or a caller the parent cannot serve, and you can name the context-load cost you accepted.

## Router skills

When user-invoked skills multiply past what one person can remember, that piled-up cognitive load is cured by a **router skill**: one user-invoked skill that names the others and when to reach for each. The human remembers one skill instead of many. The router can only hint. It cannot fire them: a user-invoked skill has no model-reachable description, so nothing but the human can reach it.

Done when the router names each user-invoked skill it covers and the situation for reaching it, and it tells the human to type that name rather than telling the agent to call the Skill tool on it.
