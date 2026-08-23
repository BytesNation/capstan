# Phase 4: Deliver

Only after the operator has approved gate three.

Begin by re-reading the world, per [`SKILL.md`](SKILL.md). Then, in order:

1. Dispatch the Courier. It packages what ships, drafts the recipient briefs, writes the knowledge-base note, commits that note as one commit touching one path, and reports the commit.

2. Dispatch a Reviewer on the note, unless the Courier reports no knowledge base was configured, in which case there is no note and nothing to review. Hand over the fixed point the Courier reported: the knowledge-base repository and the commit together, since that repository is not the one this effort lives in. Also hand over the absolute path to `.capstan/effort/spec.md` in the main working copy, and to the decision log in the document home, so the note's Spec axis is graded against what the effort actually decided, and to `agents/courier.md` — the standard the note was written against, holding both the copy-versus-derive rule for its frontmatter and what its body must cover. If the Courier reports the knowledge base is not a git repository, there is no fixed point: hand over the note's absolute path instead and expect a degraded review rather than none.

3. Read the findings. Action every one or dismiss it with the reason written down. A blocking finding goes back to the Courier as a fix task on the same note, corrected by a second commit. Never `git commit --amend` on that commit: it sits in a repository the operator owns and may already have pushed, and rewriting history there is not yours to do.

4. Delete `.capstan/effort/`. All of it: spec, plan, scratch, scout findings, review output, checkpoint drafts. A stale spec or an old research file left behind is worse than none: the next agent reads it as current and builds on something that stopped being true.

5. Report to the operator: what shipped, what review found on the note, and what was actioned or dismissed.

**Done when** the note is reviewed, or its absence is reported as skipped, every finding is actioned or dismissed on the record, `.capstan/effort/` is deleted, and the operator has been told what shipped and what review found.
