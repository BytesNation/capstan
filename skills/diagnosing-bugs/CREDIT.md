# Credit

`SKILL.md` in this folder is the work of Matt Pocock, taken from
[mattpocock/skills](https://github.com/mattpocock/skills) under the MIT licence.
The full licence text sits beside it in `LICENSE`, and it is the licence that
governs that file.

Three local changes, one line each:

- The codebase-exploration line reads `.capstan/CONTEXT.md` and the decision log
  rather than a root `CONTEXT.md` and `docs/adr/`. Upstream's paths predate the
  2.1.0 move that put every Capstan artifact under `.capstan/`.
- Phase 1's last-resort feedback loop points at the `walkthrough` skill rather
  than upstream's `scripts/hitl-loop.template.sh`.
- The Phase 1 completion criterion points at `walkthrough` for the same reason.

Two upstream files are deliberately not vendored:

- `scripts/hitl-loop.template.sh`, a 44-line `step`/`capture` harness. The wizard
  library already vendored in `walkthrough` covers the same job with `step`,
  `ask`, `ask_secret` and `confirm`, and `ask_secret` keeps a credential out of
  the transcript, which is what this skill's own redaction rule wants. Two
  harnesses for one job is the duplication `writing-for-agents` warns about.
- `agents/openai.yaml`, packaging metadata for a runtime this plugin does not
  target.

Everything else is upstream, unmodified. To refresh, re-fetch `SKILL.md` and
re-apply those three lines.
