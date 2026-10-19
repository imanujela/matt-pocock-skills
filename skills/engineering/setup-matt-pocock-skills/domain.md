# Domain docs

How the engineering skills consume this repo's domain documentation when exploring the codebase.

## Before exploring, read these

- **`GLOSSARY.md`** at the repo root, or
- **`GLOSSARY-MAP.md`** at the repo root if it exists. It points at one `GLOSSARY.md` per context. Read each one relevant to the topic.
- **`docs/adr/`**: read ADRs that touch the area you are about to work in. In a multi-context repo, also check `src/<context>/docs/adr/` for context-scoped decisions.

If any of these files are missing, proceed. Leave their absence unremarked. Suggesting they be created up front is a hard guardrail: the positive target is to proceed, and let `/domain-modeling` create them lazily when a term or a decision is actually resolved. That skill is reached via `/grill-with-docs` and, when a refusal needs recording, via `/deepen-picked`.

## File structure

Single-context repo (most repos):

```
/
├── GLOSSARY.md
├── docs/adr/
│   ├── 0001-event-sourced-orders.md
│   └── 0002-postgres-for-write-model.md
└── src/
```

Multi-context repo (a root `GLOSSARY-MAP.md`):

```
/
├── GLOSSARY-MAP.md
├── docs/adr/                          <- system-wide decisions
└── src/
    ├── ordering/
    │   ├── GLOSSARY.md
    │   └── docs/adr/                  <- context-specific decisions
    └── billing/
        ├── GLOSSARY.md
        └── docs/adr/
```

## Use the glossary's vocabulary

When your output names a domain concept (an issue title, a refactor proposal, a hypothesis, a test name), use the term as `GLOSSARY.md` defines it. Leave synonyms the glossary marks `_Avoid_` unused.

If the concept you need is not in the glossary yet, that is a signal. Either you are inventing language the project does not use (reconsider) or there is a real gap (note it for `/domain-modeling`).

## Flag ADR conflicts

If your output contradicts an existing ADR, surface it. Silent override is a hard guardrail. The positive target is an explicit note:

> Contradicts ADR-0007 (event-sourced orders), but worth reopening because the friction is now load-bearing.
