# Capstan

<a href='https://ko-fi.com/G5C025L5FG' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://storage.ko-fi.com/cdn/kofi6.png?v=6' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>

A Claude Code plugin for taking work from concept to delivery, with you at three gates.

Five roles carry the work, a discipline for each part of it, and three times the run stops so you can decide whether it continues. It is plain markdown, plus one vendored bash library that `walkthrough` builds throwaway scripts from. Nothing here needs code running to stay alive.

[`.capstan/CONTEXT.md`](.capstan/CONTEXT.md) defines every word this repository uses, and [`DESIGN.md`](DESIGN.md) holds the reasoning behind the shape.

## Install

```bash
claude plugin marketplace add BytesNation/capstan
claude plugin install capstan@bytesnation
```

Restart Claude Code once it finishes. Agent definitions load at session start, so nothing applies until you do.

That installs at user scope, so the crew is available in every session. Add `--scope project` to write to the project's `.claude/settings.json` instead, which is what you want when a team shares one repository.

## Your first run

```
/capstan:effort add rate limiting to the public API
```

You are now talking to the Architect, and you keep talking to it for the rest of the run. It owns the interview, the spec, the slice graph and the decision log. It does not build and it does not review, because the Builder and the Reviewer do that, and keeping those apart is the whole reason there are five roles instead of one.

What happens, in order:

1. **It interviews you.** Rounds of questions, each carrying a recommended answer, so most rounds are you confirming rather than composing. Finding things out is its job, not yours. Anything the codebase or a primary source can answer, it goes and reads.
2. **It stops at gate one** with a brief covering what it is building, why, and what it is deliberately not building. Protect this gate. A wrong turn is cheapest to catch here, and it is the one that gets waved through because the concept feels obvious to everyone in the room.
3. **Phase two plans.** It cuts the work into vertical slices, agrees where the tests go, and stops at gate two with the slice graph and everything it had to assume.
4. **Phase three builds.** One Builder per slice, each in its own git worktree, each writing a failing test first. A Reviewer reads every diff without the Builder's reasoning, on two axes that never blend into one verdict. Once the slices merge, your repository's own checks run against the integration, because passing alone proves nothing about passing together. Gate three shows you what was built, what review found, and what verification showed.
5. **Phase four delivers.** The Courier packages the output, writes the permanent note, and commits it. It never sends anything to anyone. That part stays yours.

| Gate | The brief answers | You decide |
|---|---|---|
| 1. Concept locked | What we are building, why, what we are explicitly not doing | Right thing? |
| 2. Plan locked | How, cut into slices, what runs parallel, what was assumed | Right shape? |
| 3. Ready to deliver | What was built, what review and verification found, what goes to whom | Ship? |

**The run ends at every gate.** Nothing polls, nothing waits in the background, and the crew never asks whether it should stop. The run being over is what makes the gate real. `.capstan/effort/CLAIM.md` records which phase the effort reached and what is still outstanding inside it, so the next session picks up where the last one stopped, however many hours later.

**Unclear requirements never stop the run.** The crew takes the most defensible reading, writes the assumption into the decision log, and keeps going. Every assumption surfaces at the next gate, where correcting one costs almost nothing. Four things do stop it: secrets and credentials, anything a third party will see, anything that costs money, and anything destructive or production-facing.

Three efforts at once is the ceiling. Three gates each against one reader is nine briefs a cycle, which is about where briefs stop being read and start being rubber-stamped. Fan-out inside a single effort has no limit.

## The disciplines

The disciplines the roles pull in, plus [`effort`](skills/effort/SKILL.md) itself: the front door, invoked only by you.

