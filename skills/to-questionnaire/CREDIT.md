# Credit

`SKILL.md` in this folder is the work of Matt Pocock, taken from
[mattpocock/skills](https://github.com/mattpocock/skills) under the MIT licence.
The full licence text sits beside it in `LICENSE`, and it is the licence that
governs that file.

Two local changes:

- `disable-model-invocation: true` is dropped from the frontmatter. Upstream is
  a slash command the operator types. Here the Architect reaches for it from the
  interview's third route out, so it has to be model-invocable, and every
  Capstan discipline is. `effort` is the only skill in this repository that
  keeps the flag.
- Step 3 writes to `.capstan/effort/` rather than the current directory, states
  that sending is gated, and says where the answers land: the `open` lines that
  prompted the questionnaire, per `decision-record`. The document itself is
  scratch and goes at delivery, the same as every other file under
  `.capstan/effort/`.

That second change is the only place Capstan adds rather than repoints.
Upstream ends at the file being written, because upstream has no decision log
for an answer to return to. Without those sentences the questionnaire is a
document with no destination, which is the failure the log exists to prevent.

The questionnaire template is untouched.

`agents/openai.yaml` is not vendored: packaging metadata for a runtime this
plugin does not target.

Everything else is upstream, unmodified. To refresh, re-fetch `SKILL.md` and
re-apply both changes.
