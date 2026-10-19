---
name: codebase-design
description: Use when designing or improving a module's interface, deciding where a seam goes, making code testable through that interface, or when another skill needs the deep-module vocabulary.
---

# Codebase Design

Design **deep modules**: a lot of behaviour behind a small interface, placed at a clean seam, testable through that interface. Use this language wherever code is being designed or restructured. The aim is leverage for callers, locality for maintainers, and testability for everyone.

## Glossary

Use these terms exactly. Consistent language is the whole point.

**Module**: anything with an interface and an implementation. Deliberately scale-agnostic: a function, a class, a package, or a tier-spanning slice.
_Avoid_: unit, component, service.

**Interface**: everything a caller must know to use the module correctly. The type surface, and also invariants, ordering constraints, error modes, required configuration, and performance characteristics.
_Avoid_: API, signature (too narrow: they refer only to the type-level surface).

**Implementation**: what is inside a module, its body of code. Distinct from **Adapter**: a thing can be a small adapter with a large implementation (a Postgres repo) or a large adapter with a small implementation (an in-memory fake). Reach for "adapter" when the seam is the topic. Reach for "implementation" otherwise.

**Depth**: leverage at the interface. The amount of behaviour a caller or a test can exercise per unit of interface they have to learn. A module is **deep** when a large amount of behaviour sits behind a small interface. It is **shallow** when the interface is nearly as complex as the implementation.

**Seam** (Michael Feathers): a place where you can alter behaviour without editing in that place. The location at which a module's interface lives. Where to put the seam is its own design decision, distinct from what goes behind it.
_Avoid_: boundary (overloaded with a bounded context).

**Adapter**: a concrete thing that satisfies an interface at a seam. Describes role (what slot it fills), not substance (what is inside).

**Leverage**: what callers get from depth. More capability per unit of interface they learn. One implementation pays back across N call sites and M tests.

**Locality**: what maintainers get from depth. Change, bugs, knowledge, and verification concentrate in one place rather than spreading across callers. Fix once, fixed everywhere.

## Deep vs shallow

**Deep module** = small interface + lots of implementation:

```
+---------------------+
|   Small Interface   |  <- few methods, simple params
+---------------------+
|                     |
|  Deep Implementation|  <- complex logic hidden
|                     |
+---------------------+
```

**Shallow module** = large interface + little implementation (avoid):

```
+---------------------------------+
|       Large Interface           |  <- many methods, complex params
+---------------------------------+
|  Thin Implementation            |  <- just passes through
+---------------------------------+
```

When designing an interface, ask:

- Can I reduce the number of methods?
- Can I simplify the parameters?
- Can I hide more complexity inside?

## Principles

- **Depth is a property of the interface, not the implementation.** A deep module can be internally composed of small, swappable parts. They are not part of the interface. A module can have **internal seams** (private to its implementation, used by its own tests) and the **external seam** at its interface.
- **The deletion test.** Imagine deleting the module. If complexity vanishes, it was a pass-through. If complexity reappears across N callers, it was earning its keep.
- **The interface is the test surface.** Callers and tests cross the same seam. A test that reaches past the interface means the module is probably the wrong shape.
- **One adapter means a hypothetical seam. Two adapters means a real one.** Introduce a seam only when something actually varies across it.

## Designing for testability

Good interfaces make testing natural:

1. **Accept dependencies. Leave their construction to the caller.**

   ```typescript
   function processOrder(order, paymentGateway) {}
   ```

   Constructing the dependency inside the function hides the seam and makes the test reach past the interface. That is a hard guardrail paired with the positive target: accept the dependency.

   ```typescript
   function processOrder(order) {
     const gateway = new StripeGateway();
   }
   ```

2. **Return results. Leave side effects to the caller.**

   ```typescript
   function calculateDiscount(cart): Discount {}
   ```

   Mutating the caller's cart inside the function makes the outcome observable only by inspecting that mutation.

   ```typescript
   function applyDiscount(cart): void {
     cart.total -= discount;
   }
   ```

3. **Small surface area.** Fewer methods means fewer tests. Fewer params means simpler test setup.

## Relationships

- A **Module** has exactly one **Interface** (the surface it presents to callers and tests).
- **Depth** is a property of a **Module**, measured against its **Interface**.
- A **Seam** is where a **Module**'s **Interface** lives.
- An **Adapter** sits at a **Seam** and satisfies the **Interface**.
- **Depth** produces **Leverage** for callers and **Locality** for maintainers.

## Rejected framings

- **Depth as a ratio of implementation lines to interface lines**: rewards padding the implementation. We use depth as leverage instead.
- **"Interface" as a TypeScript keyword or a class's public methods**: too narrow. Interface here includes every fact a caller must know.
- **"Boundary"**: overloaded. Say **seam** or **interface**.

## Going deeper

- **Deepening a cluster given its dependencies**: [DEEPENING.md](DEEPENING.md). Dependency categories, seam discipline, and replace-rather-than-stack testing.
- **Exploring alternative interfaces**: [DESIGN-IT-TWICE.md](DESIGN-IT-TWICE.md). Parallel sub-agents design the interface several radically different ways, then you compare on depth, locality, and seam placement.

**Done when:** the advice you give uses only the terms above, and a deepening or an interface exploration has been pointed at the matching file rather than restated.
