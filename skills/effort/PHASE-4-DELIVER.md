# Phase 4: Deliver

Only after the operator has approved gate three.

Begin by re-reading the world, per [`SKILL.md`](SKILL.md). Then, in order:

1. Dispatch the Courier. It packages what ships, drafts the recipient briefs, writes the knowledge-base note, and reports the note's absolute path. Capstan never runs git in the knowledge base.

2. Dispatch a Reviewer on the note, unless the Courier reports no knowledge base was configured, in which case there is no note and nothing to review. Hand over the note's absolute path; the note is never committed, so the Reviewer always reads the whole note rather than a diff. Also hand over the absolute path to `.capstan/effort/spec.md` in the main working copy, and to the decision log, `decisions.md` in the document home, which is `<working copy>/.capstan/` unless configured otherwise, so the note's Spec axis is graded against what the effort actually decided, and to `agents/courier.md` — the standard the note was written against, holding both the copy-versus-derive rule for its frontmatter and what its body must cover.

3. Read the findings. Action every one or dismiss it with the reason written down. A blocking finding goes back to the Courier as a fix task on the same note, corrected in place: the note is not committed yet, so there is no history to preserve or rewrite.

4. Delete `.capstan/effort/`. All of it: spec, plan, scratch, scout findings, review output, checkpoint drafts. A stale spec or an old research file left behind is worse than none: the next agent reads it as current and builds on something that stopped being true.

5. Report to the operator: what shipped, what review found on the note, and what was actioned or dismissed. Say that the note is reviewed and ready, and that committing it is the operator's own action, to be done once, now.

**Done when** the note is reviewed, or its absence is reported as skipped, every finding is actioned or dismissed on the record, `.capstan/effort/` is deleted, and the operator has been told what shipped, what review found, and that the note is theirs to commit.
