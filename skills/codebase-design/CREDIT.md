# Credit

`SKILL.md`, `DEEPENING.md` and `DESIGN-IT-TWICE.md` in this folder are the work
of Matt Pocock, taken from
[mattpocock/skills](https://github.com/mattpocock/skills) under the MIT licence.
The full licence text sits beside them in `LICENSE`, and it is the licence that
governs those three files.

One local change, one line:

- `DESIGN-IT-TWICE.md` names `.capstan/CONTEXT.md` as the domain glossary the
  sub-agent briefs carry, rather than a root `CONTEXT.md`.

`SKILL.md` and `DEEPENING.md` are vendored byte-identical to upstream.

Two things were deliberately left alone:

- The TypeScript examples in the testability section. They illustrate accepting
  dependencies and returning results, both language-agnostic points, and
  rewriting them per language would make every refresh a merge instead of a
  copy. Capstan runs efforts that are not software at all; a reader outside
  TypeScript should read them as sketches.
- The deep-module position itself, which is Ousterhout-derived and opinionated.
  Vendoring it makes that opinion house style. See
  [0003](../../.capstan/decisions/0003-adopt-deep-modules-as-the-design-standard.md)
  for why that was accepted rather than softened.

`agents/openai.yaml` is not vendored: packaging metadata for a runtime this
plugin does not target.

Everything else is upstream, unmodified. To refresh, re-fetch all three files
and re-apply that one line.
