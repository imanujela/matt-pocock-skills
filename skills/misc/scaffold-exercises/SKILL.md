---
name: scaffold-exercises
description: Scaffold exercises. Use when stubbing a course section, or when moving or renumbering exercises.
---

# Scaffold Exercises

Create exercise directories that pass `pnpm ai-hero-cli internal lint`, then commit them with `git commit`.

## Directory names

- Sections: `XX-section-name/` inside `exercises/` (for example `01-retrieval-skill-building`)
- Exercises: `XX.YY-exercise-name/` inside a section (for example `01.03-retrieval-with-bm25`)
- Section number is `XX`, exercise number is `XX.YY`
- Names are lowercase with hyphens

## What each exercise contains

Each exercise has at least one of `problem/`, `solution/`, or `explainer/`. Stub `explainer/` unless the plan names other variants.

Each variant folder has a `readme.md` with a title and one description line, and no broken links:

```md
# Exercise Title

Description here
```

A variant that contains code also has a `main.ts` of more than one line. A stub is readme-only.

The linter (`pnpm ai-hero-cli internal lint`) accepts the tree when:

- at least one of `problem/`, `explainer/`, or `explainer.1/` exists
- the primary subfolder's `readme.md` exists and is non-empty
- the tree has no `.gitkeep`, no `speaker-notes.md`, no broken readme links, and no `pnpm run exercise` command in a readme
- each subfolder is readme-only, or has a `main.ts`

## Steps

### 1. Parse the plan

Extract section names, exercise names, and variant types (`problem`, `solution`, `explainer`). Where the plan names no variant, use `explainer`.

**Done when:** every section and exercise has a dash-case path and a variant list.

### 2. Create the directories

Run `mkdir -p` for each variant path.

**Done when:** every parsed path exists on disk.

### 3. Write the stub readmes

Write one `readme.md` per variant folder, using the title-and-description shape above. The readme is the only stub file.

**Done when:** every variant folder has a non-empty `readme.md`, and no stub folder contains `.gitkeep` or `speaker-notes.md`.

### 4. Lint

Run `pnpm ai-hero-cli internal lint`. Fix the reported errors and run it again.

**Done when:** the linter exits 0.

### 5. Commit

Stage the new exercise paths and commit them with `git commit`.

**Done when:** the new exercise paths are in a commit, and `git status` shows them clean.

## Moving or renumbering

1. Rename with `git mv`, not `mv`, so history stays attached.
2. Update the numeric prefix so order is preserved.
3. Run `pnpm ai-hero-cli internal lint` again.

```bash
git mv exercises/01-retrieval/01.03-embeddings exercises/01-retrieval/01.04-embeddings
```

**Done when:** git tracks the new path, and the linter exits 0.

## Example

Plan:

```
Section 05: Memory Skill Building
- 05.01 Introduction to Memory
- 05.02 Short-term Memory (explainer + problem + solution)
- 05.03 Long-term Memory
```

Paths:

```bash
mkdir -p exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer
mkdir -p exercises/05-memory-skill-building/05.02-short-term-memory/{explainer,problem,solution}
mkdir -p exercises/05-memory-skill-building/05.03-long-term-memory/explainer
```

Readmes, each with a title and one description line:

- `exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer/readme.md` with title `# Introduction to Memory`
- `exercises/05-memory-skill-building/05.02-short-term-memory/explainer/readme.md` with title `# Short-term Memory`
- `exercises/05-memory-skill-building/05.02-short-term-memory/problem/readme.md` with title `# Short-term Memory`
- `exercises/05-memory-skill-building/05.02-short-term-memory/solution/readme.md` with title `# Short-term Memory`
- `exercises/05-memory-skill-building/05.03-long-term-memory/explainer/readme.md` with title `# Long-term Memory`

Lint, then commit.
