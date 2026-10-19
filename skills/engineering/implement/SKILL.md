---
name: implement
description: Build the work described by a spec or a set of tickets.
disable-model-invocation: true
---

# Implement

Build the work the user named in the spec or the tickets.

If the user passes a ticket reference, fetch it from the issue tracker and state its title before starting. If the reference is ambiguous, ask which one and stop.

The issue tracker should have been provided to you. If it has not, tell the user to run `/setup-matt-pocock-skills`.

Call the Skill tool with "tdd" at each pre-agreed seam. Agree the seams before the first test. A seam with no agreement gets no test.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once the work is in place, call the Skill tool with "code-review" and review the work.

Commit the work to the current branch.

**Done when:** the ticket title was stated (or there was no ticket reference), each pre-agreed seam has a red-green slice, typechecking has been run, the full suite has been run once, code-review has been called, and the commit is on the current branch.
