---
name: tdd
description: Use when the user wants a feature or a bugfix built test-first, says red, or asks for tests at a seam.
---

# Test-Driven Development

TDD is the red to green loop. This skill is the reference that makes that loop produce tests worth keeping. Consult it before and during every cycle.

When exploring the codebase, read `GLOSSARY.md` if it exists, so test names and interface vocabulary match the project's domain language. Respect ADRs in the area you are touching.

## What a good test is

Tests verify behaviour through the public interface, not through the implementation. Code can change entirely. The tests should not. A good test reads like a specification: "user can checkout with a valid cart" names the capability, and it survives a refactor because it does not care about internal structure.

Examples live in [tests.md](tests.md). Mocking lives in [mocking.md](mocking.md). Those files own the examples. This file owns the loop.

## Seams: where tests go

A **seam** is where you observe behaviour without reaching inside. Tests live at seams.

**Test only at pre-agreed seams.** Before any test, write down the seams under test and confirm them with the user. No test is written at an unconfirmed seam. Agreeing the seams is how effort lands on the critical paths instead of every edge.

Ask: "What is the public interface, and which seams should we test?" Give each proposed seam a one-line note on what it catches and what it misses.

When the shape of that interface is itself in question, call the Skill tool with "codebase-design". It owns module, interface, depth, seam, adapter, leverage, and locality. It is a reference to consult, not a session to run.

**Done when:** the seams are written down, the user has confirmed them, and each seam has a one-line note on what it catches and what it misses.

## Anti-patterns

- **Implementation-coupled**: the test mocks an internal collaborator, tests a private method, or verifies through a side channel. The tell: the test breaks on a refactor when the behaviour has not changed. The positive target: assert through the interface.
- **Tautological**: the assertion recomputes the expected value the way the code does, so it passes by construction. Expected values come from an independent source: a known-good literal, a worked example, the spec.
- **Horizontal slicing**: all tests first, then all implementation. That verifies imagined behaviour. Work in **vertical slices** instead: one test, one implementation, repeat. Each test is a **tracer bullet** that responds to what the last cycle taught you.

## Rules of the loop

- **Red before green.** Write the failing test first, then only enough code to pass it. Future tests and speculative features wait for their own cycle.
- **One slice at a time.** One seam, one test, one minimal implementation per cycle.
- **Refactoring sits in review, not in this loop.** The review stage is the `code-review` skill. This loop is red, then green.

**Done when:** the newest test was red before the implementation that makes it green, the slice is one seam, and no refactor has been folded into the green step.
