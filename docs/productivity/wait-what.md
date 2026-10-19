## What it does

You type `wait-what` when a message did not land. The [agent](https://www.aihero.dev/ai-coding-dictionary/agent) re-pitches what it just said: the context you were missing, plain English, and the vocabulary from your project's `GLOSSARY.md`.

The body stays a re-pitch, not a manual. That is the design. A long concision skill still leaves the [model](https://www.aihero.dev/ai-coding-dictionary/model) verbose, because the model copies the length of the skill, not its request. This one has a single leading word, the re-pitch, and a done-condition. Nothing else.

## When to reach for it

You invoke it by typing `/wait-what`. The agent will not reach for it on its own, and it should not. Only you know when you stopped following.

Use it as soon as you notice you are skimming. The agent has started using jargon it invented, put five acronyms in one sentence, or explained a decision whose premise you never saw. It repairs the conversation you are already in. To stop the jargon arriving at all, use [grill-with-docs](https://aihero.dev/skills-grill-with-docs), which builds the shared language upfront.

## The name is the mechanism

The leading word is **wait**. "Be concise" is an instruction about the agent's output, and the model obeys it by clipping words and losing you further. **Wait** is about your state. It says you stopped understanding here. An agent that hears "be brief" writes clipped fragments. An agent that hears "wait, you lost me" backs up and explains.

That difference is the whole skill. Popular fixes for verbosity name the output: `/tldr`, `/no-fluff`, `/talk-normal`. The model over-corrects into clipped fragments that are shorter and no clearer. Naming the listener asks for both halves at once: fewer words, and the context you were missing.

The skill says re-pitch **that**, not "that last message". What lost you is usually bigger than one paragraph, so the agent decides how far back to go.

## It plugs into the language you already have

The body reuses the leading words already in your global `CLAUDE.md` and your project's `GLOSSARY.md`. ASD-STE100 Simplified Technical English sets the register. The ubiquitous language supplies the nouns. The skill, `CLAUDE.md`, and `GLOSSARY.md` use the same [tokens](https://www.aihero.dev/ai-coding-dictionary/token), so invoking it is a reminder of an agreement the agent already holds, not a new instruction.

If you have no `GLOSSARY.md`, and no `GLOSSARY-MAP.md` pointing at one for this context, the skill still works. You lose only the domain-vocabulary half.

## Common questions

**Where did `CONTEXT.md` go?**
It is `GLOSSARY.md` now, and `CONTEXT-MAP.md` is `GLOSSARY-MAP.md`. When a repo indexes more than one glossary, the skill follows `GLOSSARY-MAP.md` to the one for this context.

**Why is there a done-condition if the skill used to be three lines?**
The first version was three lines, and the re-pitch ended when it felt short. The done-condition is the bound: shorter and clearer than the message that lost you, with domain nouns taken from the glossary in force. The body stays a re-pitch. A manual would teach length.

## It's working if

- The re-pitch is shorter and clearer, not shorter and blunter.
- It adds the premise you were missing, instead of only deleting words.
- Project nouns replace invented ones. The terms in your `GLOSSARY.md` come back.
- You can use it twice in a row, and it does not degrade into terseness.

## Where it fits

You can use `wait-what` at any point, in any conversation, inside any other skill. It repairs one message after the fact. The real fix is a shared language agreed upfront, and that is [grill-with-docs](https://aihero.dev/skills-grill-with-docs): a [grilling](https://www.aihero.dev/ai-coding-dictionary/grilling) session that runs [domain-modeling](https://aihero.dev/skills-domain-modeling) as it goes, so it records the words you both use in `GLOSSARY.md`. If you are unsure which skill fits the moment, [ask-matt](https://aihero.dev/skills-ask-matt) routes you.
