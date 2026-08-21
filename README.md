# Capstan

A complete Claude Code agent environment for taking work from concept to delivery, with a human at three gates.

You get five roles (Scout, Architect, Builder, Reviewer, Courier) that carry the work, fourteen disciplines that structure it from the interview through to delivery, and three gates where you decide whether the run continues.

Plain markdown, plus one vendored bash library that `walkthrough` builds throwaway scripts from.

## Install

```bash
claude plugin marketplace add BytesNation/capstan
claude plugin install capstan@bytesnation
```

Restart Claude Code once it finishes: agent definitions load at session start, and nothing applies until you do.

Then start work with `/capstan:effort <what you want built>`.

---

The words above are load-bearing. [`.capstan/CONTEXT.md`](.capstan/CONTEXT.md) defines each one, and [`DESIGN.md`](DESIGN.md) holds the reasoning behind why the crew is shaped this way.

## The disciplines

Fourteen disciplines the roles pull in, plus `effort` itself: the front door, invoked only by you.

| Skill | For |
|---|---|
| `interview` | Rounds of questions, each carrying a recommended answer, so decisions stay yours. |
| `spike` | A throwaway build, so a stalled design question gets something concrete to react to. |
| `slicing` | Cuts a locked plan into vertical slices with real blocking edges. |
| `test-first` | Red, green, refactor, tested only at seams agreed in advance. |
| `resolving-merge-conflicts` | Integrating parallel Builders, where neither side of a conflict can be asked what it meant. |
| `diagnosing-bugs` | A feedback loop that goes red on the bug before anyone theorises about the cause. |
| `walkthrough` | The one-time script that carries the operator through a manual procedure, stage by stage, capturing what comes back. |
| `decision-record` | A one-line log by default, a full record only when one is earned. |
| `brief` | Checkpoint and partner briefs, generated per recipient rather than maintained. |
| `to-questionnaire` | Turns a question nobody in the room can answer into a document for the person who can. |
| `two-axis-review` | Standards and spec, reviewed independently, never blended into one verdict. |
| `codebase-design` | The words for structure, so a review can say a module is too shallow instead of that it feels wrong. |
| `unslop` | Cuts AI tells from prose a person reads. |
| `writing-for-agents` | Keeps a document an agent consumes flat and the same shape every run. |

## Install detail

`claude plugin install capstan@bytesnation` installs at user scope, so the crew is available in every session. Add `--scope project` to write to the project's `.claude/settings.json` instead, so the install travels with the repository, which is what you want if a team shares it.

### The two installs name things differently

A plugin namespaces what it ships, so the Builder is `capstan:builder` under a plugin install and plain `builder` under a manual one. `skills/effort/SKILL.md` tells the Architect which agent to spawn for each role, so use whichever form your install actually produced. The manual install is the one this crew has been run on; the plugin path is newer and less exercised.

### Installing by hand instead

```bash
git clone https://github.com/BytesNation/capstan.git
cp -r capstan/agents/* ~/.claude/agents/
cp -r capstan/skills/* ~/.claude/skills/
```

Then start work with `/effort <what you want built>`.

### Three skills are more than one file

Most skills here are a lone `SKILL.md`. Three are not, and lifting just the `SKILL.md` out of any of them leaves pointers aimed at files that are not there.

