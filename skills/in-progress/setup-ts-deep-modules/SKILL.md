---
name: setup-ts-deep-modules
description: Wire dependency-cruiser so each TypeScript package is a deep module.
disable-model-invocation: true
---

# Setup TS Deep Modules

Make every package in this repo a **deep module**: a lot of behaviour behind a small interface. The public surface is the **entry points** (the files at the package root). Everything in a subfolder is hidden. The entry points are the **seam**. **Depth** is the behaviour behind them.

Call the Skill tool with "codebase-design" before the scaffold and the packages README, and use its words (deep module, interface, seam, depth) for the public surface. If the Skill tool cannot load it, continue with those words and name the missing skill as residual.

The rules live in [`dependency-cruiser.config.cjs`](./dependency-cruiser.config.cjs). That file is the source. The check is installed, then proved: a clean tree passes, a deep import fails, the deep import is reverted, the tree passes again.

```
src/packages/
  <name>/
    index.ts        entry point (public). Import this from outside.
    client.ts       another entry point. A package may expose several.
    lib/            implementation: hidden from outside, free to import each other.
    tests/          co-located tests and fixtures (a subfolder, so private).
```

By convention implementation lives in `lib/` and tests in `tests/`. The rule is general: anything in any subfolder is private, so a new folder needs no config change. Prefer several small entry points over one barrel that re-exports a subtree. Layering (which packages may depend on which) is the commented stub in the template, for this repo to fill in.

## Steps

### 1. Detect the environment

- **Package manager**: `pnpm-lock.yaml` means pnpm, `yarn.lock` means yarn, `bun.lock` or `bun.lockb` means bun, otherwise npm. A `pnpm-workspace.yaml` means the pnpm install is `pnpm add -D -w` at the repo root; otherwise `pnpm add -D`.
- **Packages root**: `src/packages` if `src/` exists, else `packages`. If neither exists, use `src/packages` and create it in the scaffold step. If the repo already has a different obvious convention, confirm that path with the user before writing.
- **Existing config**: look for a `.dependency-cruiser.*` file.

**Done when** the reply names the package manager, the packages root, and whether a dependency-cruiser config already exists. A non-default packages root is named only after the user has confirmed it.

### 2. Install dependency-cruiser

Install `dependency-cruiser` as a devDependency at the repo root with the detected package manager.

**Done when** the root `package.json` lists `dependency-cruiser` under `devDependencies`.

### 3. Write the config

One config file.

- If none exists, copy [`dependency-cruiser.config.cjs`](./dependency-cruiser.config.cjs) to the repo root as `.dependency-cruiser.cjs` and set `PACKAGES_ROOT` to the root from step 1.
- If one exists, keep it. Add any `forbidden` rule from the template whose `name` is missing, in that file's own format, and set the packages root if it points at the wrong directory. Leave every rule the repo already had.

Use `.cjs` for a new file so `module.exports` works in a `"type": "module"` repo. The `$1` back-references are what let a package reach its own internals while outsiders cannot. Keep them; a flattened per-package rule is a different checker.

**Done when** one config file contains every `name` from the template's `forbidden` array, `PACKAGES_ROOT` (or that file's equivalent) matches step 1, and the reply names any rule you added to an existing file.

### 4. Wire it into the checks

Add a `lint:boundaries` script: `depcruise <packages-root>`. Fold it into the umbrella command that already runs typecheck. If more than one script runs typecheck, prefer `check`, then `ci`, then `validate`. If none of those names exist, ask once which script is the umbrella. `tsconfig` and path aliases stay as the repo has them.

**Done when** `lint:boundaries` is a script, and either the umbrella command that runs typecheck also runs it, or you have asked once which script is the umbrella, or the repo has no umbrella script and the reply names the CI place the user must add it.

### 5. Scaffold the example package

Create a committed `<packages-root>/example/` as a copy-me template. If that path already exists, leave it and use it for the proof, or scaffold `<packages-root>/deep-module-example/` and say which path you used.

- `index.ts` is an entry point. It exports one function that delegates to an internal file, so the package is visibly deep, not a pass-through.
- `lib/impl.ts` exports `implement` and lives in a subfolder. `index.ts` imports it. Nothing outside the package imports it.
- `tests/example.test.ts` imports only `../index` and asserts against the public function. The assertion is plain TypeScript in that file. The scaffold adds no test runner.

Tell the user this is a starter to copy or delete.

**Done when** the named package exposes its behaviour through a root entry point, hides `implement` in a subfolder, and the test imports only that entry point.

### 6. Prove the rules bite

A config that does not fail on a violation is unfinished.

1. Run `lint:boundaries` through the detected package manager (`pnpm lint:boundaries`, `yarn lint:boundaries`, `npm run lint:boundaries`, or `bun run lint:boundaries`). It passes on the clean example.
2. Add a deep import that resolves, so the failure is the rule and not a missing module: `import { implement } from "../lib/impl"`. Run `lint:boundaries` again. It fails, and the output names `tests-through-entrypoints`.
3. Revert that import, including when step 2 did not fail. Run once more. It passes.

**Done when** you have observed a pass, then a fail whose output names `tests-through-entrypoints`, then a pass, and the test file matches the clean version from step 5. If step 2 does not fail, the rules are not wired; fix them before finishing. The revert happens before you report.

### 7. Document the convention

Write `<packages-root>/README.md`, next to the packages it governs. Include the layout (entry points at the root, `lib/` for implementation, `tests/` for tests), the sentence "import only through a package's entry points (its root files)", how to run `lint:boundaries`, and one short paragraph per `forbidden` rule taken from that rule's comment. Say that several small entry points beat one barrel. Keep the copy-me snippet.

Then add one context pointer from the repo's agent-instructions file (`CLAUDE.md` if it is present, otherwise `AGENTS.md`, creating `AGENTS.md` if neither exists):

`Packages are deep modules: see [<packages-root>/README.md](./<packages-root>/README.md) before adding or importing one.`

**Done when** `<packages-root>/README.md` exists, covers every forbidden rule in the config, and the agent-instructions file contains that one pointer.
