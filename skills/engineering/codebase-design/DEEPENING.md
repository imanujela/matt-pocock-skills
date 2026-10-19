# Deepening

How to deepen a cluster of shallow modules, given its dependencies. Assumes the vocabulary in [SKILL.md](SKILL.md): **module**, **interface**, **seam**, **adapter**.

## Dependency categories

Classify the candidate's dependencies. The category decides how the deepened module is tested across its seam.

### 1. In-process

Pure computation, in-memory state, no I/O. Always deepenable: merge the modules and test through the new interface directly. No adapter needed.

### 2. Local-substitutable

Dependencies that have a local test stand-in (PGLite for Postgres, an in-memory filesystem). Deepenable if the stand-in exists. The deepened module is tested with the stand-in running in the suite. The seam stays internal. Nothing about the stand-in appears on the module's external interface.

### 3. Remote but owned (ports and adapters)

Your own modules across a network. Define the interface at the seam. The deep module owns the logic. The transport is injected as an adapter. Tests use an in-memory adapter. Production uses an HTTP, gRPC, or queue adapter.

Shape the recommendation as: "Define the interface at the seam, implement an HTTP adapter for production and an in-memory adapter for tests, so the logic sits in one deep module even though it is deployed across a network."

### 4. True external (mock)

Third-party systems you do not control (Stripe, Twilio, and the like). The deepened module takes the external dependency as an injected interface. Tests provide a mock adapter.

## Seam discipline

- **One adapter means a hypothetical seam. Two adapters means a real one.** Introduce an injected interface only when at least two adapters are justified (typically production and test). A single-adapter seam is indirection.
- **Internal seams and external seams.** A deep module can have internal seams (private to its implementation, used by its own tests) and the external seam at its interface. Leave internal seams off the interface. Tests that need them are testing past the interface.

## Testing: replace, do not stack

- Old tests on shallow modules become waste once tests at the deepened interface exist. Delete them.
- Write new tests at the deepened module's interface. The **interface is the test surface**.
- Tests assert on observable outcomes through the interface, not on internal state.
- Tests survive an internal refactor, because they describe behaviour, not implementation. A test that must change when the implementation changes is testing past the interface.

**Done when:** each dependency has a category, the seam has two adapters or none, and the tests that remain cross the external interface.
