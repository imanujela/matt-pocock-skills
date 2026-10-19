---
name: to-questionnaire
description: A questionnaire that pulls a blocked decision from the one person who can answer it.
disable-model-invocation: true
---

Turn something the user cannot answer alone into a **questionnaire**: a Markdown document they hand to one person to fill in async, or fill out together in a meeting. The recipient holds knowledge the user lacks. The questionnaire pulls it out.

**Grill the send, not the subject.** Interview the user only about the send, which they can always answer: who it goes to, and what they need back. The questions in the document then target the **gap** between what the recipient knows and what the user needs.

1. **Who is it going to?** Ask, in one exchange, the recipient's role, expertise, and relationship to the user. This fixes the tone and how much context the document must carry. Done when you can name the recipient, what they know that the user does not, and how much context they will need.

2. **What do you need back?** Ask, in one exchange, the specific decisions or facts the user cannot resolve alone and needs from this person. Done when you hold a concrete list, and each item is something the user must walk away able to do or decide.

3. **Write the questionnaire.** Draft questions aimed at the gap from steps 1 and 2, following the Document structure below. Write the file to `to-questionnaire-<slug>.md` in the current directory (slug from the topic) and report the path. Done when the file exists, every item from step 2 has its own question, no question is compound, and the path is in the reply.

## Document structure

Frame the document as a **discovery questionnaire**: the user lacks context, the recipient holds it. Order questions most-important-first, because async may give you only one pass. Once there are more than a handful, group them under `##` headings by theme. Write it from the template below.

<questionnaire-template>

# <Questionnaire title>

**Purpose:** why this questionnaire exists and the decision riding on it.

**From:** <the user>, **To:** <the recipient>, **How your answers will be used:** <where they go>

## Context

One paragraph orienting a recipient who was not in the user's head. Enough to answer well, not a page.

## How to answer

Deadline and rough effort. Partial answers and "I don't know" are useful: flag anything you are unsure of rather than skipping it.

## <Theme heading>

One `##` section per theme. Under each, its questions, most-important-first. Every question is one idea, with an answer stub directly beneath, and a one-line _why this matters_ only where the question could be misread or invite a throwaway answer.

<question-example>
### What load is the system expected to handle at launch?

_Why this matters: it decides whether we provision for burst traffic now or defer it._

>
</question-example>

## Anything else?

A closing catch-all: anything we did not ask that we should know?

</questionnaire-template>
