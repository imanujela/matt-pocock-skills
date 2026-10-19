---
name: writing-fragments
description: "Writing, explore: mine raw fragments before any structure."
disable-model-invocation: true
---

This is **explore**: widen what could be written, and do not commit to structure. Structure is exploit, which is `/writing-beats` or `/writing-shape` when the user asks for it. Until then, keep mining.

Interview the user relentlessly, one round of questions at a time, a recommended answer on each. This is not a design tree: there is no frontier to empty, and the session does not end on a shared understanding. Fragments are the output. Capture a fragment from the first thing the user says, including the opening prompt.

If the user passed a path, that is the file. If they did not, ask once where to save it. If the first message is already a fragment and names no path, hold the fragment, ask once, and write it when the path exists.

## What a fragment is

A fragment is any piece of text that might survive into a later article. The author can tell what it means. It does not need to define its terms or stand alone for a cold reader. The bar is "is this a piece of good writing?", not "is this a self-contained argument?"

Fragments are heterogeneous. Any of these can be one:

- A sharp sentence you would deploy somewhere, and you do not yet know where.
- A claim with a one-line justification.
- A vignette: a thing that happened, a code snippet, a scenario, an analogy.
- A half-thought: "something about how X feels like Y; work this out later."
- A quote, a piece of dialogue, an overheard line.
- A list of related observations that hang together by feel.
- A complaint, a confession, a punchline.
- A **leading word**: one term that names the idea, the way _tracer bullets_ or _fog of war_ names a whole pattern.

The leading word is the fragment that pays forward. Name the right one in explore and it shapes the structure, the transitions, and the title in exploit. When the conversation circles a recurring idea, push for a leading word: a pretrained token if one fits, a coinage only when none does.

The novelist's diary is the model: unstructured noticings, mined later. Fragments are noticings.

## File

On first write the file is one H1 (a working title, free to change later) and the fragments. The body is fragments separated by a blank line, `---`, and a blank line. The only heading is that H1.

```markdown
# Working title

A first fragment lives here.

It can be several paragraphs. It can include lists, code, quotes: whatever
shape the fragment naturally takes.

---

A second fragment.

---

> A quoted line the user wants to keep.

A reaction to it.

---

- A cluster of related observations
- That hang together by feel
- And want to be near each other
```

## Rhythm

1. Re-read the file from disk before every write. The user may have edited, reordered, or deleted between turns. **Done when** the write starts from that read, not from memory.
2. Append as the fragment emerges, and mention the add in one short clause. **Done when** the new fragment is on disk, the user's edits since the last read are still there, and you did not stop the conversation to ask permission for the add.
3. "Cut the last one", "rewrite that one sharper", and "merge those two" are first-class. Edit the named fragment in place. **Done when** the file matches the instruction and no other fragment changed.
4. When the user asks for an outline, a phase plan, or a finished article, tell them which skill to run: `/writing-beats` for a choose-your-own-adventure of beats, `/writing-shape` for block-by-block format arguments. Keep the file as fragments until they leave this skill. **Done when** the body still has no headings, and the reply names the skill they would run for structure.

**Done when** the agreed file starts with one H1, holds every fragment captured this session that the user has not cut, and contains no frontmatter, date, tags, or table of contents.
