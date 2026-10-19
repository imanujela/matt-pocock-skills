# Issue tracker: GitLab

Issues and specs for this repo live as GitLab issues. Use the [`glab`](https://gitlab.com/gitlab-org/cli) CLI for every operation.

## Conventions

- **Create an issue**: `glab issue create --title "..." --description "..."`. Use a heredoc for a multi-line description. Pass `--description -` to open an editor.
- **Read an issue**: `glab issue view <number> --comments`. Use `-F json` for machine-readable output.
- **List issues**: `glab issue list -O json` with the `--label` filters the query needs.
- **Comment**: `glab issue note <number> --message "..."`. GitLab calls comments notes.
- **Apply or remove a label**: `glab issue update <number> --label "..."` / `--unlabel "..."`. Several labels can be comma-separated, or the flag can be repeated.
- **Close**: `glab issue close <number>`. Close does not take a comment, so post the explanation first with `glab issue note <number> --message "..."`, then close.
- **Merge requests**: GitLab calls PRs merge requests. Use `glab mr create`, `glab mr view`, `glab mr note`, and the rest. Same shape as `gh pr`, with `mr` in place of `pr` and `note` / `--message` in place of `comment` / `--body`.

Infer the repo from `git remote -v`. `glab` does this when run inside a clone.

## Merge requests as a triage surface

**MRs as a request surface: no.** _(Set to `yes` if this repo treats external merge requests as feature requests. `/triage` reads this flag.)_

When set to `yes`, MRs run through the same labels and states as issues, using the `glab mr` equivalents:

- **Read an MR**: `glab mr view <number> --comments` and `glab mr diff <number>` for the diff.
- **List external MRs for triage**: `glab mr list -F json`, then keep only MRs whose author is not a project member or owner.
- **Comment, label, close**: `glab mr note`, `glab mr update --label` / `--unlabel`, `glab mr close`.

GitLab numbers issues and MRs separately, so `#42` is unambiguous once you know which surface the maintainer means.

## When a skill says "publish to the issue tracker"

Create a GitLab issue.

## When a skill says "fetch the relevant ticket"

Run `glab issue view <number> --comments`.

## Wayfinding operations

Used by `/wayfinder`. The **map** is one issue. Tickets are child issues.

- **Map**: one issue labelled `wayfinder:map`, holding Notes, Decisions so far, and the fog. `glab issue create --label wayfinder:map`. On tiers with native epics, an epic may hold the map. A labelled issue works everywhere.
- **Child ticket**: an issue carrying `Part of #<map>` at the top of its description and a label `wayfinder:<type>` (`research`, `prototype`, `grilling`, `task`). Once claimed, the ticket is assigned to the driving dev.
- **Blocking**: GitLab's native blocking link, the UI-visible representation. Add it with the `/blocked_by #<n>` quick action, posted as a note (`glab issue note <child> --message "/blocked_by #<blocker>"`). Native blocking links are a Premium or Ultimate feature. On the free tier, or where they are unavailable, fall back to a `Blocked by: #<n>, #<n>` line at the top of the description. A ticket is unblocked when every blocker is closed.
- **Frontier query**: `glab issue list -O json` scoped to the map's children. Drop any with an open blocker (a native `blocked_by` link to an open issue via `glab api projects/:id/issues/<child-iid>/links`, or an open issue in the `Blocked by` line) or an assignee. First in map order wins.
- **Claim**: `glab issue update <n> --assignee @me`. That is the session's first write.
- **Resolve**: `glab issue note <n> --message "<answer>"`, then `glab issue close <n>`, then append a context pointer (gist plus link) to the map's Decisions so far.

**Done when:** a publish created an issue, a fetch used `glab issue view`, and a wayfinder claim was the first write on that ticket.
