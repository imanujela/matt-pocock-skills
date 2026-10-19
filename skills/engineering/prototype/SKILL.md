---
name: prototype
description: Use when the question is whether a state model or logic feels right, or what a UI should look like.
---

# Prototype

A prototype is **throwaway code that answers a question**. The question decides the shape.

## Pick a branch

Identify the question from the user's prompt, the surrounding code, or by asking if the user is around:

- **"Does this logic or state model feel right?"** -> [LOGIC.md](LOGIC.md). One shareable HTML file: free-play buttons plus tabbed guided walkthroughs, so a non-developer can push the state machine through cases that are hard to reason about on paper.
- **"What should this look like?"** -> [UI.md](UI.md). Several radically different UI variations on a single route, switchable via a URL search param and a floating bottom bar.

The two branches produce different artefacts. If the question is ambiguous and the user is not reachable, default to the branch that matches the surrounding code (a backend module -> logic; a page -> UI) and state that assumption at the top of the prototype.

**Done when:** one branch is named, the question is written in one line, and the assumption is stated if the user was not reachable.

## Rules that apply to both

The branch files own the build. These rules apply on top of either branch.

1. **Throwaway from day one, and marked as such.** Locate the prototype next to the module or page it is for, and name it so a casual reader can see it is a prototype. For throwaway UI routes, follow the project's existing routing convention.
2. **Trivial to run.** A UI prototype starts from one command in the project's task runner. A logic demo is a single HTML file the user opens. No thinking required to start it.
3. **No persistence by default.** State lives in memory. Persistence is the thing the prototype is checking, not something it depends on. If the question is about a database, hit a scratch store with a clear "PROTOTYPE, wipe me" name.
4. **Skip the polish.** No tests, no error handling beyond what makes the prototype runnable, no abstractions. The point is to learn something fast.
5. **Surface the state.** After every action (logic) or on every variant switch (UI), render the full relevant state so the user can see what changed.
6. **Capture it when done.** Fold any validated decision into the real code, then capture the prototype as a **primary source**: commit it to a throwaway branch, out of main, and leave a context pointer to that branch on the implementation issue. Capture the answer too (the verdict and the question it settled). The main branch keeps only the validated decision.

**Done when:** the prototype runs from one command or one file open, state is visible after each action, and the capture step has either landed the branch pointer or the question is still open and the prototype is still the working artefact.
