# Phase 3: Build

Begin by re-reading the world, per [`SKILL.md`](SKILL.md). Then:

1. **Create each worktree yourself, before dispatching.** One per slice, outside the repository tree:

   ```bash
   git -C <repo> worktree add -q <worktrees-dir>/<effort>-<slice> -b <effort>/<slice>
   ```

   Do not rely on a Builder's frontmatter for isolation. Frontmatter worktree isolation binds to the *session's* working directory rather than to the repository the work lives in, so it fails outright whenever the session is rooted elsewhere, which is most of the time. Creating them yourself works from any session and you control the cleanup.

   Use `-q`. Without it git prints a per-file progress bar, which on a large repository is thousands of lines of noise into your context for every slice.

   Tell each Builder the absolute path of its worktree and say plainly that it is to work there.

2. Dispatch Builders on the unblocked frontier. Every slice with no open blockers can go at once.
   - **`.capstan/effort/` is gitignored, so it does not exist inside any worktree.** Give every Builder the absolute path to the spec, the plan, and the Scout findings in the main working copy, and the resolved document home, and say the scratch is not in its worktree. A Builder that cannot find its brief will invent one; nor can it resolve the document home itself.
   - Be explicit about which paths are in its worktree and which are in the main copy. The same file exists at two paths and they are not interchangeable.
   - Move that slice's row in `tracker.md`, in the document home, to `building` as you dispatch it. A slice cut at any point in this phase moves its row to `dropped` — never delete a row, cut or built.
3. Fan-out inside an effort is unbounded. The three-effort ceiling is about efforts, not slices. A one-slice plan means one Builder, and that is a correct outcome rather than a failure to parallelise.
4. As each Builder returns, dispatch a Reviewer on **that** slice immediately. Do not wait for the whole wave. A slice reviews while its neighbours are still building.
   - Hand over the **fixed point** to review against, the slice's branch, the absolute paths to `.capstan/effort/plan.md` and `.capstan/effort/spec.md` in the main working copy, and the resolved document home. A Reviewer will not guess a fixed point, and `.capstan/effort/` does not exist inside the worktree it is reading.
   - **You** write each Reviewer return verbatim to `.capstan/effort/review/<slice>-<n>.md`, where `<n>` is a round counter starting at 1. Do not summarise it on the way in; the citations and the finding format are the parts that matter later.
5. Read the findings. You decide what gets acted on: every finding is either actioned or dismissed with the reason written down in `decisions.md` in the document home, never in the review file itself, which holds the return and nothing else. A blocking finding goes back as a new Builder task on the same slice, never to the instance that wrote it.
6. Merge in dependency order. Builders never merge; you do, or you dispatch integration explicitly. A merge that conflicts goes to the `resolving-merge-conflicts` discipline, which holds where a hunk's intent is found and the one case where aborting beats resolving. As each slice merges, move its row in `tracker.md`, in the document home, to `merged`, carrying the merge commit.
7. **Remove each worktree once its slice is merged**, so a dead worktree never gets handed to a later Builder:

   ```bash
   git -C <repo> worktree remove <worktrees-dir>/<effort>-<slice>
   ```

8. **Verify the integration**, per the `verify` discipline. Every slice passed in its own worktree, which says nothing about them together, and the gate-3 brief is about to claim the work is done. Red goes back as a Builder task on the slice the merge order implicates, not into this run.
   - File the verify return the same way: write it verbatim to `.capstan/effort/review/verify-<n>.md`, `<n>` a round counter, and keep that file to the return alone — actioning or dismissing what it finds still goes in `decisions.md` in the document home.

9. Record any decision that arose during the build. Implementation teaches things, and those belong in the log while they are fresh. Vocabulary gaps returned by a Builder or a Reviewer settle here too: the term goes into the glossary (`CONTEXT.md`), or the question goes into the decision log (`decisions.md`) as `open`, both in the document home, which is `<working copy>/.capstan/` unless configured otherwise.
10. When every slice is merged, reviewed and verified, update `.capstan/effort/CLAIM.md`, then post the gate-3 brief. End the run.

   If the run ends before that, for any reason, update the claim's `next` line before it does. This is the phase where slices sit in four states at once, and a branch alone does not say whether a slice is unreviewed, reviewed with findings outstanding, or ready to merge.

**Done when** every slice in `plan.md` is built, reviewed, merged, and its worktree removed, the integration has been verified against the checks the repository declares, every review and verify return is filed, every review and verification finding is actioned or dismissed on the record, and every slice's row in `tracker.md` reads `merged` or `dropped`.
