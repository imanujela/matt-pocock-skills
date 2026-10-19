---
name: diagnosing-bugs
description: Use when something is broken, throwing, failing, or slow, or the user says diagnose or debug this.
---

# Diagnosing Bugs

A discipline for hard bugs. Skip a phase only when you say why.

When exploring the codebase, read `GLOSSARY.md` if it exists, and check ADRs in the area you are touching.

## Redact

This skill has you show commands, outputs, and captured artefacts. Write `<REDACTED>` in place of every secret before you show it. Build loops against env vars, so the credential stays in the environment rather than in what you show. Captured artefacts carry auth headers: quote only the lines that carry the signal.

If the redacted output is not enough to diagnose the bug, say so and ask the user.

**Done when:** every shown command, output, and artefact has secrets replaced with `<REDACTED>`, or you have asked because the redacted form is not enough.

## Phase 1: Build a feedback loop

**This is the skill.** Everything else consumes the loop. If you have a **tight** pass/fail signal for the bug (one that goes red on _this_ bug), you will find the cause. Bisection, hypothesis-testing, and instrumentation all consume it. Staring at code does not replace it.

Spend disproportionate effort here. Be aggressive. Be creative. Keep going until a loop exists or you have listed what you tried.

### Ways to construct one, in roughly this order

1. **Failing test** at whatever seam reaches the bug.
2. **Curl or HTTP script** against a running dev server.
3. **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot.
4. **Headless browser script** (Playwright or Puppeteer) that drives the UI and asserts on DOM, console, or network.
5. **Replay a captured trace.** Save a real network request, payload, or event log to disk. Replay it through the code path in isolation.
6. **Throwaway harness.** Spin up a minimal subset of the system (one running process, mocked dependencies) that exercises the bug path with a single function call.
7. **Property or fuzz loop.** If the bug is "sometimes wrong output", run 1000 random inputs and look for the failure mode.
8. **Bisection harness.** If the bug appeared between two known states (commit, dataset, version), automate "boot at state X, check, repeat" so you can `git bisect run` it.
9. **Differential loop.** Run the same input through old and new (or two configs) and diff the outputs.
10. **HITL bash script.** Last resort. If a human must click, drive them with `scripts/hitl-loop.template.sh` so the loop stays structured. Captured output feeds back to you.

Build the right feedback loop, and the bug is most of the way to fixed.

### Tighten the loop

Treat the loop as a product. Once you have a loop, **tighten** it:

- Make it faster. Cache setup, skip unrelated init, narrow the scope.
- Make the signal sharper. Assert on the specific symptom, not "did not crash".
- Make it deterministic. Pin time, seed RNG, isolate the filesystem, freeze the network.

A 30-second flaky loop is barely better than no loop. A 2-second deterministic one is tight.

### Non-deterministic bugs

The goal is a **higher reproduction rate**, not a clean repro on the first try. Loop the trigger 100 times, parallelise, add stress, narrow timing windows, inject sleeps. A 50% flake is debuggable. A 1% flake is not. Raise the rate until it is debuggable.

### When you genuinely cannot build a loop

Stop and say so. List what you tried. Ask the user for: (a) access to an environment that reproduces it, (b) a redacted captured artefact (HAR file, log dump, core dump, screen recording with timestamps), or (c) permission to add temporary production instrumentation. Theorising without a loop is the failure this skill exists to prevent. That is a hard guardrail paired with the positive target: a red-capable command.

### Completion criterion: a tight loop that goes red

Phase 1 is done when the loop is **tight** and **red-capable**: you can name **one command** (a script path, a test invocation, a curl) that you have **already run at least once** (show the invocation and its redacted output), and that is:

- [ ] **Red-capable**: it drives the actual bug path and asserts the **user's exact symptom**, so it can go red on this bug and green once fixed. "Runs without erroring" is not enough. It must be able to catch this specific bug.
- [ ] **Deterministic**: same verdict every run (flaky bugs: a pinned, high reproduction rate, as above).
- [ ] **Fast**: seconds, not minutes.
- [ ] **Agent-runnable**: you can run it unattended. A human is in the loop only via `scripts/hitl-loop.template.sh`.

