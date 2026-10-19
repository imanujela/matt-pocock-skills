---
name: grilling
description: Use when grilling a plan, a decision, or an idea, or when the user says grill.
---

Interview the user relentlessly until the two of you share an understanding. Map the subject as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask now, without guessing at an answer you have not heard.

1. **Map the tree.** Name each open decision and the decision it hangs off, or mark it a root. Done when every open decision is on the tree, and none is left as a silent assumption.

2. **Compute the frontier.** A question whose answer depends on another question still open belongs to a later round. Done when every unsettled decision is either in the frontier or blocked on a named prerequisite.

3. **Ask the frontier, and look up the facts.** Number every frontier question. Give each a title, a body, and your recommended answer. Word each question so "yes" accepts that recommendation. Finding facts is your job. When a frontier question needs a fact from the environment (filesystem, tools, and the rest), dispatch a sub-agent to find it, and leave that question out of this round. Ask the rest of the frontier now. Only questions downstream of a running exploration wait for the report. The decisions are the user's: put each to them. Done when every frontier question is in the round in the format below, no question in the round depends on another question in the round, every fact the round needs is already known or assigned to a running sub-agent, and no fact was put to the user.

```
❓ **Q1** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>

---

❓ **Q2** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>
```

4. **Wait for the round.** Done when the user has answered every question in this round.

5. **Recompute.** Settled decisions push the frontier outward and unblock questions that depended on them. Done when the next frontier is recomputed from those answers, or the frontier is empty.

Repeat from step 2 until the frontier is empty: every branch of the design tree visited, nothing left silently assumed.

The session is done when the frontier is empty and the user has confirmed the shared understanding. Wait for that confirmation. After it, carry out the task the user asked for. If they asked only for the interview, stop.
