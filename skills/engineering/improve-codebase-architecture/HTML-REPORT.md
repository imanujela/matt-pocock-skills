# HTML report format

The architectural review is one self-contained HTML file in the OS temp directory. Tailwind and Mermaid both come from CDNs. Mermaid handles graph-shaped diagrams. Hand-built divs and inline SVG handle the editorial visuals (mass diagrams, cross-sections). Mix the two. A report that is all Mermaid starts to look generic.

## Scaffold

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Architecture review for {{repo name}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
    <style>
      .seam { stroke-dasharray: 4 4; }
      .leak { stroke: #dc2626; }
      .deep { background: linear-gradient(135deg, #0f172a, #1e293b); }
    </style>
  </head>
  <body class="bg-stone-50 text-slate-900 font-sans">
    <main class="max-w-5xl mx-auto px-6 py-12 space-y-12">
      <header>...</header>
      <section id="candidates" class="space-y-10">...</section>
      <section id="top-recommendation">...</section>
    </main>
  </body>
</html>
```

## Header

Repo name, date, and a compact legend: solid box = module, dashed line = seam, red arrow = leakage, thick dark box = deep module. No introduction paragraph. Straight into the candidates.

## Candidate card

The diagrams carry the weight. Prose is sparse and uses the glossary terms from the codebase-design skill.

Each candidate is one `<article>`:

- **Title**: short, names the deepening.
- **Badge row**: recommendation strength (`Strong` = emerald, `Worth exploring` = amber, `Speculative` = slate), plus a tag for the dependency category (`in-process`, `local-substitutable`, `ports & adapters`, `mock`).
- **Files**: monospaced list, `font-mono text-sm`.
- **Before / After diagram**: the centrepiece. Two columns, side by side.
- **Problem**: one sentence. What hurts.
- **Solution**: one sentence. What changes.
- **Wins**: bullets, at most 6 words each.
- **ADR callout** (if it applies): one line in an amber-tinted box.

No paragraphs of explanation. If the diagram needs a paragraph, redraw the diagram.

## Diagram patterns

Pick the pattern that fits. Mix them. Variety is part of the point.

### Mermaid graph

Use a Mermaid `flowchart` or `graph` when the point is "X calls Y calls Z, and look at the mess." Wrap it in a Tailwind card. Style leakage edges red and the deep module dark. Sequence diagrams work for "before: 6 round-trips; after: 1."

### Hand-built boxes and arrows

Modules as divs with borders and labels. Arrows as inline SVG. Reach for this when the after diagram should feel like one thick-bordered deep module with greyed-out internals. Mermaid will not render that weight.

### Cross-section

Stack horizontal bands (`h-12 border-l-4`) to show what a call passes through. Before: several thin bands, each doing nothing. After: one thick band labelled with the consolidated responsibility.

### Mass diagram

Two rectangles per module: one for interface surface, one for implementation. Before: the interface rectangle is nearly as tall as the implementation (shallow). After: the interface rectangle is short, the implementation rectangle is tall (deep).

### Call-graph collapse

Before: a tree of calls as nested boxes. After: the same tree collapsed into one box, with the now-internal calls faded inside it.

## Style

- Editorial, not a dashboard. Generous whitespace. `font-serif` works for headings.
- Colour sparingly: one accent (emerald or indigo), red for leakage, amber for warnings.
- Keep diagrams about 320px tall so before and after sit side by side.
- Use `text-xs uppercase tracking-wider` for labels inside diagrams.
- The only scripts are the Tailwind CDN and the Mermaid ESM import. The report is otherwise static.

## Top recommendation

One larger card. Candidate name, one sentence on why, an anchor link to its card. That is the whole section.

## Tone

Plain English. The architectural nouns and verbs come from the codebase-design skill.

**Use exactly:** module, interface, implementation, depth, deep, shallow, seam, adapter, leverage, locality.

**Leave unused as substitutes:** component, service, unit (for module), API, signature (for interface), boundary (for seam). A band in a cross-section is a band, not a substitute noun for a module.

**Phrasings that fit:**

- "The Order intake module is shallow: the interface nearly matches the implementation."
- "Pricing leaks across the seam."
- "Deepen: one interface, one place to test."
- "Two adapters justify the seam: HTTP in production, in-memory in tests."

Wins name the gain in glossary terms: "locality: bugs concentrate in one module", "leverage: one interface, N call sites", "interface shrinks; implementation absorbs the pass-throughs". "Easier to maintain" and "cleaner code" are not in the glossary. Cut them.

No hedging. If a sentence could be a bullet, make it a bullet. If a term is not in the codebase-design glossary, reach for one that is.

**Done when:** the file is self-contained, every candidate has a before/after diagram and a badge, and the top recommendation links to its card.
