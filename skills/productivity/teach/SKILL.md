---
name: teach
description: Teach one topic across sessions, in this workspace.
disable-model-invocation: true
argument-hint: "What would you like to learn about?"
---

The user wants to learn a topic across sessions. The current directory is the teaching workspace. Paths such as `./lessons/` resolve from the directory `/teach` was run in. The `*-FORMAT.md` links resolve from this skill's folder.

## Workspace

The state of their learning lives in these files:

- `MISSION.md`: the reason they are learning this. Ground every teaching decision in it. Format: [MISSION-FORMAT.md](./MISSION-FORMAT.md).
- `RESOURCES.md`: trusted sources for knowledge, and communities for wisdom. Format: [RESOURCES-FORMAT.md](./RESOURCES-FORMAT.md).
- `./learning-records/*.md`: non-obvious lessons and stated prior knowledge, titled `0001-<dash-case-name>.md`, the number incrementing. Use them to place the zone of proximal development. Format: [LEARNING-RECORD-FORMAT.md](./LEARNING-RECORD-FORMAT.md).
- `./lessons/*.html`: one lesson per file. A **lesson** is a single self-contained HTML page that teaches one tightly scoped thing tied to the mission. This is the primary unit of teaching.
- `./reference/*.html`: compressed learnings (cheat sheets, algorithms, syntax, poses, glossaries). They should print well and be built for quick reference. Lessons are rarely revisited. Reference documents are.
- `./assets/*`: reusable **components** shared across lessons. See [Assets](#assets).
- `NOTES.md`: stated teaching preferences and working notes. Record a preference the moment the user states one, and read the file before the next lesson.

## Session

Run these steps in order. Skip a step only when its done-condition already holds. Apply [Knowledge, skills, wisdom](#knowledge-skills-wisdom) on the lesson in step 4. When the user asks a question that needs judgement, apply the wisdom rule there before you answer.

1. **Confirm the mission.** If `MISSION.md` is missing, or the user cannot say why they are learning this, interview them before a lesson exists. A later mission change is normal: update the file, add a learning record, and confirm with the user before the change lands. Done when `MISSION.md` matches [MISSION-FORMAT.md](./MISSION-FORMAT.md) and the user has confirmed the Why.

2. **Ground knowledge in resources.** Before `RESOURCES.md` can support the next lesson, find high-trust sources and record them. Draw lesson claims from those sources. Parametric knowledge is not a source. Some topics need more skills than knowledge (yoga). Some need the reverse (theoretical physics). Record which this topic is. Done when every claim the next lesson will make cites a `RESOURCES.md` entry, or a `## Gaps` entry names the missing source.

3. **Place the zone of proximal development.** Read `./learning-records/` and `MISSION.md`. If the user named an exact thing to learn, teach that, still inside the zone. Done when the next lesson is the most relevant thing they can learn with effort, and you can name the learning record or mission line that justifies it.

4. **Reuse assets, then author the lesson.** Read `./assets/` first and build from the components already there. When the lesson needs something a second lesson could reuse, write it into `./assets/` and link it. A shared stylesheet is the first component every workspace earns, and every lesson links it. Save the lesson to `./lessons/0001-<dash-case-name>.html`, incrementing the number. Open the file with a CLI command when the environment allows it. A quiz in the lesson follows the quiz rules below. Done when the file exists, links the shared stylesheet, links sibling lessons and reference documents, recommends one primary source, reminds the user they can ask follow-up questions, teaches one tangible win tied to the mission, and contains no inline copy of a reusable component.

5. **Write the reference and the learning record.** Put the compressed form (syntax, algorithm, pose, glossary entry) in `./reference/`. Write a learning record only when [LEARNING-RECORD-FORMAT.md](./LEARNING-RECORD-FORMAT.md) says one is due. Done when a reference exists for any raw unit this lesson introduced, and every qualifying insight has a record. Mere coverage is not a record.

## Assets

Lessons are built from reusable **components** in `./assets/`: stylesheets, quiz widgets, simulators, diagram helpers, and anything else a second lesson could reuse. Step 4 is the procedure, and its done-condition is the one that counts.

## Knowledge, skills, wisdom

To learn at a deep level the user needs three things:

- **Knowledge**, from high-trust resources.
- **Skills**, from interactive lessons you devise from that knowledge.
- **Wisdom**, from other learners and practitioners.

**Fluency** is in-the-moment retrieval. **Storage strength** is long-term retention, and it is the goal. Fluency can feel like mastery and still fade. Build storage strength with desirable difficulty:

- Retrieval practice: recall from memory.
- Spacing: practice distributed over time.
- Interleaving: mixing related topics. Interleaving is for skills practice only.

For knowledge, difficulty eats the working memory understanding needs. Teach only the knowledge the skill requires, then practise the skill. Cite every claim. A lesson with a claim and no citation is not done.

For skills, difficulty is the tool. Effortful retrieval builds storage strength. Teach skills through a **feedback loop**, and keep it **tight**: feedback immediately, and automatically when you can.

- Quizzes and light in-browser tasks.
- A list of real-world steps (yoga poses, and the like).

Quiz rules, on every question:

- Each option has the same number of words, and the same character count when you can manage it.
- The correct option does not sit in the same position on every question.
- Formatting and order give no clue.

Done when a reader who ignores the words cannot pick the correct option from length, position, or formatting.

Wisdom is real-world interaction outside the workspace. When a question needs wisdom, attempt an answer, then point the user at a **community**: a forum, a subreddit, a class, or a local group with a high reputation. If `RESOURCES.md` records that the user does not want a community, honour that and stop proposing one. Done when the reply contains an attempted answer and either a named community or the recorded opt-out.
