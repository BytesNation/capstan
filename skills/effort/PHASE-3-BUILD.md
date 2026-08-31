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
   - **The scratch at `<working copy>/.capstan/effort/` is gitignored, so it does not exist inside any worktree.** Give every Builder the absolute path to the spec, the plan, and the Scout findings in the main working copy, and the resolved document home, and say the scratch is not in its worktree. A Builder that cannot find its brief will invent one; nor can it resolve the document home itself.
   - Be explicit about which paths are in its worktree and which are in the main copy. The same file exists at two paths and they are not interchangeable.
   - Move that slice's row in the Tracker to `building` as you dispatch it — `tracker.md` in the document home when `capstan-tracker` is unset, the board `TRACKER-GITHUB.md` describes when it names one. A slice dropped at any point in this phase moves its row to `dropped` — never delete a row, dropped or merged.
3. Fan-out inside an effort is unbounded. The three-effort ceiling is about efforts, not slices. A one-slice plan means one Builder, and that is a correct outcome rather than a failure to parallelise.
4. As each Builder returns, dispatch a Reviewer on **that** slice immediately. Do not wait for the whole wave. A slice reviews while its neighbours are still building.
   - Hand over the **fixed point** to review against, the slice's branch, the absolute paths to `.capstan/effort/plan.md` and `.capstan/effort/spec.md` in the main working copy, and the resolved document home. A Reviewer will not guess a fixed point, and `<working copy>/.capstan/effort/` does not exist inside the worktree it is reading.
   - **You** write each Reviewer return verbatim to `<working copy>/.capstan/effort/review/<slice>-<n>.md`, where `<n>` is a round counter starting at 1. Do not summarise it on the way in; the citations and the finding format are the parts that matter later.
5. Read the findings. You decide what gets acted on: every finding is either actioned or dismissed with the reason written down in `decisions.md` in the document home, never in the review file itself, which holds the return and nothing else. A blocking finding goes back as a new Builder task on the same slice, never to the instance that wrote it, after the question below clears it — one more fix dispatch toward the count below, for a slice that keeps coming back.

   That fix dispatch's return earns a Reviewer too, by step 4's own rule — with one exception. You may verify the fix yourself, in place of that round, when the fix applies the Reviewer's own prescribed moves verbatim, adds no new scope, and is checkable by reading the diff against the standards the finding cited rather than the moves it prescribed. All three, together, every time; how small the change looks is never a fourth one. Short of all three, the return goes to a Reviewer like any other. The exception only reaches a fix already shaped by a Reviewer's findings — an initial build has none to apply, so step 4 governs it without exception.
6. Merge in dependency order. Builders never merge; you do, or you dispatch integration explicitly. A merge that conflicts goes to the `resolving-merge-conflicts` discipline, which holds where a hunk's intent is found and the one case where aborting beats resolving. As each slice merges, move its row in the Tracker to `merged`, carrying the merge commit.
7. **Remove each worktree once its slice is merged**, so a dead worktree never gets handed to a later Builder:

   ```bash
   git -C <repo> worktree remove <worktrees-dir>/<effort>-<slice>
   ```

8. **Verify the integration**, per the `verify` discipline. Every slice passed in its own worktree, which says nothing about them together, and the gate-3 brief is about to claim the work is done. Red goes back as a Builder task on the slice the merge order implicates, not into this run, after the question below clears it — the same fix dispatch the count below tracks, for a slice that keeps coming back.
   - File the verify return the same way: write it verbatim to `<working copy>/.capstan/effort/review/verify-<n>.md`, `<n>` a round counter, and keep that file to the return alone — actioning or dismissing what it finds still goes in `decisions.md` in the document home.

9. Record any decision that arose during the build. Implementation teaches things, and those belong in the log while they are fresh. Vocabulary gaps returned by a Builder or a Reviewer settle here too: the term goes into the glossary (`CONTEXT.md`), or the question goes into the decision log (`decisions.md`) as `open`, both in the document home, which is `<working copy>/.capstan/` unless configured otherwise.
10. When every slice is merged, reviewed and verified, update `<working copy>/.capstan/effort/CLAIM.md`, then post the gate-3 brief. End the run.

   If the run ends before that, for any reason, update the claim's `next` line before it does. This is the phase where slices sit in four states at once, and a branch alone does not say whether a slice is unreviewed, reviewed with findings outstanding, or ready to merge.

**A slice that keeps coming back is asking a question nobody has asked yet.** Track one fix-dispatch counter per slice, written down in the claim's `next` line so it survives a run boundary. It goes up every time a finding sends a Builder task back onto a slice already built once, whether the finding came from a slice review (step 5) or a verify return (step 8). It counts dispatches to a Builder, not review returns filed: a step 5 round you verify and merge yourself without ever writing a review still counts if it sent a fix back first, and a review round that changed nothing does not.

Before sending a fix dispatch that would be the third on a slice, or any dispatch after that, ask whether that slice's design is wrong rather than its implementation. Ask it every time it would fire, not once: a question asked at three and skipped from then on is how a slice reaches nine rounds with nobody having named why. Answer it unattended, the same as any other call this phase makes without the operator, and write it to `decisions.md` in the document home every time it fires, whether or not the answer changed from the round before — a record that only appears on a changed answer looks identical to a round where nobody asked.

An answer to keep patching sends the dispatch and does not end the run. An answer that recuts or drops the slice changes the shape the operator locked at gate 2, so that answer ends the run here — before the dispatch goes out — and reports to the operator instead. A recut slice's counter resets to zero: it is a different slice now, and carrying the old count in would trip the question on its very first round.

**Done when** every slice in `plan.md` is built, reviewed, merged, and its worktree removed, the integration has been verified against the checks the repository declares, every review and verify return is filed, every review and verification finding is actioned or dismissed on the record, and every slice's row in the Tracker reads `merged` or `dropped`.