```
skills/effort/
  SKILL.md              identity, the crew, the gates, the precondition, phase 1
  PHASE-2-PLAN.md
  PHASE-3-BUILD.md
  PHASE-4-DELIVER.md

skills/writing-for-agents/
  SKILL.md
  SKILL-MECHANICS.md    frontmatter, invocation, router skills
  AUDIT.md              the editing pass to run against a target document
  LICENSE, CREDIT.md    upstream is MIT, see the licence section

skills/walkthrough/
  SKILL.md              identity, how to author a stage, the two guards before a write leaves the machine
  template.sh           vendored library, never edited
  LICENSE, CREDIT.md    upstream is MIT, see the licence section

skills/diagnosing-bugs/
  SKILL.md              vendored, three repointed lines
  LICENSE, CREDIT.md    upstream is MIT, see the licence section

skills/codebase-design/
  SKILL.md              the vocabulary and its principles
  DEEPENING.md          dependency categories, seam discipline, replace-don't-layer testing
  DESIGN-IT-TWICE.md    parallel sub-agents designing one interface several ways
  LICENSE, CREDIT.md    upstream is MIT, see the licence section

skills/to-questionnaire/
  SKILL.md              vendored, two local changes
  LICENSE, CREDIT.md    upstream is MIT, see the licence section

skills/resolving-merge-conflicts/
  SKILL.md              vendored, two local changes
  LICENSE, CREDIT.md    upstream is MIT, see the licence section
```

The Architect reads the file for the phase it is in, so a run that reaches gate two with no `PHASE-2-PLAN.md` beside it has nothing to follow and will improvise a plan phase. Take the whole directory.

## Upgrading

**Crossing the 2.0.0 rename.** `claude-tools` became `capstan`. GitHub redirects the old repository address, so a marketplace added as `BytesNation/Claude-tools` keeps working and does not need re-adding. The plugin name itself does not carry over, though: `claude-tools` and `capstan` are different identifiers to the CLI, so there is no update path between them, only uninstall then install.

```bash
claude plugin uninstall claude-tools@bytesnation
claude plugin marketplace update bytesnation
claude plugin install capstan@bytesnation
```

Add `-s project` to the uninstall and install commands if you installed at that scope. Restart Claude Code once it finishes, and every `/claude-tools:*` command becomes `/capstan:*`. Running `claude plugin marketplace update` before the uninstall step leaves the old entry reporting `Plugin claude-tools not found in marketplace bytesnation`, which is alarming, harmless, and clears once the uninstall finishes.

**Ordinary version bumps.** Once you are on `capstan`:

```bash
claude plugin marketplace update bytesnation
claude plugin update capstan@bytesnation
```

The first command refreshes the marketplace catalog and installs nothing on its own; in a session, `/plugin marketplace update bytesnation` does the same refresh. The second does the install and needs the marketplace-qualified name, `capstan@bytesnation`; the bare name does not resolve. Add `-s project` if you installed at that scope, and restart Claude Code once it finishes.

The `/plugin` auto-update toggle cannot cross the rename above: a `claude-tools` install left on auto-update sits on 1.1.0 with no error to say so. Leave it off, the same as any third-party marketplace.

**From 2.0.0.** Capstan's own artifacts move under `.capstan/`. Move `CONTEXT.md`, `decisions.md`, and `decisions/` to `.capstan/`, change the `.gitignore` line from `.effort/` to `.capstan/effort/`, and delete `.effort/` itself, gitignored scratch that may already be absent. This file move has not been run against a live repository. The Architect does not move, delete, or commit any of it: it only detects a pre-2.1.0 layout and asks before it starts an effort. Say yes to any path, and the run ends there for you to make the move and start again. Say no, and it continues.

**Manual install.** The copy above overwrites what it finds and leaves everything else alone, so a version that drops or renames a file leaves the old one sitting there. Replace a skill outright rather than copying over it:

```bash
rm -rf ~/.claude/skills/effort
cp -r capstan/skills/effort ~/.claude/skills/
```

## Known limits

**`/capstan:effort` cannot be invoked by a model.** It carries `disable-model-invocation: true`, so only you can start an effort. That is intentional, because an agent that can start work on its own authority can commit you to work you never asked for. It does mean kickoff is always something you type.

**Bash is an escape hatch.** Scout's read-only guarantee is structural: its tool grant contains no write tools, so the harness enforces it. Builder, Reviewer, and Courier all hold Bash, so their "never do X" rules are prose, not enforcement. If you want the gates enforced rather than requested, add a deny list to `settings.json`.

