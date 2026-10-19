---
name: writing-for-agents
description: Use when writing a skill, an AGENTS.md or CLAUDE.md, or a doc an agent reaches by a pointer.
---

Reference for any document an agent consumes: a skill, an `AGENTS.md` or `CLAUDE.md`, a doc reached by a pointer. The packaging differs. The writing does not. The same levers make each one predictable, because the agent takes the same _process_ every run rather than producing the same output.

When the document is a skill, read [`SKILL-MECHANICS.md`](SKILL-MECHANICS.md) for frontmatter, the invocation choice, and router skills. Done when invocation, frontmatter, and any router choice match that file.

When the job is to rewrite an existing set in place and account for every file, and this session is not already `/rewrite-agent-docs`, tell the user to run `/rewrite-agent-docs`. A single document, or a new one, stays here. Inside a `/rewrite-agent-docs` session, apply the levers below. Do not send the user back to that skill.

## Context pointers

A **context pointer** is a reference held in the agent's context that names out-of-context material and encodes when to reach it. A skill's description is one. A line in `AGENTS.md` that names a doc is the same object. The pointer's wording, not its target, decides when the agent reaches the material, and how reliably. A must-have target behind a weak pointer is a variance bug: sharpen the wording first, and inline the material only if sharpening fails.

A pointer does two jobs: state what the material is, and list the **branches** that should trigger reaching it. A branch is a distinct case the document handles, so different runs take different paths through it. Every word of an always-loaded pointer costs on every turn, so it earns harder pruning than the body:

- **Front-load the leading word.** The pointer is where it does its triggering work.
- **One trigger per branch.** Synonyms that rename a single branch are one branch written twice. Collapse them. Keep only genuinely distinct branches.
- **Cut identity the body already carries.**

Done when each branch has one trigger, the leading word is in front, and the pointer does not restate the body.

## The two loads

Every document and pointer spends one of two budgets:

- **Context load** is the cost of always-loaded material on the agent's window: an `AGENTS.md` line, a skill description, anything sitting in context every turn, spending tokens and attention whether or not it fires.
- **Cognitive load** is the cost on the human: which documents exist, and when to reach for each. The human is the index. It is not a cost to minimise. It is the price of human agency. Spend it where human judgement matters. Remove it where it does not.

Material reached only through a pointer escapes context load at the price of the pointer's own line. Material with no pointer at all rides entirely on cognitive load.

## Information hierarchy

