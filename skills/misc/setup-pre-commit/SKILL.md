---
name: setup-pre-commit
description: Pre-commit. Use when the user wants Husky or lint-staged checks before each commit.
---

# Setup Pre-Commit Hooks

Install a Husky pre-commit hook that runs lint-staged (Prettier on staged files), then the repo's typecheck and test scripts.

## Steps

### 1. Detect the package manager

Use the lockfile that is present: `package-lock.json` (npm), `pnpm-lock.yaml` (pnpm), `yarn.lock` (yarn), `bun.lockb` (bun). When none is present, or more than one is, use npm and name the lockfiles you saw.

**Done when:** one package manager is chosen, and a default to npm is stated to the user when the lockfiles were missing or mixed.

### 2. Install the dev dependencies

Install `husky`, `lint-staged`, and `prettier` as devDependencies with that package manager.

**Done when:** all three are in `devDependencies` in `package.json`.

### 3. Initialise Husky

```bash
npx husky init
```

**Done when:** `.husky/` exists and `package.json` has `"prepare": "husky"`.

### 4. Write `.husky/pre-commit`

Replace the hook file that `husky init` created. The whole file is these commands, with no shebang (Husky v9+ runs the file as it is):

```
npx lint-staged
<pm> run typecheck
<pm> run test
```

`<pm>` is the package manager from step 1. Omit `typecheck` or `test` when `package.json` has no script of that name, and tell the user which line you omitted.

**Done when:** the file contains `npx lint-staged`, plus a run line for each of `typecheck` and `test` that exists, uses the detected package manager, and has no shebang.

### 5. Write `.lintstagedrc`

```json
{
  "*": "prettier --ignore-unknown --write"
}
```

`--ignore-unknown` leaves files Prettier cannot parse, such as images, unwritten.

**Done when:** `.lintstagedrc` matches that JSON.

### 6. Write `.prettierrc` when none exists

When a Prettier config is already present, leave it. Otherwise write:

```json
{
  "useTabs": false,
  "tabWidth": 2,
  "printWidth": 80,
  "singleQuote": false,
  "trailingComma": "es5",
  "semi": true,
  "arrowParens": "always"
}
```

**Done when:** a Prettier config exists, and a config that was already present is unchanged.

### 7. Verify

Confirm each of these:

- `.husky/pre-commit` exists and is executable
- `.lintstagedrc` exists
- `prepare` in `package.json` is `"husky"`
- a Prettier config exists
- `npx lint-staged` exits 0

**Done when:** each line above is true.

### 8. Commit

Stage the files this skill created or changed. Commit with the message `Add pre-commit hooks (husky + lint-staged + prettier)`. The new hook runs as part of that commit.

**Done when:** that commit exists, and the hook ran during it (lint-staged, then whichever of typecheck and test were included).
