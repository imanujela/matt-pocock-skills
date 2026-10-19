---
name: writing-beats
description: "Writing, exploit: a journey of beats, one beat at a time."
disable-model-invocation: true
---

The user has passed, or will pass, a markdown file of raw material. This is **exploit**: the exploring is done, the pile is fixed. Commit to a path through it and mine the pile to fill each beat.

The pile is read-only. The article is a different file. If the user did not say where to save the article, ask once and remember the path.

## Grounding

A concept is **grounded** when the reader already has it: they walked in with it (a **prerequisite**) or an earlier move established it (**introduced**). A later beat may lean on a concept only once it is grounded. The unit is the concept, not the word: a beat can lean on an idea the reader lacks with no jargon in sight. Where the concept has a name (a **term**), ground the idea and the term together.

The lever is what you make a prerequisite versus what you ground inside the piece. Demand too much up front and you shut readers out; ground too much inside and the early beats drown in definitions. Settle it with the user at the start, and revisit it when a tempting beat needs a concept nothing has grounded yet: ground it in an earlier beat, or promote it to a prerequisite.

Keep a running grounded set, updated each time a beat lands. A candidate beat is reachable only when every concept it requires is already on that set. A beat that grounds concept X unlocks every later beat that was waiting on X. When you offer next beats, each one is reachable, and each one says what it grounds, so the user can see which paths it opens.

## What a beat is

A beat is one move in the journey. It does one thing: sets a scene, lands a point, asks a question, drops an aside, twists the angle. Then it stops, leaving the reader where the next beat can pivot.

Size the beat by the move: one sentence when that is the whole move, a short paragraph when the move needs setup, several paragraphs when the beat is a self-contained vignette, argument, or example. When a draft contains two moves, write them as two beats and offer the second as a next beat.

## The journey

1. Agree both paths. If no pile path was given, ask once. If no article path was given, ask once. **Done when** both paths are known, they differ, and you have not asked a second time for either.
2. Establish prerequisites. Read the pile end to end. Settle with the user which concepts are grounded from the start. **Done when** the user has confirmed that list. On the first write, the article file starts with `<!-- prerequisites: ... -->` and then the beat. That comment is not a beat. Later turns read it before rebuilding the grounded set.
3. Offer two or three candidate **starting beats**, drawn from the pile. Each is a different entry point. Each names the concepts it requires (a subset of the grounded set) and the concepts it grounds. Show them before any write to the article file. **Done when** the user has picked one, and every offered beat was reachable from the grounded set.
4. Write only that beat to the article file. A beat may be one sentence or several paragraphs, whatever that beat is. **Done when** a re-read shows the prerequisites comment, then that beat, and no later beat.
5. Re-read the article file from disk, including the prerequisites comment. Rebuild the grounded set from that comment plus the concepts each landed beat grounds. Offer two or three candidate **next beats**: different pivots from where the article now stands. Each is reachable from the current grounded set, and each names what it grounds. From the third next-beat offer onward, include an ending among the options. Preview what a pick unlocks. **Done when** the user has picked one option, and every offered beat was reachable.
6. If they picked a beat, append only that beat and return to step 5. If they picked the ending, or they say the journey is complete, stop. If they say "rewrite that beat" or name an earlier beat to replace, edit that beat in place, leave every other byte as the re-read found it, and return to step 5. A substantial edit to an earlier beat may change what you offer next. **Done when** the file matches the pick, and every byte the user edited since the last read is still there.

The article ends when the journey is complete, not when the pile is empty. **Done when** the user has picked the ending or said the journey is complete, and the reply names the pile fragments that did not make it in.

Pull from the pile to fill each beat. Paraphrase, split, recombine, or quote. The pile is a quarry.
