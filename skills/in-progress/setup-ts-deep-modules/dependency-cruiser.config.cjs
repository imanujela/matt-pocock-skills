// @ts-check
// dependency-cruiser rules for deep modules.
//
// Each package under the packages root is a deep module: a lot of behaviour
// behind a small interface. The public surface is the entry points, the files
// at the package root. Implementation lives in subfolders and is private.
// By convention that is lib/ for implementation and tests/ for tests. Any
// other subfolder is private too. Prefer several small entry points
// (index.ts, client.ts, server.ts) over one barrel that re-exports a subtree.
//
// Edit PACKAGES_ROOT. The derived patterns and the forbidden rules are the
// checker. Change them only when you mean to change what it rejects.

/** Where packages live. One immediate child directory per package (flat, no nesting). */
const PACKAGES_ROOT = "src/packages";

// --- derived patterns (leave these) -----------------------------------------
const R = PACKAGES_ROOT;
/**
 * A package's private internals: anything nested inside a package subfolder.
 * The package's root files are its entry points and are not matched here,
 * so they stay importable from outside.
 */
const PACKAGE_INTERNALS = `^${R}/[^/]+/[^/]+/`;

/** @type {import('dependency-cruiser').IConfiguration} */
module.exports = {
  forbidden: [
    {
      name: "entrypoint-boundary-from-app",
      comment:
        "App and root code import a package through its entry points (its root files). An import into a subfolder is the violation.",
      severity: "error",
      from: { pathNot: `^${R}/` }, // importer sits outside every package
      to: { path: PACKAGE_INTERNALS },
    },
    {
      name: "entrypoint-boundary-across-packages",
      comment:
        "A package's own files import each other freely. Another package is reached through its entry points, not its internals.",
      severity: "error",
      // importer is inside package $1, and is not a test file
      from: { path: `^${R}/([^/]+)/`, pathNot: `^${R}/[^/]+/tests/` },
      to: {
        path: PACKAGE_INTERNALS,
        pathNot: `^${R}/$1/`, // same package: intra-package imports stay legal
      },
    },
    {
      name: "tests-through-entrypoints",
      comment:
        "Tests exercise a package through its entry points, like every other caller. They may import any package's entry points and their own tests/ fixtures. An import of any package's internals, including their own, is the violation.",
      severity: "error",
      from: { path: `^${R}/([^/]+)/tests/` }, // a test file in package $1
      to: {
        path: PACKAGE_INTERNALS,
        pathNot: `^${R}/$1/tests/`, // own tests/ fixtures stay legal
      },
    },
    {
      name: "tests-folder-is-private",
      comment:
        "A package's tests/ folder is reachable only from tests. Any other importer of a fixture is the violation.",
      severity: "error",
      from: { pathNot: `^${R}/[^/]+/tests/` }, // importer is not a test
      to: { path: `^${R}/[^/]+/tests/` },
    },
    {
      name: "no-circular",
      comment: "No dependency cycles. Scope to `^${R}/` if cycles outside packages should stay legal.",
      severity: "error",
      from: {},
      to: { circular: true },
    },

    // --- Layering (optional, off by default) --------------------------------
    // Entry points control how you import. Layering controls which packages
    // may depend on which. Add rules here, for example:
    //
    // {
    //   name: "ui-may-not-depend-on-billing",
    //   severity: "error",
    //   from: { path: `^${R}/ui/` },
    //   to:   { path: `^${R}/billing/` },
    // },
  ],
  options: {
    doNotFollow: { path: "node_modules" },
    tsConfig: { fileName: "tsconfig.json" },
    enhancedResolveOptions: {
      extensions: [".ts", ".tsx", ".js", ".jsx", ".json"],
    },
  },
};
