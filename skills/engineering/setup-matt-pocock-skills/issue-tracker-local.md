# Issue tracker: local markdown

Issues and specs for this repo live as markdown files under `.scratch/`.

## Conventions

- One feature per directory: `.scratch/<feature-slug>/`
- The spec is `.scratch/<feature-slug>/spec.md`
- Implementation issues are one file per ticket at `.scratch/<feature-slug>/issues/<NN>-<slug>.md`, numbered from `01`. One file per ticket is the shape. A combined tickets file is the wrong shape.
- Triage state is a `Status:` line near the top of each issue file. Role strings live in `triage-labels.md`.
- Comments append under a `## Comments` heading at the bottom of the file.

## When a skill says "publish to the issue tracker"

Create a new file under `.scratch/<feature-slug>/`. Create the directory if it is missing.

## When a skill says "fetch the relevant ticket"

Read the file at the path the user passed. They will normally pass the path or the issue number.

## Wayfinding operations

Used by `/wayfinder`. The map is one file. Each ticket is a child file.

- **Map**: `.scratch/<effort>/map.md` holds Notes, Decisions so far, and the fog.
- **Child ticket**: `.scratch/<effort>/issues/NN-<slug>.md`, numbered from `01`, question in the body. `Type:` is `research`, `prototype`, `grilling`, or `task`. `Status:` is `claimed` or `resolved`.
- **Blocking**: a `Blocked by: NN, NN` line near the top. A ticket is unblocked when every listed file is `resolved`.
- **Frontier**: scan `.scratch/<effort>/issues/` for files that are open, unblocked, and unclaimed. The lowest number wins.
- **Claim**: set `Status: claimed` and save before any other write.
- **Resolve**: append the answer under `## Answer`, set `Status: resolved`, then append a gist plus link to Decisions so far in `map.md`.

**Done when:** a published ticket is its own file, a fetch read that file, and a claim was saved before any other write on that ticket.
