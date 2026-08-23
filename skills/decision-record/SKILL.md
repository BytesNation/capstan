---
name: decision-record
description: Record decisions so they survive without bloating anything. A one-line log by default, a full record only when it is earned, superseded rather than edited. Use whenever a decision is settled.
---

# Decision record

Three tiers, sorted by how long each thing needs to survive. Nearly everything stays in tier one.

The log, the records, and the glossary are the three durable artifacts, and each carries one property beyond the plain `capstan_` prefix: `capstan_type`, naming what the note is (`decision-log`, `decision-record`, or `glossary`). That is the whole schema, and it exists so a vault can tell a Capstan note from any other one sitting beside it.

## Tier 1: the log

The decision log, in the document home. One line per decision. Committed.

```markdown
# Decisions

| # | Date | Decision | Status |
|---|------|----------|--------|
| 11 | 2026-08-20 | Failed uploads retry 3x then dead-letter. Revisit if the queue is ever non-empty | assumed |
| 10 | 2026-08-20 | Whether tenants share a schema or get one each | open |
| 7 | 2026-08-20 | Sessions expire server-side, not by JWT claim | accepted |
| 6 | 2026-08-19 | Single Postgres instance, no read replica yet | accepted |
| 5 | 2026-08-14 | Config lives in the database, not env vars | superseded by 9 |
```

This is what an agent reads when it opens the repository cold, and what you scan six months later. It cannot bloat, because a line is a line.

Write the line the moment the decision resolves, not batched at the end of a session. A decision that only exists in a context window is a decision that is about to be lost.

### Statuses

| Status | Means |
|---|---|
| `accepted` | Decided. |
| `assumed` | Defaulted so the work could proceed. The line carries the condition that would make it worth reopening. |
| `open` | Raised and unsettled. Nobody has decided and no default is in force. |
| `unformed` | An area known to be unexplored, where the question itself cannot be phrased yet. Not a decision, and not answerable. |
| `superseded by NNNN` | Replaced. Stays in the file, out of the reading path. |

`open` and `assumed` are what an interview parks when a question will not resolve, and they are the reason the `interview` skill reads this file before its first round. A question the operator could not answer in March is worth putting to them again in June. Without a line here it is simply forgotten, because the spec that held it was deleted at delivery.

An `assumed` line is the cheaper half of that pair. It says work carried on under a default that nobody has blessed, which is a different thing from a decision, and the distinction is worth the extra word every time somebody asks why the code does that.

`unformed` is the one that is not a question. It names an area the effort will reach and nobody has thought about yet: an integration nobody has opened, a phase of the work whose shape is still fog. Written as `open` it gets asked, stalls because it needs work rather than an answer, and is parked a second time. Written nowhere it is a surprise in phase 3. It graduates: as the area comes into view the line is rewritten as a real `open` question, or several, and that rewrite is the one place a line changes rather than being superseded, because nothing was decided and there is no history to protect.

One use of the log is easy to miss: declining a standard that arrived with the plugin. A discipline preloaded on an agent was never consented to by the repository it is about to grade, so a repository that disagrees says so here, as one `accepted` line naming the standard and the scope it does not apply to. The Reviewer reads this file before it grades, which is what makes the line binding rather than a note.

## Tier 2: the record

A full document only when the decision passes **all three** gates:

1. **Hard to reverse.** Undoing it later costs real work.
2. **Surprising without context.** A competent person arriving fresh would ask why.
3. **A real trade-off.** Something genuine was given up.

All three, not any one. Most decisions fail at least one, so most efforts produce a handful of log lines and no records at all. That is the design working, not the discipline slipping. Writing a record for every decision is exactly how decision folders became the bloat you are trying to avoid.

Lives at `decisions/NNNN-short-slug.md` in the document home. Six sections, none longer than a paragraph:

```markdown
# NNNN. Sessions expire server-side, not by JWT claim

**Status**: accepted
**Date**: 2026-08-20

## Context
What was true that forced a choice.

## Decision
What was chosen, stated plainly.

## Alternatives
What else was on the table, and what each one would have cost.

## Consequences
What this makes easy, and what it makes hard.

## Revisit when
The condition that would make this worth reopening. Write one, or admit there isn't one.
```

## Tier 3: the brief

Never stored. Generated per recipient at send time by the `brief` skill, which owns the shape.

## Never edit an accepted record

When a decision changes, write a new one that supersedes the old and cross-link both. Mark the old one `superseded by NNNN` and give the new one a `supersedes NNNN` line. Update both files, every time.

This is the mechanic that keeps the set honest. Editing an accepted record destroys the history of why the direction shifted, which is usually the most valuable thing in the folder.

Never delete a record. Superseded records stay, marked, out of the reading path.

## The glossary

The glossary, in the document home. One line per term. Committed, and it persists for the same reason the log does: the project's own word for a thing is a decision about language, and re-deriving it costs a conversation every time.

Create it lazily, on the first term that resolves. A repository with no settled vocabulary needs no file.

```markdown
# Context

| Term | Means |
|---|---|
| Slice | A change that can be demonstrated on its own. Never a layer. |
| Effort | One run from concept to delivery, holding one claim. |
| Operator | The person at the gates. Never the crew. |
```

Vocabulary only. A glossary that starts explaining how something works has become a spec, and a spec that outlives delivery is the stale artifact this whole model exists to prevent.

**Edit it in place.** This is the one file here that is never superseded, because a glossary read archaeologically is a glossary nobody reads. It holds current truth and nothing else.

The *change* is what gets recorded. When a term shifts meaning, or one word splits into two, write a numbered line in the decision log, in the document home, saying so. Current definition in one file, history in the other, and neither doing the other's job.

## What does not go here

Specs, plans, research findings, review output, and checkpoint drafts all live in `.capstan/effort/`, which is gitignored and deleted at delivery. Only decisions persist.

## The permanent note

At delivery the Courier writes one note per effort into the knowledge base: what it was, what was decided, what was rejected, and links out to the code and the records. That note is the only thing that can answer what has been decided across every venture at once, which no single repository can.

**Done when** every decision this session settled is a line, every question it could not settle is `open`, `assumed` or `unformed`, and every line that passes all three gates has a record beside it.
