# ADR format

ADRs live in `docs/adr/` and use sequential numbering: `0001-slug.md`, `0002-slug.md`, and so on.

Create `docs/adr/` lazily: only when the first ADR is needed.

## Template

```md
# {Short title of the decision}

{1 to 3 sentences: the context, what was decided, and why.}
```

That is the whole template. An ADR can be a single paragraph. The value is recording that a decision was made and why, not filling sections.

## Optional sections

Include these only when they add something a future reader needs. Most ADRs will not.

- **Status** frontmatter (`proposed | accepted | deprecated | superseded by ADR-NNNN`): useful when decisions are revisited
- **Considered options**: only when the rejected alternatives are worth remembering
- **Consequences**: only when non-obvious downstream effects need to be called out

## Numbering

Scan `docs/adr/` for the highest existing number and increment by one.

## When to offer an ADR

All three must be true:

1. **Hard to reverse**: the cost of changing your mind later is meaningful
2. **Surprising without context**: a future reader will look at the code and wonder why it was done this way
3. **The result of a real trade-off**: genuine alternatives existed, and one was picked for specific reasons

If a decision is easy to reverse, skip it. You will just reverse it. If it is not surprising, nobody will wonder why. If there was no real alternative, there is nothing to record beyond the obvious thing.

### What qualifies

- **Architectural shape.** "We are using a monorepo." "The write model is event-sourced. The read model is projected into Postgres."
- **How contexts talk.** "Ordering and Billing communicate via domain events, not synchronous HTTP."
- **Technology choices that carry lock-in.** Database, message bus, auth provider, deployment target. Not every library. Only the ones that would take a quarter to swap out.
- **Ownership and scope.** "Customer data is owned by the Customer context. Other contexts reference it by ID only." The explicit no is as valuable as the yes.
- **Deliberate deviations from the obvious path.** "We are using manual SQL instead of an ORM because X." Anything a reasonable reader would assume the opposite of. These stop the next person from "fixing" something that was deliberate.
- **Constraints not visible in the code.** "We cannot use AWS because of compliance requirements." "Response times must stay under 200ms because of the partner contract."
- **Rejected alternatives when the rejection is non-obvious.** If GraphQL was considered and REST was picked for a subtle reason, record it. Otherwise someone will suggest GraphQL again in six months.

**Done when:** the file is `docs/adr/NNNN-slug.md`, the number is one higher than the current max, and the body states the decision and why in 1 to 3 sentences.
