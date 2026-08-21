# Design

This document holds the reasoning behind Capstan's shape, and it is not needed to install or use the plugin.

No operating layer: no schemas, no hooks, no scheduler, nothing that has to be maintained for the workflow to keep working. That is deliberate: anything that needs code to stay alive is something you will eventually maintain or abandon, and prose survives a model change in a way a validator does not. `walkthrough` looks like an exception. It vendors 204 lines of bash. The script itself is generated for one run, handed to the operator, and thrown away, and the library it comes from is vendored and never edited. Nothing here needs upkeep to keep working, including that one.

## The crew

Roles are functions in a pipeline, not domains, so the same five handle a software feature, a client document, a video, or an infrastructure change.

| Role | Model | Owns | Never |
|---|---|---|---|
| **Scout** | sonnet / medium | Finding out. Primary sources, cited findings. Runs many in parallel. | Decides anything. Has no write tools at all. |
| **Architect** | your session | The interview, the spec, the slice graph, the decision log. | Builds or reviews. |
| **Builder** | sonnet / high | One vertical slice, test-first, in its own worktree. | Reviews itself. Touches a gated action. |
| **Reviewer** | opus / xhigh | Independent two-axis review of the diff. | Sees the Builder's reasoning. Fixes what it finds. |
| **Courier** | sonnet / medium | Packaging, recipient-specific briefs, the permanent record and its commit. | Sends anything. |

The Architect is the only role that talks to you between gates. Five roles reporting independently is five inboxes.

## Three gates

The run **stops** at each gate. There is no poller and nothing waits: the brief is posted and the run ends. You resume by invoking the next phase.

1. **Concept locked.** What we are building, why, and what we are explicitly not doing.
2. **Plan locked.** How, cut into slices, what runs parallel, what was assumed.
3. **Ready to deliver.** What was built, what review found, what goes to whom.

Gate one is the one to protect. It is where a wrong turn is cheapest to catch and the one that gets skipped.

Which is why phases 2, 3 and 4 live in their own files beside `skills/effort/SKILL.md` rather than inside it. A run genuinely ends at each gate, so that is a real context boundary, and a phase worked with the later phases sitting in view is a phase that gets rushed. Phase 1 stays in `SKILL.md`: hiding a step protects the step in front of it, not itself.

## Stop for consequence, never for ambiguity

The crew does not halt on unclear requirements. It takes the most defensible reading, writes the assumption down, and keeps moving, then surfaces every assumption at the next gate where correcting one is nearly free.

What does stop the line: secrets and credentials, anything a third party will see, anything that costs money, and anything destructive or production-facing.

## The disciplines

Ten disciplines the roles pull in, plus `effort` itself, the front door invoked only by the operator. Three agents preload the disciplines they need via `skills:` frontmatter, so the discipline is in context before the first turn rather than hopefully invoked.

| Skill | Used by | For |
|---|---|---|
| `interview` | Architect | Rounds of questions, each carrying a recommended answer. Facts are the agent's job, decisions are yours. Questions you cannot answer get parked in the log rather than lost. |
| `spike` | Builder | A throwaway spike that settles whether something behaves right or feels right, for a design question the interview could not resolve. Never merged. |
| `slicing` | Architect | Vertical slices with real blocking edges. Includes the expand-migrate-contract exception for wide refactors. |
| `test-first` | Builder | Red, green, refactor. Tests at pre-agreed seams only. |
| `walkthrough` | Architect | The one-time script for a human task step, stage by stage, confirming each and capturing what comes back. Vendors Matt Pocock's `wizard` library rather than reimplementing it. |
| `decision-record` | Architect, Courier | A one-line log by default, a full record only when it earns one, superseded rather than edited. Owns the `.capstan/CONTEXT.md` glossary, the one artifact edited in place. |
| `brief` | Architect, Courier | BLUF checkpoint briefs, and partner briefs generated per recipient rather than maintained. |
| `two-axis-review` | Reviewer | Standards and spec, answered independently, never blended into one verdict. |
| `unslop` | Anything writing prose | Cuts AI tells from writing a person will read. |
| `writing-for-agents` | You, editing this repo | The levers that make a document an agent consumes behave the same way every run. |

## Two kinds of prose

Writing for a person and writing for an agent want opposite things, and one rule for both produces bad versions of each. A brief wants voice, rhythm, and an opinion. A `SKILL.md` wants none of that: flat, deduplicated, and the same shape every run.

So the two skills split by reader, and the routing belongs in your own `CLAUDE.md`:

```markdown
Always apply the `unslop` skill to prose a person reads: chat, documents, READMEs,
commit messages, briefs. Prose an agent consumes goes to `writing-for-agents`
instead: SKILL.md files, CLAUDE.md, AGENTS.md, subagent prompts, and an effort's
spec.md and plan.md.
```

Without that line you get `unslop` announcing it must always apply and nothing telling it where to stop.

## Why decisions and the words for them are the only things that persist

Three tiers of decision, sorted by lifespan, and the glossary standing beside them.

- **Glossary**: one line per term, [`.capstan/CONTEXT.md`](.capstan/CONTEXT.md). The only file here edited in place rather than superseded, because a glossary you have to read archaeologically is a glossary nobody reads. Every agent that writes or reviews code reads it; a name that contradicts it is a review finding.
- **Log**: one line per decision, `.capstan/decisions.md`. Cannot bloat.
- **Record**: a full document only when a decision is hard to reverse *and* surprising without context *and* a real trade-off. All three, so most efforts produce none.
- **Brief**: generated per recipient at send time, never stored, never maintained.

The log carries unsettled questions too. A question the interview could not resolve becomes an `open` line, or an `assumed` one when the crew picked a default to keep moving. Both get reported at every gate, neither blocks one, and the next interview reads them back before its first round. Without that, a hard question asked in March dies with the spec that held it.

Everything else lives in `.capstan/effort/`, the one gitignored piece of `.capstan/`, and is deleted at delivery. A stale spec or an old research file is worse than none, because the next agent reads it as current.

The reason external documentation becomes unreadable is almost always that one artifact was made to serve two audiences with opposite needs. An internal record is dense and assumes context. A partner brief is short and assumes nothing. Do not maintain the second one. Regenerate it.

## Why the Architect creates worktrees by hand

Subagents support `isolation: worktree` in frontmatter. This crew deliberately does not use it.

That field resolves against the **session's** working directory rather than the repository the work lives in. A session rooted anywhere else fails outright with "not in a git repository", however correct the paths handed to the Builder are. Since one session often works across several repositories, that is the normal case rather than an edge case.

So the Architect runs `git -C <repo> worktree add ...` itself, hands each Builder an absolute path, and removes the worktree after the merge. Nothing ever changes directory, and the flow works from a session rooted anywhere, including somewhere with no repository at all.

The related trap: `.capstan/effort/` is gitignored, so an effort's spec, plan, and research do not exist inside any worktree. Builders get absolute paths into the main working copy for those. A Builder that cannot find its brief will invent one.
