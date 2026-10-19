# Changes

Local rewrite of mattpocock/skills at `C:\Users\kulku\Downloads\matt-skills`. Not committed. The diagram report is [CHANGES.html](CHANGES.html). The file inventory is in the vault notes `wiki/rewrite_matt_skills.md` and `wiki/changes_to_matt_skills.md`.

## 2026-10-19: smell baseline behind the review seam

Candidate: `code-review`. The interface was as wide as the smell list. Step 3 said the baseline was the copy to paste. Step 4 told the Standards sub-agent to receive that list in full.

**Seam.** The review seam is the diff plus the fixed point. Callers are the two sub-agent prompts. The smell definitions sit behind that seam.

**Interface now.** A caller must know the fixed point, the diff, the standards files in the repo, and the path `skills/engineering/code-review/SMELL-BASELINE.md`. The twelve definitions are implementation.

**Deletion test.** Deleting `SMELL-BASELINE.md` makes the twelve smells reappear in `SKILL.md` and in every Standards prompt. Complexity reappears. The file earns its keep.

**Tests.** There is no code test runner for this skill. The seam check is a read: `Mysterious Name` is in `SMELL-BASELINE.md` and absent from `SKILL.md`. The Standards prompt names the file and does not paste the definitions.

**Files.**

- `skills/engineering/code-review/SMELL-BASELINE.md` (new): the twelve Fowler smells and the two binding rules.
- `skills/engineering/code-review/SKILL.md`: points at that file. The paste instruction is gone.
- `docs/engineering/code-review.md`: the page says the review points at the file.
- Installed copy: `C:\Users\kulku\AppData\Local\hermes\skills\engineering\code-review\` matches the source.

## Earlier the same day

Survey in `CHANGES.html`. The only Strong candidate, extracting `/deepen-picked`, was implemented and installed. Ticket-interface and mock-seam notes were absorbed into the existing modules. Merging `implement` with `implement-spec`, and collapsing the three issue-tracker adapters, were refused by the deletion test.