| Skill | For |
|---|---|
| [`interview`](skills/interview/SKILL.md) | Rounds of questions, each carrying a recommended answer, so decisions stay yours. |
| [`spike`](skills/spike/SKILL.md) | A throwaway build, so a stalled design question gets something concrete to react to. |
| [`slicing`](skills/slicing/SKILL.md) | Cuts a locked plan into vertical slices with real blocking edges. |
| [`test-first`](skills/test-first/SKILL.md) | Red, green, refactor, tested only at seams agreed in advance. |
| [`diagnosing-bugs`](skills/diagnosing-bugs/SKILL.md) | A feedback loop that goes red on the bug before anyone theorises about the cause. |
| [`codebase-design`](skills/codebase-design/SKILL.md) | The words for structure, so a review can say a module is too shallow instead of that it feels wrong. |
| [`two-axis-review`](skills/two-axis-review/SKILL.md) | Standards and spec, reviewed independently, never blended into one verdict. |
| [`verify`](skills/verify/SKILL.md) | Runs the checks your repository declares against the merged result, because a slice passing alone proves nothing about the ones beside it. |
| [`resolving-merge-conflicts`](skills/resolving-merge-conflicts/SKILL.md) | Integrating parallel Builders, where neither side of a conflict can be asked what it meant. |
| [`walkthrough`](skills/walkthrough/SKILL.md) | The one-time script that carries you through a manual procedure, stage by stage, capturing what comes back. |
| [`decision-record`](skills/decision-record/SKILL.md) | A one-line log by default, a full record only when one is earned. |
| [`brief`](skills/brief/SKILL.md) | Checkpoint and partner briefs, generated per recipient rather than maintained. |
| [`to-questionnaire`](skills/to-questionnaire/SKILL.md) | Turns a question nobody in the room can answer into a document for the person who can. |
| [`unslop`](skills/unslop/SKILL.md) | Cuts AI tells from prose a person reads. |
| [`writing-for-agents`](skills/writing-for-agents/SKILL.md) | Keeps a document an agent consumes flat and the same shape every run. |

## What Capstan writes

Everything lands in `.capstan/`, inside the repository the work is happening in:

```
.capstan/
  CONTEXT.md      one line per term. committed. edited in place.
  decisions.md    one line per decision. committed.
  decisions/      a full record, only when one is earned. committed.
  effort/         scratch: the claim, spec, plan, scout returns. gitignored.
```

Add `.capstan/effort/` to your `.gitignore`. That folder is deleted at delivery, because a stale spec is worse than no spec: the next agent reads it as current.

Two more things are read from your own `CLAUDE.md` or `AGENTS.md` rather than hardcoded. Where the Courier writes the permanent per-effort note, which it skips and says so if you have not set one. And where efforts and their artifacts live.

## Upgrading

```bash
claude plugin marketplace update bytesnation
claude plugin update capstan@bytesnation
```

The first refreshes the marketplace catalogue and installs nothing by itself. The second does the install and needs the marketplace-qualified name: `capstan@bytesnation` resolves, a bare `capstan` does not. Add `-s project` if that is where you installed, then restart Claude Code.

Leave the `/plugin` auto-update toggle off, the same as for any third-party marketplace.

### Moving the marketplace to a different address

No command edits a marketplace's source in place, and editing `~/.claude/plugins/known_marketplaces.json` by hand does not hold, because the next `claude plugin marketplace update` puts the old address back. Removing and re-adding is the route that sticks.

**Removing a marketplace uninstalls every plugin installed from it.** The install record empties and the marketplace clone is deleted, so the second and third commands here are the repair rather than tidying afterwards. Run the first alone and you have no Capstan:

```bash
claude plugin marketplace remove bytesnation
claude plugin marketplace add BytesNation/capstan
claude plugin install capstan@bytesnation --scope user
```

Use `--scope project` on the last command if that is where it was installed. `capstan@bytesnation` survives the round trip because a marketplace takes its name from the `name` field in its `marketplace.json` rather than from the repository path, so re-adding from a different address produces the same marketplace and the same plugin identifier.

The version cache under `~/.claude/plugins/cache/` is untouched throughout. A session open while you do this keeps resolving skills from the copy it already holds, and picks up the reinstall when you restart it.

## Installing by hand

```bash
git clone https://github.com/BytesNation/capstan.git
cp -r capstan/agents/* ~/.claude/agents/
cp -r capstan/skills/* ~/.claude/skills/
```

Then start work with `/effort <what you want built>`.

A plugin namespaces what it ships, so the Builder is `capstan:builder` under a plugin install and plain `builder` under a manual one. [`skills/effort/SKILL.md`](skills/effort/SKILL.md) tells the Architect which agent to spawn for each role, so use whichever form your install produced. The plugin path is the exercised one: installing, updating, and a full remove and re-add have all been run against it. The manual copy is there for a setup with no marketplace, and sees less use.

Copying over an existing manual install leaves behind any file a new version dropped or renamed. Replace a skill outright rather than copying onto it:

```bash
rm -rf ~/.claude/skills/effort
cp -r capstan/skills/effort ~/.claude/skills/
```

### Some skills are more than one file

Most skills here are a lone `SKILL.md`. The ones below are not, and lifting only the `SKILL.md` out of one of them leaves pointers aimed at files that are not there.

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

skills/codebase-design/
  SKILL.md              the vocabulary and its principles
  DEEPENING.md          dependency categories, seam discipline, replace-don't-layer testing
  DESIGN-IT-TWICE.md    parallel sub-agents designing one interface several ways
  LICENSE, CREDIT.md    upstream is MIT, see the licence section

