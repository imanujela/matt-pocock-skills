---
name: to-spec
description: Turn the current conversation into a spec on the issue tracker.
disable-model-invocation: true
---

# To Spec

Synthesise the current conversation and the codebase into a spec. Publish it to the issue tracker.

The spec is a synthesis of what is already known. Interviewing again is a hard guardrail: a second grilling produces a different artefact, and this skill's job is the spec.

The issue tracker and triage label vocabulary should have been provided to you. If not, tell the user to run `/setup-matt-pocock-skills`.

## Process

### 1. Explore

Explore the repo if you have not already. Use the project's domain glossary throughout the spec. Respect ADRs in the area you are touching.

**Done when:** the spec's nouns match the glossary, and any ADR in the area is either respected or named as a conflict.

### 2. Sketch the seams

Sketch the seams at which the feature will be tested. Prefer existing seams to new ones. Use the highest seam possible. If a new seam is needed, propose it at the highest point you can. Fewer seams is better. The ideal number is one.

Check with the user that these seams match their expectations. Wait for that check before publishing.

**Done when:** each seam is named, existing seams were preferred, and the user has confirmed the list.

### 3. Write and publish

Write the spec with the template below, then publish it to the issue tracker. Apply the `ready-for-agent` triage label. No further triage.

**Done when:** the issue exists on the tracker, it carries `ready-for-agent`, and every template section is present.

<spec-template>

## Problem Statement

The problem the user is facing, from the user's perspective.

## Solution

The solution, from the user's perspective.

## User Stories

A long, numbered list. Each story has this shape:

1. As an <actor>, I want a <feature>, so that <benefit>

<user-story-example>
1. As a mobile bank customer, I want to see the balance on my accounts, so that I can make better informed decisions about my spending
</user-story-example>

Cover every aspect of the feature. A short list is unfinished.

## Implementation Decisions

Decisions already made. Include:

- The modules that will be built or modified
- The interfaces of those modules that will be modified
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- Interface contracts
- Specific interactions

Keep file paths and code snippets out of the spec. They go stale. That is a hard guardrail paired with the positive target: decisions in prose.

Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it inside the relevant decision and note that it came from a prototype. Trim to the decision-rich parts.

## Testing Decisions

- What makes a good test: external behaviour, not implementation details
- Which modules will be tested
- Prior art for the tests (similar tests already in the codebase)

## Out of Scope

What this spec does not cover.

## Further Notes

Anything else about the feature.

</spec-template>
