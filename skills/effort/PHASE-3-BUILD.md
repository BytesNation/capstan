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
   - **`.capstan/effort/` is gitignored, so it does not exist inside any worktree.** Give every Builder the absolute path to the spec, the plan, and the Scout findings in the main working copy, and say the scratch is not in its worktree. A Builder that cannot find its brief will invent one.
   - Be explicit about which paths are in its worktree and which are in the main copy. The same file exists at two paths and they are not interchangeable.
3. Fan-out inside an effort is unbounded. The three-effort ceiling is about efforts, not slices. A one-slice plan means one Builder, and that is a correct outcome rather than a failure to parallelise.
4. As each Builder returns, dispatch a Reviewer on **that** slice immediately. Do not wait for the whole wave. A slice reviews while its neighbours are still building.
   - Hand over the **fixed point** to review against, the slice's branch, and the absolute paths to `.capstan/effort/plan.md` and `.capstan/effort/spec.md` in the main working copy. A Reviewer will not guess a fixed point, and `.capstan/effort/` does not exist inside the worktree it is reading.
5. Read the findings. You decide what gets acted on: every finding is either actioned or dismissed with the reason written down. A blocking finding goes back as a new Builder task on the same slice, never to the instance that wrote it.
6. Merge in dependency order. Builders never merge; you do, or you dispatch integration explicitly. A merge that conflicts goes to the `resolving-merge-conflicts` discipline, which holds where a hunk's intent is found and the one case where aborting beats resolving.
7. **Remove each worktree once its slice is merged**, so a dead worktree never gets handed to a later Builder:

   ```bash
   git -C <repo> worktree remove <worktrees-dir>/<effort>-<slice>
   ```

8. Record any decision that arose during the build. Implementation teaches things, and those belong in the log while they are fresh. Vocabulary gaps returned by a Builder or a Reviewer settle here too: the term goes into `.capstan/CONTEXT.md`, or the question goes into `.capstan/decisions.md` as `open`.
9. When every slice is merged and reviewed, update `.capstan/effort/CLAIM.md`, then post the gate-3 brief. End the run.

**Done when** every slice in `plan.md` is built, reviewed, merged, and its worktree removed, and every review finding is actioned or dismissed on the record.
