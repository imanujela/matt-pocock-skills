---
name: domain-modeling
description: Use when a term in the codebase is fuzzy or overloaded, when GLOSSARY.md is being written or edited, or when an ADR is being recorded or revised.
---

# Domain Modeling

Build and sharpen the project's domain model as you design. This is the active discipline: challenge terms, invent edge-case scenarios, and write the glossary and the decisions down the moment they crystallise.

Reading `GLOSSARY.md` for vocabulary is not this skill. That is a one-line habit any skill can do. This skill is for changing the model, not only consuming it.

## File structure

Most repos have a single context:

```
/
├── GLOSSARY.md
├── docs/
│   └── adr/
│       ├── 0001-event-sourced-orders.md
│       └── 0002-postgres-for-write-model.md
└── src/
```

If `GLOSSARY-MAP.md` exists at the root, the repo has multiple contexts. The map points to where each one lives:

```
/
├── GLOSSARY-MAP.md
├── docs/
│   └── adr/                          <- system-wide decisions
├── src/
│   ├── ordering/
│   │   ├── GLOSSARY.md
│   │   └── docs/adr/                 <- context-specific decisions
│   └── billing/
│       ├── GLOSSARY.md
│       └── docs/adr/
```

Create files lazily: only when you have something to write. If no `GLOSSARY.md` exists, create one when the first term is resolved. If no `docs/adr/` exists, create it when the first ADR is needed.

## During the session

### Challenge against the glossary

When the user uses a term that conflicts with `GLOSSARY.md`, call it out immediately. "Your glossary defines cancellation as X, but you seem to mean Y. Which is it?"

**Done when:** the conflict is either resolved to one term, or the user has been asked and the session is waiting.

### Sharpen fuzzy language

When the user uses a vague or overloaded term, propose a precise canonical term. "You are saying account: do you mean the Customer or the User? Those are different things."

**Done when:** the overloaded word has one canonical term, or the user has been asked.

### Discuss concrete scenarios

When domain relationships are in play, stress-test them with specific scenarios. Invent scenarios that probe the edges and force a precise line between concepts.

**Done when:** at least one concrete scenario has been checked against the relationship under discussion, or no relationship is in play.

### Cross-reference with code

When the user states how something works, check whether the code agrees. If you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible. Which is right?"

**Done when:** the claim has been checked against the code, or there is no code yet to check.

### Update GLOSSARY.md inline

When a term is resolved, update `GLOSSARY.md` immediately. Capture it as it happens. Use the format in [GLOSSARY-FORMAT.md](./GLOSSARY-FORMAT.md).

`GLOSSARY.md` is a glossary and nothing else. Keep implementation details out of it. Treating it as a spec, a scratch pad, or a store of implementation decisions is a hard guardrail: the positive target is a definition of what the term is.

**Done when:** every term resolved in this session is in `GLOSSARY.md` in the format file's shape, with no implementation detail added.

### Offer ADRs sparingly

Offer an ADR only when all three are true:

1. **Hard to reverse**: the cost of changing your mind later is meaningful
2. **Surprising without context**: a future reader will wonder why it was done this way
3. **The result of a real trade-off**: genuine alternatives existed, and one was picked for specific reasons

If any of the three is missing, skip the ADR. Use the format in [ADR-FORMAT.md](./ADR-FORMAT.md).

**Done when:** an ADR was written only if all three were true, or the offer was skipped and the missing condition is named.
