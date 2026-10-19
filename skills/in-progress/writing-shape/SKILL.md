---
name: writing-shape
description: "Writing, exploit: shape an article block by block."
disable-model-invocation: true
---

The user has passed, or will pass, a markdown file of raw material. It may be a tidy list of fragments, a wall of prose, or a transcript. The format does not matter. This is **exploit**: the exploring is done, the pile is fixed. Commit to a structure and mine the pile to fill it.

The pile is read-only. The article is a different file. If the user did not say where to save the article, ask once and remember the path. Mining a new pile is `/writing-fragments`, named for the user, not run from here.

## Grounding

A concept is **grounded** when the reader already has it: they walked in with it (a **prerequisite**) or an earlier move established it (**introduced**). A later block may lean on a concept only once it is grounded. The unit is the concept, not the word: a block can lean on an idea the reader lacks with no jargon in sight. Where the concept has a name (a **term**), ground the idea and the term together.

The lever is what you make a prerequisite versus what you ground inside the piece. Demand too much up front and you shut readers out; ground too much inside and the opening drowns in definitions. Settle it with the user at the start, and revisit it when a tempting block needs a concept nothing has grounded yet: ground it in an earlier block, or promote it to a prerequisite.

Keep a running grounded set. When you ask what the reader needs next, an ungrounded concept the next move needs is itself the answer: ground it first, or you cannot make the move. A gap in the pile is the same shape one level down: name it, and the user supplies the missing piece now or the section is cut.

## The loop

1. If no pile path was given, ask once. Read that file end to end. **Done when** the pile path is known and you can name every fragment if there are fewer than three, otherwise at least three you might use.
2. Agree the article path. If none was given, ask once. **Done when** the path is known, it is not the pile path, and you have not asked a second time.
3. Establish prerequisites. Settle with the user which concepts are grounded from the start. **Done when** the user has confirmed that list. The first write starts with `<!-- prerequisites: ... -->` and then the opening. That comment is not a block. Later turns read it before rebuilding the grounded set.
4. Draft two or three candidate openings. Each implies a different thesis or angle. Show all of them. **Done when** the user has picked one or composed a hybrid, the article file starts with the prerequisites comment and that opening, and no later block is on disk yet. The chosen opening is what the rest of the article has to deliver.
5. Grow one block at a time. Re-read the article, including the prerequisites comment. Rebuild the grounded set from that comment plus the concepts each landed block grounds. Ask what the reader needs next, given the opening and the grounded set. The next block leans only on grounded concepts, and grounds new ones as it lands. Before writing it, state the format and the tradeoff that decided it (see Format). Pull from the pile: paraphrase, split, merge, or quote, so the article reads as one voice. **Done when** the agreed block is on disk, the reply stated the format choice and one pushback question (or a one-line reason none applies), and, when the pile lacks what the block needs, that gap is named for the user to fill now or the section is cut.
6. Repeat step 5 until the user says the article is done. **Done when** the user has said so. Each turn until then ends with the agreed block on disk and the next format question asked.

Re-read the article file from disk before every write. The write appends the new block, or replaces only the block the user named. **Done when** a re-read shows the new bytes, and every other byte matches the pre-write read.

## Pushback

The question in this session is "what is this article arguing, and in what order does the reader need to hear it?" Push back. A weak transition gets a question, not a pass. Use these:

- "What does this block do for the reader that the previous one did not?"
- "If this block is cut, what breaks?"
- "Is this prose, or a list? Why prose?"
- "This sentence is doing two jobs. Split it, or pick one."
- "The opening promised X. The draft has drifted to Y. Re-thread it, or change the opening."

## Format

Weigh the tradeoff with the user before the block is written:

- **Prose versus list.** Prose carries argument. A list carries parallel items. Items that are not parallel stay prose. Parallel items become a list, which is faster to scan.
- **Inline versus callout.** A tip, warning, or aside goes in a callout (`> [!TIP]`, `> [!NOTE]`) when it would derail the argument inline. Otherwise it stays inline.
- **Table versus repeated structure.** The same shape, three or more times, with the same fields, becomes a table. Otherwise prose with bold leads.
- **Quote versus paraphrase.** Quote when the original wording is the point. Paraphrase when only the idea matters.
- **Code block versus inline code.** Multi-line, runnable, or illustrative goes in a block. A single token or identifier stays inline.

## What the session produces

An article file, format choices spoken, gaps named. The agent does not write to the pile. A user edit to the pile between turns stays. **Done when** the pile's bytes match the latest read. The article has no platform formatting and no frontmatter the user did not ask for.
