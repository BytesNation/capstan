---
name: resolving-merge-conflicts
description: "Use when you need to resolve an in-progress git merge/rebase conflict."
---

1. **See the current state** of the merge/rebase. Check git history, and the conflicting files.

2. **Find the primary sources** for each conflict. Understand deeply why each change was made, and what the original intent was. In an effort, that is `.capstan/effort/plan.md`, which holds each slice's intent and the blocking edges between them, and `.capstan/effort/spec.md` behind it. Commit messages, PRs and tickets are the fallback when no effort is in flight; a Builder writes them for its own branch, not for the integration.

3. **Resolve each hunk.** Preserve both intents where possible. Where incompatible, pick the one matching the merge's stated goal and note the trade-off as a line in `.capstan/decisions.md`, per `decision-record`. Do **not** invent new behaviour. Always resolve; never `--abort`.

   One exception, and only one. If resolving would mean inventing behaviour neither side has, or the conflict shows the two slices were never independent, that is a defect in the slicing rather than a merge to force through. Abort and report it. Every Builder's work sits on its own branch, so an abort costs the merge and nothing else.

4. Discover the project's **automated checks** and run them, typically typecheck, then tests, then format. Fix anything the merge broke.

5. **Finish the merge/rebase.** Stage everything and commit. If rebasing, continue the rebase process until all commits are rebased.
