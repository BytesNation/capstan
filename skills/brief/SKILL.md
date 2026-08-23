---
name: brief
description: Write a decision-ready brief. Covers the three checkpoint briefs an effort produces and the recipient-specific partner briefs generated at delivery. Use at any gate or before anything goes to a third party.
---

# Brief

A brief is what someone reads to make a decision. It is never the raw output and it is never a draft.

The reader's time is the scarce thing. Speed of review is the whole design constraint.

## BLUF

Bottom line up front. The first sentence states what the reader is being asked to know, decide, or approve. Everything after it is support.

If nothing is needed from the reader, say **no action required** explicitly and early.

## Checkpoint briefs

Three per effort, one per gate. Each one ends a run.

**Gate 1, concept locked.** What we are building and why. What we are explicitly not building, which is usually the most useful section. The vocabulary we settled on, which is now in the glossary, in the document home, rather than only in this brief. Anything a Scout established that changed the shape.

**Gate 2, plan locked.** How, cut into slices, in a numbered list with the blocking edges. What runs in parallel. What can be demonstrated per slice. Every assumption made so far, each on its own line.

**Gate 3, ready to deliver.** What was built, in behaviour rather than file paths. What review found on each axis and what was done about it. What is going to whom. What verification actually showed, not what a command returned, per the `verify` discipline.

Every checkpoint brief carries an **assumptions** section, drawn from the `assumed` lines in the decision log, in the document home. This is the mechanism that lets the crew keep moving through ambiguity instead of stopping. One line each, stated as an assumption rather than a fact, so a wrong one is cheap to catch here rather than expensive to discover later.

Beside it sits an **open questions** section, drawn from the `open` lines: the ones that would not resolve at all. State each with the route that would settle it, which is a throwaway to build, a person to ask, or a default to bless. Print "none" when there are none, because a missing section reads as an oversight rather than an empty set.

Any `unformed` lines go in the same section, marked as what they are. They carry no route, because nobody can yet say what would settle them. Say what the area is and what would bring it into view.

Keep it to a page. Link down to the detail; do not paste it in.

## Partner briefs

Generated per recipient at send time. Never stored as canon, never reused, never maintained.

The same set of decisions needs a different shape for a compliance reviewer, an investor, and a subcontractor. Maintaining one document for all three is how documentation ends up unreadable to every one of them.

Write for the named person and the one thing they need to do:

- **One page.** If it will not fit, the reader needed less than you think.
- **Expand every acronym on first use.** Including the ones that feel obvious. Especially those, since they are the ones you stopped seeing.
- **No internal jargon.** The project's own vocabulary is what makes internal communication fast and external communication opaque. Translate it out.
- **Three sentences per decision.** What was decided, why, and what was rejected and why. That third sentence is the one that stops the recipient re-proposing the thing you already ruled out.
- **State what you need from them, and by when.** Or state that you need nothing.

Draft only. Sending is gated, always.

A brief carries settled decisions out to someone who must act on them; a `to-questionnaire` carries open questions out to someone who holds the answers. If you are writing a brief and find yourself asking the reader something, that part is a questionnaire.

## What a brief is not

Not a log of what happened. Not the artifact itself. Not a place to demonstrate thoroughness.

If a section exists only to show work was done, cut it. If a sentence could appear unchanged in a brief for a different effort, it says nothing about this one and it goes.

**Done when** the assumptions and open-questions sections are present or printed empty, and every section left standing carries something the reader needs in order to decide.
