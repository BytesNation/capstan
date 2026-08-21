---
name: interview
description: Interview until every branch of a design is resolved, and park what will not resolve. Use before work starts: a request carrying more than one defensible reading, a term doing two jobs, a spec about to be written, or open questions a previous run left behind.
---

# Interview

The most common failure in any build is not bad execution. It is that you thought you understood what was wanted and you did not. An hour here saves a week of building the wrong thing correctly.

## Before the first round

Read `.capstan/decisions.md` in the working copy. Every line marked `open` or `assumed` is a question a previous run could not settle, and it belongs in round one alongside whatever the operator just asked about.

An `assumed` line is not settled, it is defaulted. Put it back on the table with its current default as the recommended answer.

**Done when** every `open` and `assumed` line is either in round one or ruled out of scope out loud.

## The frontier

Decisions branch. Settling one exposes the decisions hanging off it, and the shape of a design is a tree rather than a list.

The **frontier** is every decision whose prerequisites are already settled: the questions you can ask now without guessing at an answer you have not heard yet. Ask the whole frontier in one round. A question whose answer depends on another question open in this same round belongs to a later round, so hold it.

Each round of answers reshapes the tree. Recompute the frontier and ask again.

**Done when** the frontier is empty: every branch visited, nothing left silently assumed. Not after a fixed number of rounds. Say plainly that you are done rather than trailing off.

## The shape

**Rounds, not a dump.** Ask a batch, stop, wait for answers, ask the next batch informed by them. A wall of forty questions is not an interview, it is a form, and it gets abandoned halfway.

**Every question carries a recommended answer.** "Which of these, and why" is work you are handing back. "I would do X because Y, unless Z applies to you" is a decision that takes five seconds to confirm or correct. This single habit is the difference between an interview that feels productive and one that feels like an interrogation.

**Facts are yours, decisions are theirs.** Anything the codebase can answer, answer it by reading the codebase. Anything a primary source can answer, send a Scout, and keep asking the rest of the frontier while it runs. A Scout still working is an unsettled prerequisite, so only the questions downstream of it wait. Never spend a question on something you could have found out. Spend questions only on preference, priority, judgment, and constraint.

Number every question and give it a title, so an answer can name what it is answering:

```
**Q1. Tenant isolation**
Shared schema with a tenant column, or a schema per tenant?
*Recommend:* shared schema. Per-tenant costs you migrations forever, and there is no compliance driver yet.
```

## Question quality

Aim at the branch, not the surface. A question that produces "yes, that's right" moved nothing. A question that produces "oh, actually no" was worth asking.

The productive shapes:

- **The fork.** Two defensible designs, and the choice changes what gets built.
- **The edge case.** A specific concrete scenario, named. Not "what about errors" but "the upload succeeds and the callback never fires, then what."
- **The negative.** What should this deliberately not do. Refusals are the most useful answers you get and nobody volunteers them.
- **The word.** A term used two ways in one conversation. Resolve it now, because it will cost you every session afterward.

The shapes to avoid: questions with one obvious answer, questions that restate what was already said, and questions whose answer would not change anything you build.

## When a question stalls

Some questions cannot be talked to a conclusion. "How should this feel" and "one long form or three pages" need something to react to, and rephrasing them is how a session balloons.

When a question comes back unanswered twice, stop asking it and ask about the question instead. Three routes out, and the answer picks one:

- **It needs something to react to.** Ask what the smallest throwaway is that would settle it, and who builds it. This is a `spike`, per that discipline. The effort proceeds without the answer and the question comes back once there is something to look at.
- **It needs knowledge held by someone else.** Ask who holds it and what exactly to send them. Produce the question in a form that can be pasted into a message, not a note to yourself. When more than one question is going to the same person, that is a `to-questionnaire`, per that discipline: one document aimed at the gap between what they know and what you need.
- **It does not matter yet.** Ask what the cheapest reversible default is and what would make it worth revisiting.

Every route ends in a line in `.capstan/decisions.md`, per the `decision-record` skill: `open` for the first two, `assumed` with a revisit condition for the third. Write it the moment the route is picked.

Parking a question is a finished outcome rather than a failure to finish. The frontier can be empty with questions still open on it.

**Done when** no question has been asked three times.

## Keep it short

Verbosity here causes real decision fatigue. Three paragraphs of framing around a question buries the question and strips out why it is being asked. One or two sentences per question. If a question genuinely needs setup, the setup is a fact you should have established rather than context you are offloading.

## Vocabulary as you go

When a term resolves, write it into `.capstan/CONTEXT.md` immediately, one line, per the `decision-record` skill. Batching to the end of the session is how vocabulary gets lost, and the project's own word for a thing is worth more than a paragraph re-explaining the thing every time it comes up.

Challenge a word that is doing two jobs. "Account" meaning the company, the login, and the ledger entry is three concepts wearing one label, and every downstream conversation pays for it.

## When you are done

State that the frontier is empty. Summarise what was settled, in their vocabulary rather than yours, and list what is still `open` or `assumed` so the state of the tree is visible rather than implied.

Then hand off. Deciding and doing are different phases, and collapsing them is how a settled decision quietly becomes an unreviewed implementation.
