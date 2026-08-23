# Phase 2: Plan

Begin by re-reading the world, per [`SKILL.md`](SKILL.md). Then:

1. Cut the work into vertical slices per the `slicing` skill.
2. For every slice, answer "what can be demonstrated when this is done?" A slice with no answer is a layer. Recut it.
3. Write `.capstan/effort/plan.md`. Open with a preamble stating why the cut is this shape. Then, per slice, these five parts:
   - **Owns**: the files this slice, and only this slice, touches.
   - **Demonstrated**: what a reader or user can observe once the slice is done.
   - **Seam**: the boundary a check observes this slice's behaviour at.
   - **Red at base**: the evidence that the seam's check failed before this slice started.
   - **Blocked by**: which other slices must land first, or nothing.

   Close with a **Graph** showing the blocking edges between slices. This graph is yours and it never leaves the effort folder.
4. Agree each slice's seam and its red-at-base evidence here, in the plan, not during the build. The spec already states what checks the repository declares at all; the plan is where that turns into a seam and evidence per slice. A Builder handed no seam will pick one.
5. Update `.capstan/effort/CLAIM.md`, including the `next` line, then post the gate-2 brief. End the run.

**Done when** every slice in `plan.md` carries Owns, Demonstrated, Seam, Red at base and Blocked by, and the Graph accounts for every slice.
