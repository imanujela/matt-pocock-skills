# GLOSSARY.md format

## Structure

```md
# {Context Name}

{One or two sentences: what this context is, and why it exists.}

## Language

**Order**:
{One or two sentences.}
_Avoid_: Purchase, transaction

**Invoice**:
A request for payment sent to a customer after delivery.
_Avoid_: Bill, payment request

**Customer**:
A person or organisation that places orders.
_Avoid_: Client, buyer, account
```

## Rules

- **Be opinionated.** When several words exist for the same concept, pick the best one and list the others under `_Avoid_`.
- **Keep definitions tight.** One or two sentences. Define what it is, not what it does.
- **Include only terms specific to this context.** General programming concepts do not belong, even if the project uses them heavily. Before adding a term, ask whether it is unique to this context. Only the unique term belongs.
- **Group terms under subheadings** when natural clusters emerge. If every term belongs to one cohesive area, a flat list is fine.

## Single context and multi-context

**Single context (most repos):** one `GLOSSARY.md` at the repo root.

**Multiple contexts:** a `GLOSSARY-MAP.md` at the repo root lists the contexts, where they live, and how they relate:

```md
# Glossary Map

## Contexts

- [Ordering](./src/ordering/GLOSSARY.md): receives and tracks customer orders
- [Billing](./src/billing/GLOSSARY.md): generates invoices and processes payments
- [Fulfillment](./src/fulfillment/GLOSSARY.md): manages warehouse picking and shipping

## Relationships

- **Ordering to Fulfillment**: Ordering emits `OrderPlaced`. Fulfillment consumes it to start picking.
- **Fulfillment to Billing**: Fulfillment emits `ShipmentDispatched`. Billing consumes it to generate invoices.
- **Ordering and Billing**: shared types for `CustomerId` and `Money`.
```

The skill infers which structure applies:

- If `GLOSSARY-MAP.md` exists, read it to find contexts.
- If only a root `GLOSSARY.md` exists, single context.
- If neither exists, create a root `GLOSSARY.md` lazily when the first term is resolved.

When several contexts exist, infer which one the current topic relates to. If that is unclear, ask.

**Done when:** a new term is in this shape, with an `_Avoid_` line when a synonym was rejected, and no implementation detail has been added.
