## What it does

`improve-codebase-architecture` surveys a codebase for **deepening opportunities**: places a shallow module (an interface nearly as complex as the thing it hides) could become a deep one. It writes them as a self-contained HTML report, then stops.

It does not change the code, and it does not design the interface. The run produces a conversation and one HTML file in the OS temp directory. Deepening a candidate you pick is [deepen-picked](https://aihero.dev/skills-deepen-picked), in a later invocation. You can run the survey on a codebase you are not ready to touch.

Two filters keep the report from becoming generic cleanup. First, every candidate must pass the **deletion test**: if you removed this module, would its complexity move behind a smaller interface, or vanish? Only the first case gets a card. Second, unless you point it at a specific area, it reads recent commit history and focuses on paths that change often. A deepening in code nobody touches does not pay back.

## When to reach for it

You invoke this by typing `/improve-codebase-architecture`. The [agent](https://www.aihero.dev/ai-coding-dictionary/agent) will not reach for it on its own.

It is not a step in the main build loop. You run it to queue work that improves the codebase.

| Situation | How it is used |
| --- | --- |
| Routine upkeep | Run it every few days, so the structure does not decay between features. |
| Before a big build | Point it at the [spec](https://www.aihero.dev/ai-coding-dictionary/spec) and ask how to make the change easy. |
| Brownfield audit | Run it on a large, unstructured or [vibe-coded](https://www.aihero.dev/ai-coding-dictionary/vibe-coding) repo. |
| Legacy test work | Use it to find the missing seams before you write tests against untestable code. |

To deepen one module you have already chosen, use [deepen-picked](https://aihero.dev/skills-deepen-picked). To design the interface in the abstract, use [codebase-design](https://aihero.dev/skills-codebase-design). For a whole effort too big for one [session](https://www.aihero.dev/ai-coding-dictionary/session), use [wayfinder](https://aihero.dev/skills-wayfinder). For "this specific thing is broken", use [diagnosing-bugs](https://aihero.dev/skills-diagnosing-bugs).

## Prerequisites

None to run it. If `GLOSSARY.md` or ADRs in `docs/adr/` exist, it reads them and uses your domain's nouns.

The report goes to `<tmpdir>/architecture-review-<timestamp>.html`, outside the repo. Glossary and ADR writes happen later, in `/deepen-picked`, not in this survey.

## Depth, and the report that hunts for it

The skill rests on **depth**. A deep module puts a lot of behaviour behind a small, stable interface. A shallow module exposes its implementation through an interface nearly as wide as the code beneath it. The report looks for three forms of shallowness:

- Pure functions extracted only for testability, while the real bugs are in how callers use them (no **locality**).
- Modules that leak across their **seams**.
- A concept you cannot understand without opening five files.

Each candidate is a card with the files, the friction, a plain-English solution, the benefit in locality and **leverage**, a before/after diagram, and a strength badge.

| Badge | What it means for you |
| --- | --- |
| `Strong` | The deletion test passes clearly and the friction is real. |
| `Worth exploring` | Plausible deepening. The payoff depends on where the code is going next. |
| `Speculative` | Included so you can see it was considered. Most of these can be ignored. |

The report ends with a **Top recommendation**. Then the skill asks which candidate to deepen and gives you the `/deepen-picked` line. No code has changed.

## What happens after you pick one

Type `/deepen-picked` with that candidate's title, files, and one-line problem. That skill names the seam, shrinks the interface, runs the deletion test, and writes the change or a spec fragment. It does not restart the survey.

## Common questions

**It grilled me for an hour about one idea instead of showing me options. Can I turn that off?**

The survey no longer grills. That hour-long interview was the old loop, and it was the most common complaint: the report was supposed to come first, and weaker [models](https://www.aihero.dev/ai-coding-dictionary/model) skipped straight to an interview about the first idea. The survey now stops at the report. Deepening is a separate invocation, `/deepen-picked`, and only for a candidate you name.

**The report opened as unstyled raw HTML with no diagrams. What happened?**

The report loads Tailwind and Mermaid from CDNs, so it needs network access when you open it. If something blocks those scripts, the page breaks with no error. In one reported case a security hook required SRI hashes. The agent added them, but the CDN served different bytes to the browser than to the fetch that computed the hash, so the browser blocked the script. Offline and locked-down environments have the same problem. The agent cannot see it, because it never renders the page. Ask for inline CSS and hand-built SVG diagrams instead of the CDN setup.

**It gave me twelve candidates. Do I work through them in the same session or start a new one?**

One candidate per session. Working through several fills the [context window](https://www.aihero.dev/ai-coding-dictionary/context-window) with the report and the deepening at once. The report is only a temp file. Carry the candidate forward, not the file. Pick one, run `/deepen-picked`, and take a spec fragment into [to-spec](https://aihero.dev/skills-to-spec). Turn the rest into [tickets](https://www.aihero.dev/ai-coding-dictionary/ticket) you can pick up later.

**How should I prompt it?**

Prompt it with the next thing you are building. If a big build is coming, point it at the spec and ask how to make the change easy. A run with no prompt looks for hot spots on its own. That is fine for routine upkeep. A direction makes the report actionable.

**Does it work on a large legacy codebase?**

Partly. It works well on big existing codebases that lack a consistent structure. Users with out-of-control projects report it helped a little and still did not cut it. One developer with an eight-year-old codebase reported the model going in circles, while the same skill produces a clean graph on a tidy repo. If the codebase has no shared vocabulary, run [grill-with-docs](https://aihero.dev/skills-grill-with-docs) first.

**How is this different from `/codebase-design`?**

`/codebase-design` is a reference, not a session driver. It supplies the vocabulary (module, interface, depth, seam, adapter, leverage, locality). This skill uses it. Giving a fresh agent `/codebase-design` as the task fails in a known way: it has no process, so the agent invents one and runs for a long time before it asks you anything. Run this skill, and let it use that one. Deepening a chosen card is `/deepen-picked`.

**Will it ever tell me the codebase is fine?**

Rarely. The skill exists to output findings, so it tends to produce candidates instead of concluding that nothing is wrong. Use the strength badges. If every candidate is `Speculative`, the skill found nothing.

**Does it work in Codex or another harness?**

Partly. The exploration step asks for a sub-agent walk. A [harness](https://www.aihero.dev/ai-coding-dictionary/harness) without that tool may scan in-process instead. The skill still runs. The scan is less thorough.

**How do I actually implement deep modules in TypeScript?**

This skill does not ship a file layout. It tells you where a deepening belongs. `/deepen-picked` writes the change or a spec fragment. You still turn that into a package or directory structure in the language you have.

## It's working if

- The candidates name your domain's concepts, not invented class names.
- The candidates are in files you edited recently, not in parts nobody touches.
- No code changed during the survey. The only new file is the HTML report in your temp directory.
- It stops after the report and gives you a `/deepen-picked` line for the candidate you name.
- Each card explains the payoff as locality or leverage, and says which tests get simpler.

## Where it fits

Periodic maintenance. You run it outside any chain, to queue work, not to do it.

- [codebase-design](https://aihero.dev/skills-codebase-design) owns the vocabulary every candidate uses.
- [deepen-picked](https://aihero.dev/skills-deepen-picked) is the deepening this survey does not finish.
- [domain-modeling](https://aihero.dev/skills-domain-modeling) keeps `GLOSSARY.md` and the ADRs current when a deepening names a new term or refuses one for a lasting reason.

A spec fragment goes back into the main build flow at [to-spec](https://aihero.dev/skills-to-spec). The counterpart at the end of a build is [retro](https://aihero.dev/skills-retro): this skill improves the code the agent works in, and `retro` improves the environment around it. For which skill fits a situation, [ask-matt](https://aihero.dev/skills-ask-matt) is the router.
