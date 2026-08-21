# Credit

`SKILL.md` in this folder is the work of Matt Pocock, taken from
[mattpocock/skills](https://github.com/mattpocock/skills) under the MIT licence.
The full licence text sits beside it in `LICENSE`, and it is the licence that
governs that file.

Two local changes:

- Step 2 names `.capstan/effort/plan.md` and `spec.md` as the primary sources
  for a hunk, with commit messages and tickets as the fallback. Upstream assumes
  a conflict between two humans who each explained themselves somewhere. In an
  effort the two sides came from Builders that cannot be asked, and a Builder
  writes its commit messages for its own branch rather than for the
  integration. The intent lives in the plan.
- Step 3 gains one exception to `never --abort`, and says where the trade-off
  note goes.

That exception is the only place Capstan contradicts upstream rather than
repointing it. "Always resolve" is right for the ordinary case and matches the
rule about stopping for consequence rather than ambiguity: an unclear hunk is
not a reason to abandon a merge. But a conflict that can only be resolved by
inventing behaviour is evidence the slices were never independent, which is a
slicing defect, and forcing a merge over it destroys a Builder's work to hide a
planning error. Aborting is cheap here in a way it is not upstream, because
every Builder's work is already committed to its own branch: an abort costs the
merge and nothing else.

`agents/openai.yaml` is not vendored: packaging metadata for a runtime this
plugin does not target.

Everything else is upstream, unmodified. To refresh, re-fetch `SKILL.md` and
re-apply both changes.
