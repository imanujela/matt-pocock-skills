---
name: migrate-to-shoehorn
description: Shoehorn. Use when tests use `as` assertions, or need partial or intentionally wrong data.
---

# Migrate to Shoehorn

`shoehorn` lets a test pass partial or intentionally wrong data while TypeScript still checks the call. Use it in test files only.

## Which function

| Function | Use when |
| --- | --- |
| `fromPartial()` | The value is a partial of the real type and should still type-check |
| `fromAny()` | The value is intentionally the wrong type, and autocomplete should remain |
| `fromExact()` | The value must be the full object now, and may swap to `fromPartial()` later |

An `as` assertion in a test hides the target type and forces the writer to name it. `as unknown as Type` is the old way to pass intentionally wrong data. Replace the first with `fromPartial()`, the second with `fromAny()`.

### Partial object

Before:

```ts
getUser({ body: { id: "123" } } as Request);
```

After:

```ts
import { fromPartial } from "@total-typescript/shoehorn";

getUser(fromPartial({ body: { id: "123" } }));
```

A large type where the test only needs one field is the same replacement: pass the fields the test uses, and leave the rest out.

### Intentionally wrong data

Before:

```ts
getUser({ body: { id: 123 } } as unknown as Request);
```

After:

```ts
import { fromAny } from "@total-typescript/shoehorn";

getUser(fromAny({ body: { id: 123 } }));
```

## Steps

### 1. Gather the sites

Ask which test files have `as` assertions to replace, which sites are partial objects, and which sites are intentionally wrong data.

**Done when:** every target file is named, and every `as` site in those files is classed as partial or intentionally wrong.

### 2. Install

```bash
npm i @total-typescript/shoehorn
```

**Done when:** `@total-typescript/shoehorn` is listed in `package.json`.

### 3. Replace the assertions

Find the sites:

```bash
grep -r " as [A-Z]" --include="*.test.ts" --include="*.spec.ts"
```

Replace `as Type` with `fromPartial()`, and `as unknown as Type` with `fromAny()`. Add the import from `@total-typescript/shoehorn` in each file you edit.

**Done when:** the named files no longer contain those `as` assertions, and each edited file imports the function it calls.

### 4. Typecheck

Run the repo's typecheck command.

**Done when:** typecheck exits 0, or every remaining error is listed and none of them come from a shoehorn call you introduced.
