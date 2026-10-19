---
name: wayfinder
description: Chart a huge effort as decision tickets on the issue tracker and resolve them one at a time.
disable-model-invocation: true
---

# Wayfinder

A loose idea has arrived, too big for one agent session, and wrapped in fog: the way from here to the **destination** is not visible yet. Wayfinding finds that way. It does not charge at the destination. This skill charts the way as a **shared map** on the repo's issue tracker, then works its **decision tickets** (questions whose resolution is a decision, not slices of a build) one at a time until the route is clear.

The destination varies. Naming it is the first act of charting: it shapes every ticket. It might be a spec to hand off, a decision to lock before planning starts, or a change made in place such as a data-structure migration. The map is domain-agnostic.

## Plan, do not deliver

Wayfinder is **planning** by default. Each ticket resolves a decision. The map is done when the way is clear, with nothing left to decide before someone goes and does the thing. The pull to just do the work is usually the signal you have reached the edge of the map and it is time to hand off. An effort can override this in its **Notes**, carrying execution into the map. Absent that, produce decisions, not deliverables.

## Refer by name

Every map and ticket is an issue, so it has a **name**: its title. In everything the human reads (narration, the map's Decisions so far), refer to it by that name, never by a bare id, number, or slug. A wall of `#42, #43, #44` is illegible. Names read at a glance. The id and URL stay. A name wraps its link. They ride inside the name. They do not stand in for it.

## The Map

The map is a single issue on this repo's issue tracker, labelled `wayfinder:map`. Its tickets are child issues of the map.

The map is an **index**, not a store. It lists the decisions made and points at the tickets that hold their detail. A decision lives in exactly one place, its ticket. The map gists it and links. It does not restate it.

**Where the map, its child tickets, blocking, and frontier queries live is tracker-specific.** The issue tracker should have been provided to you. If not, tell the user to run `/setup-matt-pocock-skills`. Consult the tracker doc's "Wayfinding operations" section. If no tracker has been provided, default to the local-markdown tracker.

### The map body

The whole map at low resolution, loaded once per session. Open tickets are not listed. They are open child issues, found by query.

```markdown
## Destination

<what reaching the end of this map looks like: the spec, decision, or change this effort is finding its way to. One or two lines. Every session orients to it before choosing a ticket.>

## Notes

<domain; skills every session should consult; standing preferences for this effort>

## Decisions so far

<!-- the index: one line per closed ticket, enough to judge relevance, then the link for the detail -->

- [<closed ticket title>](link): <one-line gist of the answer>

## Not yet specified

<!-- fog of war: in-scope fog you cannot ticket yet; graduates as the frontier advances -->

## Out of scope

<!-- work ruled beyond the destination; closed, never graduates -->
```

### Tickets

Each ticket is a **child issue** of the map. The tracker's issue id is its identity. Its body is the question, sized to one 100K token agent session:

```markdown
## Question

<the decision or investigation this ticket resolves>
```

Each ticket carries a `wayfinder:<type>` label, one of `research`, `prototype`, `grilling`, `task` (see Ticket Types). `wayfinder:` labels are the only labels a map and its tickets carry. A triage label such as `ready-for-agent` does not belong: these are decisions, not implementation work.

A session **claims** a ticket by assigning it to the dev driving the map, first, before any work, so concurrent sessions skip it. That assignee is the claim. An open, unassigned ticket is unclaimed.

Blocking uses the tracker's **native** dependency relationship, because it renders the frontier in the tracker's own UI. Only a tracker that lacks native blocking falls back to a body convention. A ticket is **unblocked** when every ticket blocking it is closed. The **frontier** is the open, unblocked, unclaimed children.

The answer is not part of the body. It is recorded on resolution (see Work through the map). Assets created while resolving a ticket are linked from the issue, not pasted in.

## Ticket Types

Every ticket is either **HITL** (human in the loop, worked with a human who speaks for themselves) or **AFK**, driven by the agent alone. A HITL ticket resolves only through that live exchange. The agent does not stand in for the human's side of it. A grilling agent that answers its own questions has broken this. That is a hard guardrail paired with the positive target: the human speaks for themselves.

- **Research** (AFK): reading documentation, third-party interfaces, or local resources to surface a fact a decision waits on. Resolved by a subagent that calls the Skill tool with "research". Use when knowledge outside the current working directory is required.
- **Prototype** (HITL): raise the fidelity of the discussion with a cheap, rough, concrete artefact (an outline, a rough take, a stub, or UI and logic code) by calling the Skill tool with "prototype". Link the prototype as an asset. Use when "how should it look" or "how should it behave" is the question.
- **Grilling** (HITL): conversation. The default. Call the Skill tool twice, for "grilling" and "domain-modeling".
- **Task** (HITL or AFK): manual work that must happen before a decision can be made. Nothing to decide, prototype, or research, but the discussion is blocked until it is done. Signing up for a system so its interface can be judged, provisioning access, moving data so its shape can be seen. This is the one type that does rather than decides, and it earns its place by unblocking a decision, not by delivering the destination. The agent drives it alone where it can (AFK). Otherwise it hands the human a precise checklist (HITL). Resolved when the work is done. The answer records what was done and any resulting facts later tickets depend on.

## Fog of war

The map is deliberately incomplete. Chart only what you can see. Beyond the live tickets lies the **fog of war**: decisions you can tell are coming but cannot yet pin down, because they hang on questions still open. Resolving a ticket clears the fog ahead of it, graduating whatever is now specifiable into fresh tickets, one at a time, until the way to the destination is clear and no tickets remain.

The map's **Not yet specified** section is where that dim view is written down. It is in scope, just not sharp enough to ticket. Write as loosely or as fully as the view allows.

**Fog or ticket?** The test is whether you can state the question precisely now, not whether you can answer it now.

- **Ticket when** the question is already sharp, even if it is blocked.
- **Not yet specified when** you cannot yet phrase it that sharply. Leave the fog coarser than a ticket. One patch may graduate into several tickets, or none.

**Not yet specified** excludes what is already decided, what is already a live ticket, and what is out of scope.

## Out of scope

Fog only gathers toward the destination. Work beyond the destination is **out of scope**. It gets its own section. Scope, not sharpness, lands it there.

Out-of-scope work never graduates. It returns only if the destination is redrawn, and then as a fresh effort.

Ruling something out of scope is a scoping act, not a step on the route. When a ticket that already exists turns out to sit past the destination, **close it** and leave one line in **Out of scope**: the gist, why it is out, and a link to the closed ticket. It stays out of **Decisions so far**.

## Invocation

Two modes. Resolve at most one ticket per session, except research tickets.

### Chart the map

The user invokes with a loose idea.

1. **Name the destination.** Call the Skill tool twice, for "grilling" and "domain-modeling", to pin down what this map is finding its way to. The destination fixes the scope, so it is settled first.

   **Done when:** the destination is one or two lines the user has accepted.

2. **Map the frontier.** Grill again, breadth-first: fan out across the whole space rather than deep on one thread. Surface the open decisions and the first steps takeable now. If this surfaces no fog (the way is already clear, and the journey fits one session), stop and ask the user how they want to proceed. A map is the wrong artefact.

   **Done when:** the open decisions are listed, or you have stopped because there is no fog.

3. **Create the map** (label `wayfinder:map`): Destination and Notes filled in, Decisions so far empty, the fog sketched into Not yet specified.

   **Done when:** the map issue exists with those sections.

4. **Create the tickets you can specify now** as child issues, then wire blocking edges in a second pass (issues need ids before they can reference each other). Write cross-references in that pass with real ids. A placeholder `#<n>` auto-links to an unrelated issue. Everything you cannot yet specify stays in Not yet specified.

   **Done when:** each sharp question is a child ticket, blocking edges use real ids, and the fog is only in Not yet specified.

5. **Fire the research subagents.** For each `research` ticket just created, spin up a subagent that calls the Skill tool with "research". Capture findings on a throwaway `research/<name>` branch with a context pointer from the ticket. Push the branch. Open no PR. It is never merged.

   **Done when:** each research ticket has a subagent or a pointer to its branch, and no PR was opened.

6. Stop. Charting resolves nothing by hand.

   **Done when:** no non-research ticket was resolved in this session.

### Work through the map

The user invokes with a map (URL or number). A ticket is optional. Without one, you pick the next decision.

1. Load the map: the low-resolution view, not every ticket body.

   **Done when:** Destination, Notes, and Decisions so far are loaded.

2. Choose the ticket. If the user named one, use it. Otherwise take the first frontier ticket in order. Claim it: assign it to yourself before any work.

   **Done when:** the ticket is assigned to the driving dev, and that assignment was the first write.

3. Resolve it as the type its `wayfinder:<type>` label names. Read the label, not only the body. Zoom as needed: fetch the full body of any related or closed ticket on demand. Call the Skill tool for whichever skills the Notes block names. If in doubt, call the Skill tool twice, for "grilling" and "domain-modeling".

   **Done when:** the type's resolution path has been followed, and a HITL ticket was not answered by the agent standing in for the human.

4. Record the resolution: post the answer as a resolution comment, close the issue, and append a context pointer to the map's Decisions so far.

   **Done when:** the ticket is closed, the comment holds the answer, and Decisions so far has one new gist plus link.

5. Add newly surfaced tickets (create, then wire). Graduate any fog the answer has made specifiable, clearing each graduated patch from Not yet specified so it lives only as its new ticket. If the answer reveals that a ticket sits beyond the destination, rule it out of scope rather than resolving it on the route. If the decision invalidates other parts of the map, update or close those tickets.

   **Done when:** new tickets are wired, graduated fog is gone from Not yet specified, and out-of-scope tickets are closed with a line on the map.

The user may run unblocked tickets in parallel, so expect other sessions to edit the tracker concurrently.
