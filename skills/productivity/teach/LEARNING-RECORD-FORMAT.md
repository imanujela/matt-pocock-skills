# Learning Record Format

Learning records live in `./learning-records/` and use sequential numbering: `0001-slug.md`, `0002-slug.md`, and so on. Create the directory lazily, on the first record.

They are the teaching equivalent of ADRs. They capture non-obvious lessons, key insights, and stated prior knowledge that will steer later sessions. They are how you place the zone of proximal development.

## Template

```md
# {Short title of what was learned or established}

{1-3 sentences: what was learned (or what prior knowledge was established), and why it matters for later sessions.}
```

That is the whole format. A learning record can be a single paragraph. The value is recording that this is now known, and why it changes what to teach next.

## Optional sections

Include these only when they add something the paragraph cannot carry. Most records need none of them.

- **Status** frontmatter (`active | superseded by LR-NNNN`): when an earlier understanding is replaced.
- **Evidence**: how the user showed the understanding (a question answered, an exercise completed, prior experience cited). Useful when the claim might be revisited.
- **Implications**: what this unlocks or rules out. Worth recording when the consequence is not obvious.

## Numbering

Scan `./learning-records/` for the highest existing number and increment by one. The first record is `0001`.

Done when the new file's number is one higher than the highest file already in the directory, or `0001` when the directory was empty.

## When to write a learning record

Write one when any of these is true:

1. **The user showed genuine understanding of something non-trivial.** Not exposure. Evidence they can use the concept correctly. This sets a new floor for what to teach next.
2. **The user disclosed prior knowledge.** "I already know X." Record it so a later session does not re-teach it. Record the depth they claimed.
3. **A misconception was corrected.** The user believed something wrong and now sees why. These predict later stumbling blocks on related topics.
4. **The mission shifted because of what they learned.** They discovered they cared about something different. Update [[MISSION.md]] and cross-link it.

### What does not qualify

- Material that was only covered. Coverage is not learning. Wait for evidence.
- A term already captured in [[GLOSSARY.md]]. Leave the definition there.
- A session log. A learning record is a decision-grade insight, not a journal.

## Supersession

When a later record contradicts an earlier one, mark the old record `Status: superseded by LR-NNNN`. Keep the old file. The history of how understanding moved is itself a signal.

A record is done when it matches the template, its number is the next free one, and it exists only because one of the four triggers above fired.
