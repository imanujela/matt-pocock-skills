---
name: deepen-picked
description: Deepen one already-chosen module until the interface is small and the behaviour sits behind it.
disable-model-invocation: true
---

# Deepen Picked

Take one already-chosen candidate and deepen that module. A deep module has a small interface and the behaviour behind it.

The **deletion test** is the reason this skill exists. Without it, the survey skill stops at a report and the deepening is re-derived ad hoc at every call site.

The candidate is already chosen. Name it before step 1: the module, the files, and the friction. If the user has not named one, ask for that one candidate and stop.

Call the Skill tool with "codebase-design" before you shrink anything. That skill owns the vocabulary and the dependency categories. Use its words exactly: module, interface, implementation, depth, deep, shallow, seam, adapter, leverage, locality.

## Process

### 1. Name the seam

Read the named files. Quote the current interface from the code.

State the seam in one sentence: the place behaviour can change without editing the callers. List the files on the caller side and the files behind the seam.

**Done when:** the seam is one sentence, both sides are listed as files, and the current interface is quoted from the code.

### 2. Shrink the interface

List everything a caller must know: methods, invariants, ordering, error modes, configuration. Mark every other fact as implementation.

Move caller-facing facts behind the seam until a caller can use the module without knowing the implementation.

**Done when:** the caller-facing list is shorter than the list of facts now marked implementation, and each remaining caller-facing fact is required for correct use.

### 3. Run the deletion test

Imagine deleting the module.

- Complexity vanishes: it was a pass-through. Refuse it.
- Complexity reappears across callers: it was earning its keep. Continue.

**Done when:** the reply states vanish or reappear, and a pass-through is refused with a one-line cause. A refusal ends the skill here.

### 4. State how tests cross the same seam

Tests and callers cross the same seam. The interface is the test surface.

Say which tests cross the external seam, and which tests reach past the interface. Tests that reach past the interface are rewritten onto the seam or deleted once the seam tests exist.

Classify each dependency with the categories in codebase-design. One adapter means a hypothetical seam. Two adapters means a real one. Introduce an adapter only when a second one exists (production and test is the usual pair).

**Done when:** every test is named as crossing the seam or listed for rewrite or deletion, and each dependency has a category.

### 5. Write the change or the spec fragment

If the user asked for a spec, or the change does not fit the named module, write a spec fragment: seam, shrunk interface, deletion-test result, and how tests cross the seam. Stop there.

Otherwise write the change in the named module. Call the Skill tool with "tdd" at the seam from step 4.

If the deepened name is not in `GLOSSARY.md`, or a refusal is hard to reverse, surprising without context, and a real trade-off, call the Skill tool with "domain-modeling" and let that skill record the term or the ADR.

If the user asks for alternative interfaces, call the Skill tool with "codebase-design" and follow its design-it-twice pattern before writing.

**Done when:** the module is deep (small interface, behaviour behind it, tests crossing that seam) or the candidate is refused with a one-line cause, and the written artefact is either the change or the spec fragment.