A document is built from two content types: **steps** (the ordered actions the agent performs) and **reference** (definitions, rules, and facts consulted on demand). The two mix freely: all steps (a recipe), all reference (a review's rules, this skill), or both. The decision is where each piece sits on the **information hierarchy**, a ladder ranked by how immediately the agent needs the material:

1. **In-file step** is the primary tier: what the agent does, in order.
2. **In-file reference** is consulted on demand. A flat peer-set (every rule of a review on one rung) is a fine arrangement, not a smell.
3. **Disclosed reference** is pushed into a separate file, reached by a context pointer, loaded only when the pointer fires. It spans a sibling file in the same folder through external reference that lives anywhere and any document can point at.

Push too little down and the top bloats. Push too much and you hide material the agent actually needs. That tension is the whole decision.

**Progressive disclosure** is the move down the ladder, out of the main file and behind a pointer, so the top stays legible. It is how the hierarchy is protected, not a token trick. Branching is the cleanest disclosure test: inline what every branch needs, and push behind a pointer what only some branches reach. When a document has steps, in-file reference that should be disclosed buries them. Attending to them becomes a coin-flip: a variance lever, not only a legibility one.

**Co-location** is the within-file companion. The ladder decides how far down a piece sits. Co-location decides what sits beside it once there. Keep a concept's definition, rules, and caveats under one heading, so reading one part brings its neighbours with it. The test: the document should read like documentation written for the agent. Grouped material reads that way. Scattered material does not. Distinct from duplication: duplication repeats one meaning in two places. Scattering fragments one meaning across many.

**Sprawl** is the failure mode here: a document too long, even when every line is live and unique. Attention thins across the excess, and every extra line is one more to keep relevant. The cure is the ladder: disclose reference behind pointers, and split by branch or sequence so each path carries only what it needs.

## Steps and completion criteria

Every step ends on a **completion criterion**, the condition that tells the agent the work is done. Two properties make it a lever:

- **Clarity.** Can the agent tell done from not-done? A vague bound ("understanding reached") invites **premature completion**: ending the step before it is genuinely done, attention slipping to being done. The visible steps still ahead (the **post-completion steps**) supply the pull. The criterion's clarity is the resistance. Defend in order: sharpen the bound first (local and cheap). Only if it is irreducibly fuzzy and you observe the rush, hide the later steps by splitting the sequence. Hiding works across a real context boundary (a handoff or a subagent dispatch). An inline call leaves the later steps in context and clears nothing.
- **Demand.** How much it requires. "Every modified model accounted for" forces thorough work where "produce a change list" does not. Demand drives **legwork** (the digging the agent does within the work, latent in the wording rather than written as its own step). It is not step-bound: "every rule applied" binds a body of flat reference just as "every step done" binds a sequence. That is how an all-reference document still carries an exhaustiveness bar.

The strongest criteria are both checkable and exhaustive. Done when every step in the document ends on a criterion a fresh agent can check, and the criterion names the whole set ("every ... accounted for"), not a sample.

## When to split

Splitting one document into two spends one of the two loads, so split only when the cut earns it:

- **By sequence.** Split a run of steps where the post-completion steps tempt the agent to rush the one in front of it. Keeping them out of view drives more legwork on the current task. The reverse is the hazard: merging sequences exposes each step's later steps to what follows, and invites premature completion.
- **By invocation**, skill-specific. See [`SKILL-MECHANICS.md`](SKILL-MECHANICS.md).

Done when each split has a named load it spends, and a rush or a reach that the unsplit document cannot serve.

## Leading words

A **leading word** is a compact concept already living in the model's pretraining that the agent thinks with while running the document (_lesson_, _fog of war_, _tracer bullet_). Repeated as a token, never as a sentence, it accumulates a distributed definition and anchors a region of behaviour in the fewest tokens, by recruiting priors the model already holds. Coining your own works if you define it clearly, but a made-up word recruits no priors: you pay in definition tokens what a pretrained word gives free. Reach for an existing word first.

It anchors twice. In the body, execution: the agent reaches for the same behaviour every time the word appears, and inside flat reference it focuses attention on a class of thing to look for. In a pointer, invocation: when the same word lives in your prompts, your docs, and your codebase, the agent links that shared language to the material and reaches it more reliably.

Hunt for a triad spelled out at three sites, or a pointer spending a sentence to gesture at one idea. Collapse each into a single token:

- "fast, deterministic, low-overhead" becomes _tight_ (a _tight_ loop).
- "a loop you believe in" becomes _red_, a binary observable state (the loop goes _red_ on the bug, or it does not).

You win twice: fewer tokens, and a sharper hook for the agent to hang its thinking on. Assume every document is carrying restatements that leading words retire. Go find them.

**Negation** is the failure mode beside this lever. Steering by prohibition drags the forbidden behaviour into context and makes it more available, not less. "Don't think of an elephant", and the elephant is all there is. The negation is a weak modifier the strongly activated concept overruns, so the ban half-reads as an instruction to do the thing. Prompt the **positive**: state the target behaviour ("write one-line comments") so the banned one is never spoken. A prohibition earns its place only as a hard guardrail you cannot phrase positively. Even then, pair it with the positive target so attention lands on what to do.

## Pruning

- Keep each meaning in a **single source of truth**: one authoritative place, so changing the behaviour is a one-place edit. **Duplication** (the same meaning in more than one place) costs maintenance and tokens, and inflates a meaning's prominence on the ladder past its real rank. The accidental inverse of a leading word, which repeats a token on purpose, never the meaning.
- The **environment** is a source of truth too (`package.json` scripts, config files, the directory layout, `--help` output). A document that restates it is a **cache**: a copy of a lookup, earning its load only when the lookup is expensive. Cache what the agent cannot find by looking: the unwritten convention, the reason behind a choice, the gotcha no config confesses. Leave the one-file, one-command lookups to the environment, where they cannot go stale.
- Check every line for **relevance**: does it still bear on what the document does? A line loses relevance by never bearing on the task (mere exposition, or a branch that should be disclosed) or by going stale as the behaviour or world it describes changes. Shorter documents are easier to keep relevant. Without a pruning discipline the default fate is **sediment**: stale layers that settle because adding feels safe and removing feels risky, until you must core down through them to find what is still live.
- Hunt **no-ops** sentence by sentence: an instruction the model already obeys by default pays load to say nothing. The test (does it change behaviour versus the default?) is model-relative, not reader-relative. Two people disagreeing about a no-op disagree about the default, and settle it by running the document, not by debate. When a sentence fails, delete the whole sentence rather than trim words from it. The test also grades leading words: a word too weak to beat the default (_be thorough_ when the agent is already thorough-ish) is a no-op, and the fix is a stronger word (_relentless_), not a different technique.

The document you are writing is done when a fresh agent can walk one realistic run without guessing: every step ends on a checkable, exhaustive completion criterion, every pointer names one trigger per branch, every prohibition is paired with the action to take, and a pass finds no duplication, sediment, or no-op left in force.