**Builder runs with `acceptEdits`.** File writes will not prompt. Bash commands still can, which is where unattended fan-out tends to stall.

**Effort is not supported on Haiku.** Drop the `effort:` line from any agent you point at a Haiku model.

**Fan-out does nothing for single-artifact work.** Parallel builders need slices that own different files. A document, a video script, a single config file: all one artifact, all inherently one Builder. Software usually fans out because slices own different things. Most non-code work does not, and a one-slice plan there is correct rather than a failure to parallelise.

**A knowledge base that is not a git repository gives its note no fixed point.** The Reviewer reads the note whole instead and says so in the report. Review is degraded, never skipped.

## Configure

Two things are setup-specific and read from your `CLAUDE.md` or `AGENTS.md` rather than hardcoded:

- Where the Courier writes the permanent per-effort note. With none configured it skips the step and says so.
- Where efforts and their artifacts live.

An effort writes `.capstan/effort/CLAIM.md` when it starts and updates it at every gate. Another Architect finding a live claim stops and asks rather than starting. The ceiling counts efforts, not sessions, so without this two sessions will happily run the same work and write over each other.

Because a run *ends* at each gate, every phase after the first begins by re-reading the repository rather than trusting the plan it wrote. Hours can pass between gates and the work may already be done.

Concurrency is capped at three efforts. Three gates each against one reader is nine briefs a cycle, which is roughly where they stop being read and start being rubber-stamped. Fan-out *inside* an effort is unbounded.

## License

MIT. See [LICENSE](LICENSE). Take it, change it, ship it.

Seven skills here are not ours. All seven are MIT, all seven are redistributed with their own licence and a `CREDIT.md` in their folder noting exactly what we changed:

- `skills/writing-for-agents/`: `SKILL.md` and `SKILL-MECHANICS.md` by [Matt Pocock](https://github.com/mattpocock/skills). `AUDIT.md` beside them is ours.
- `skills/unslop/`: `SKILL.md` by [Lauren Tan](https://github.com/cursor/plugins/tree/main/pstack/skills/unslop), via cursor/plugins. Our changes are two lines, listed in that folder's `CREDIT.md`.
- `skills/walkthrough/`: `template.sh` by [Matt Pocock](https://github.com/mattpocock/skills), vendored byte-identical to upstream. `SKILL.md` beside it is ours, written fresh around the library.
- `skills/diagnosing-bugs/`: `SKILL.md` by [Matt Pocock](https://github.com/mattpocock/skills). Three lines repointed at Capstan's own paths and at `walkthrough`, listed in that folder's `CREDIT.md`.
- `skills/codebase-design/`: `SKILL.md`, `DEEPENING.md` and `DESIGN-IT-TWICE.md` by [Matt Pocock](https://github.com/mattpocock/skills). One line repointed at `.capstan/CONTEXT.md`; the first two are byte-identical.
- `skills/to-questionnaire/`: `SKILL.md` by [Matt Pocock](https://github.com/mattpocock/skills). Two changes, listed in that folder's `CREDIT.md`: the invocation flag, and where the document lands and where its answers go.
- `skills/resolving-merge-conflicts/`: `SKILL.md` by [Matt Pocock](https://github.com/mattpocock/skills). Two changes, listed in that folder's `CREDIT.md`: where a hunk's intent is found, and one exception to never aborting.

Beyond those seven, nothing here is vendored, though two ideas are borrowed, both from [Matt Pocock](https://github.com/mattpocock/skills). The prose is ours; the mechanics are his.

- The frontier in `interview`: a design tree, where a question depending on an open question waits for a later round. Sharpened from `grilling`.
- The `next` line in `CLAIM.md`: what the run after this one picks up, written for the agent that resumes rather than the person at the gate. Taken from `handoff`, sized down to a field in a file that already exists.