Reading code to build a theory before this command exists means stop. No red-capable command, no Phase 2.

**Done when:** the four boxes above are checked against a command you have already run, and the redacted output is shown.

## Phase 2: Reproduce and minimise

Run the loop. Watch it go red as the bug appears.

Confirm:

- [ ] The loop produces the failure mode the **user** described, not a nearby different failure.
- [ ] The failure is reproducible across runs (or, for non-deterministic bugs, reproducible at a high enough rate to debug against).
- [ ] You have captured the exact symptom (error message, wrong output, slow timing) so later phases can verify the fix addresses it.

### Minimise

Once it is red, shrink the repro to the **smallest scenario that still goes red**. Cut inputs, callers, config, data, and steps **one at a time**, re-running the loop after each cut. Keep only what is load-bearing for the failure.

A minimal repro shrinks the hypothesis space in Phase 3 and becomes the regression test in Phase 5.

**Done when:** every remaining element is load-bearing. Removing any one of them makes the loop go green. Proceed only after you have reproduced and minimised.

## Phase 3: Hypothesise

Generate **3 to 5 ranked hypotheses** before testing any of them. A single hypothesis anchors on the first plausible idea.

Each hypothesis is **falsifiable**: state the prediction it makes.

> Format: "If <X> is the cause, then <changing Y> will make the bug disappear / <changing Z> will make it worse."

If you cannot state the prediction, the hypothesis is a vibe. Discard it or sharpen it.

**Show the ranked list to the user before testing.** They often re-rank instantly, or know a hypothesis already ruled out. Proceed with your ranking if the user is away.

**Done when:** 3 to 5 falsifiable hypotheses are ranked and shown, or fewer remain after discarding vibes and that count is stated.

## Phase 4: Instrument

Each probe maps to a specific prediction from Phase 3. Change one variable at a time.

Tool preference:

1. **Debugger or REPL inspection** if the environment supports it. One breakpoint beats ten logs.
2. **Targeted logs** at the points that distinguish hypotheses.
3. A log of everything, then a grep, is the failure mode. The positive target is a probe tied to one prediction.

**Tag every debug log** with a unique prefix, for example `[DEBUG-a4f2]`. Cleanup is then a single grep. Untagged logs survive. Tagged logs die.

**Perf branch.** For performance regressions, logs are usually the wrong probe. Establish a baseline measurement (timing harness, `performance.now()`, profiler, query plan), then bisect. Measure first, fix second.

**Done when:** each probe maps to one prediction, one variable changed, and every debug log carries the prefix.

## Phase 5: Fix and regression test

Write the regression test **before the fix**, but only if there is a **correct seam** for it.

A correct seam is one where the test exercises the **real bug pattern** as it occurs at the call site. If the only available seam is too shallow (a single-caller test when the bug needs several callers, a test that cannot replicate the chain that triggered the bug), a regression test there gives false confidence.

**If no correct seam exists, that itself is the finding.** Write it down: the module, and why no test can cross a seam that reaches the bug. The follow-up is a survey, not another guess. Flag it. Phase 6 still runs.

If a correct seam exists:

1. Turn the minimised repro into a failing test at that seam.
2. Watch it fail. If you forced the red by mutating code or a fixture, `diff` against a pristine copy to prove the mutation landed before you trust it.
3. Apply the fix.
4. Watch it pass.
5. Re-run the Phase 1 feedback loop against the original (un-minimised) scenario.

**Done when:** the seam test went red, then green, and the Phase 1 loop is green on the original scenario, or the missing seam is written down as the finding.

## Phase 6: Cleanup

Required before declaring done:

- [ ] Original repro no longer reproduces (re-run the Phase 1 loop)
- [ ] Regression test passes, or the absence of a seam is documented
- [ ] All `[DEBUG-...]` instrumentation is removed (`grep` the prefix)
- [ ] Throwaway prototypes are deleted, or moved to a clearly marked debug location
- [ ] The hypothesis that turned out correct is stated in the commit or PR message, so the next debugger learns it

**Done when:** every box above is checked.
