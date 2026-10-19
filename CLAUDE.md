Skills live in bucket folders under `skills/`:

- `engineering/`: daily code work
- `productivity/`: daily non-code workflow tools
- `misc/`: kept around, rarely used, not promoted
- `in-progress/`: beta, public on purpose, feedback wanted, not shipped in the plugin
- `deprecated/`: no longer used

`engineering/` and `productivity/` are the **promoted** buckets. Every skill in a promoted bucket has a reference in the top-level `README.md` and an entry in `.claude-plugin/plugin.json`'s `skills` array. The Claude Code plugin ships exactly the promoted set. Skills in `misc/`, `in-progress/`, and `deprecated/` appear in neither.

Install commands are copied verbatim from [.agents/install-block.md](./.agents/install-block.md). `.claude-plugin/marketplace.json` is this repo's marketplace. Every agent, including Claude Code, installs from `imanujela/matt-pocock-skills`. Do not point installs at `claude-plugins-official` or `mattpocock/skills`. After touching either manifest, run `claude plugin validate . --strict`. [ADR 0002](./.agents/adr/0002-ship-as-a-claude-code-plugin.md) records why the set ships as a plugin.

Each skill entry in the top-level `README.md` links the skill name to its `SKILL.md`.

Each bucket `README.md` lists every skill in that bucket with a one-line description, and links the skill name to its `SKILL.md`. Promoted bucket `README.md`s and the top-level `README.md` group entries into **User-invoked** and **Model-invoked**. Non-promoted bucket `README.md`s (`misc/`, `in-progress/`) use a flat list.

Promoted skills also have a human-facing docs page at `docs/<bucket>/<skill-name>.md`. The docs tree mirrors those two bucket folders under `skills/`. The published URL is `https://aihero.dev/skills-<skill-name>` regardless of bucket: the docs path is repo organisation only. When you add, rename, or change the behaviour of a skill in `engineering/` or `productivity/`, create or re-sync its docs page following [.agents/writing-docs.md](./.agents/writing-docs.md). A finished page carries four sections: **What it does**, **When to reach for it**, **Common questions**, and **It's working if**. `writing-docs.md` holds the template, the section order, and where to hunt for the questions. Skills in `misc/`, `in-progress/`, and `deprecated/` get no docs page. The exception is a promoted skill removed outright: its page stays, marked archived (see `writing-docs.md`).

Every `SKILL.md` is either user-invoked (`disable-model-invocation: true` plus `policy.allow_implicit_invocation: false` in `agents/openai.yaml`, reachable only by the human) or model-invoked (reachable by model or user). See [.agents/invocation.md](./.agents/invocation.md).

[`ask-matt`](./skills/engineering/ask-matt/SKILL.md) is the router over every user-reachable skill and how they relate. The same trigger that re-syncs a docs page applies to it: when you add, rename, remove, or change how a user-reachable skill fits the flows, re-read `ask-matt`'s `SKILL.md` and update it so the map stays accurate. A skill it never mentions, or a stale one it still routes to, is a router that lies.

To relink every skill outside `deprecated/` and `misc/` into the local harness skill directories (`~/.claude/skills`, `~/.agents/skills`), run `scripts/link-skills.sh`. Each entry is a symlink into this repo, so a `git pull` keeps installed skills current. Re-run the script after adding, removing, or renaming a skill.

No em-dashes anywhere in this repo's prose (`SKILL.md` files, docs, `README.md`, `CHANGELOG.md`, ADRs, changesets, code comments). When a sentence reaches for one, rewrite it with a comma, a colon, a period, parentheses, or a conjunction, whichever the sentence wants. A blind character substitution is not a rewrite.

## Agent skills

### Triage labels

Canonical names, unchanged. See `docs/agents/triage-labels.md`. Issues are judged against [`SCOPE.md`](./SCOPE.md).