skills/diagnosing-bugs/
  SKILL.md              vendored, three repointed lines
  LICENSE, CREDIT.md    upstream is MIT, see the licence section

skills/to-questionnaire/
  SKILL.md              vendored, two local changes
  LICENSE, CREDIT.md    upstream is MIT, see the licence section

skills/resolving-merge-conflicts/
  SKILL.md              vendored, two local changes
  LICENSE, CREDIT.md    upstream is MIT, see the licence section

skills/unslop/
  SKILL.md              vendored, two local changes
  LICENSE, CREDIT.md    upstream is MIT, see the licence section
```

The Architect reads the file for the phase it is in, so a run that reaches gate two with no `PHASE-2-PLAN.md` beside it has nothing to follow and improvises a plan phase instead. Take the whole directory.

## Known limits

**`/capstan:effort` cannot be invoked by a model.** It carries `disable-model-invocation: true`, so only you start an effort. An agent that can start work on its own authority can commit you to work you never asked for. It does mean kickoff is always something you type.

**Bash is an escape hatch.** Scout's read-only guarantee is structural: its tool grant holds no write tools, so the harness enforces it. Builder, Reviewer and Courier all hold Bash, so their "never do X" rules are prose rather than enforcement. Add a deny list to `settings.json` if you want the gates enforced instead of requested.

**Builder runs with `acceptEdits`.** File writes never prompt. Bash commands still can, which is where unattended fan-out tends to stall.

**Effort is not supported on Haiku.** Drop the `effort:` frontmatter line from any agent you point at a Haiku model.

**Fan-out does nothing for single-artifact work.** Parallel Builders need slices that own different files. A document, a video script, a single config file: each is one artifact and inherently one Builder. Software usually fans out because slices own different things. Most other work does not, and a one-slice plan there is correct rather than a failure to parallelise.

**A knowledge base that is not a git repository gives its note no fixed point.** The Reviewer reads the note whole instead and says so in the report. Review is degraded, never skipped.

## Licence

MIT. See [LICENSE](LICENSE). Take it, change it, ship it.

Some skills here are not ours. Every one is MIT, and every one is redistributed with its own licence and a `CREDIT.md` in its folder recording exactly what changed:

- [`skills/writing-for-agents/`](skills/writing-for-agents/): `SKILL.md` and `SKILL-MECHANICS.md` by [Matt Pocock](https://github.com/mattpocock/skills). `AUDIT.md` beside them is ours.
- [`skills/unslop/`](skills/unslop/): `SKILL.md` by [Lauren Tan](https://github.com/cursor/plugins/tree/main/pstack/skills/unslop), via cursor/plugins. Two lines changed.
- [`skills/walkthrough/`](skills/walkthrough/): `template.sh` by [Matt Pocock](https://github.com/mattpocock/skills), vendored byte-identical. `SKILL.md` beside it is ours, written fresh around the library.
- [`skills/diagnosing-bugs/`](skills/diagnosing-bugs/): `SKILL.md` by [Matt Pocock](https://github.com/mattpocock/skills). Three lines repointed at Capstan's own paths and at `walkthrough`.
- [`skills/codebase-design/`](skills/codebase-design/): `SKILL.md`, `DEEPENING.md` and `DESIGN-IT-TWICE.md` by [Matt Pocock](https://github.com/mattpocock/skills). One line repointed; the other two files are byte-identical.
- [`skills/to-questionnaire/`](skills/to-questionnaire/): `SKILL.md` by [Matt Pocock](https://github.com/mattpocock/skills). Two changes: the invocation flag, and where the document lands and where its answers go.
- [`skills/resolving-merge-conflicts/`](skills/resolving-merge-conflicts/): `SKILL.md` by [Matt Pocock](https://github.com/mattpocock/skills). Two changes: where a hunk's intent is found, and one exception to never aborting.

Beyond those, nothing is vendored, though some ideas are borrowed, all from [Matt Pocock](https://github.com/mattpocock/skills). The prose is ours; the mechanics are his.

- The frontier in `interview`: a design tree, where a question depending on an open question waits for a later round. Sharpened from `grilling`.
- The `next` line in `CLAIM.md`: what the run after this one picks up, written for the agent that resumes rather than the person at the gate. From `handoff`, sized down to a field in a file that already exists.
- The `unformed` status in the decision log: an area nobody can phrase a question about yet. His fog of war from `wayfinder`, without the issue tracker it is charted on.
- Two moves in `interview`: challenging a term against the glossary rather than only within the session, and inventing an edge-case scenario when a relationship between concepts stays vague. From `domain-modeling`, minus its file layout.
