---
capstan_type: glossary
---

# Context

The words this repository uses, defined once. This describes Capstan itself; it is not a template or a file the plugin reads from your project.

| Term | Means |
|---|---|
| Effort | One run of work from concept to delivery, holding one claim. Three in flight is the ceiling. |
| Gate | A point where the run *ends* and the operator decides. Three per effort. Never a pause. |
| Operator | The person at the gates. Never the crew, and never an agent. |
| Crew | The five roles: Architect, Scout, Builder, Reviewer, Courier. |
| Architect | Owns the interview, the spec, the slice graph, the decision log and the tracker. Your session, not a subagent. |
| Scout | Read-only reconnaissance. Returns cited findings and never decides. |
| Builder | Builds exactly one slice in its own worktree. Never reviews its own work. |
| Reviewer | Reviews one slice's diff without the Builder's reasoning. Reports, never fixes. |
| Courier | Packages a delivered effort, writes the knowledge-base note, which the operator commits. Never sends. |
| Knowledge-base note | The one permanent note per effort the Courier writes at delivery. Written by Capstan, committed by the operator. |
| Discipline | A skill the roles pull in, as opposed to a role itself. |
| Project | The work an Effort belongs to and outlives. One Project holds many Efforts, its own Document home, and, once built, its Tracker. |
| `capstan_type` | The frontmatter property naming which durable artifact a note is: `glossary`, `decision-log`, `decision-record` or `tracker`. Prefixed per the vault-wide typing rule. |
| `capstan-document-home` | The key in `<working copy>/CLAUDE.md` or `AGENTS.md` holding an absolute path to the Document home. Unset means the `effort` skill asks once, offering the default or Setup. |
| Document home | Where the glossary, the log, the records and the tracker live. Defaults to `.capstan/` in the repository; configurable to a vault so they render outside it. Never both. |
| Tracker | The surface holding slice state through to completion. Always present; the default is `tracker.md` in the Document home. |
| Setup | The `setup` skill. Configures where a Project's durable artifacts live, moves what is already there, and can be re-run. Operator-invoked, never part of an Effort. |
| Front door | A skill the operator invokes directly, rather than one the model reaches for. Two: `effort` starts a run, `setup` configures where its artifacts live. Neither is a Discipline. |
| Walkthrough | The one-time script that carries the operator through a manual procedure, stage by stage, capturing what comes back. Discarded with the effort's scratch once run. |
| Spike | Throwaway work that answers one question: whether something behaves right or feels right. Never merged. |
| Stage | One step of a Walkthrough, confirmed with the operator before it is authored. Counted in `TOTAL_STAGES`. |
| Namespace | The `capstan:` prefix a plugin install puts on every skill and agent. Absent under a manual install. |
| `.capstan/` | The folder holding the artifacts Capstan writes for itself: `CONTEXT.md`, `decisions.md`, `decisions/`, `tracker.md`, and the effort scratch at `effort/`. Distinct from the namespace above, which is a prefix rather than a folder. |
| Slice | A change that can be demonstrated on its own once it is done. |
| Layer | A horizontal cut that nothing can demonstrate until other cuts land. What a slice must never be. |
| Owns | The files one slice, and only that slice, touches. Every file the change touches is owned by exactly one slice, so nothing is left for no slice to fix and no two Builders collide. |
| Demonstrated | What a reader or user can observe once a slice is done. A slice with no answer is a Layer. |
| Seam | The test boundary agreed in the plan before the build, so a Builder never picks its own. |
| Red at base | The evidence a slice's seam check failed before that slice started. Without it a criterion can pass by having always been true. |
| Blocked by | The slices that must land before this one can be built or verified. An edge that only feels tidier is not one. |
| Frontier | Every decision whose prerequisites are already settled: the questions askable now. |
| Claim | `.capstan/effort/CLAIM.md`. Marks an effort as held, so a second Architect stops rather than starting. |
| Verify | Running the checks the repository declares against the merged result, and reporting what they showed. Never an exit code alone. |
| Axis | One of the two independent review questions: Standards (built right) and Spec (right thing). Never blended. |
| Fixed point | The commit, branch or tag a review diffs against. Supplied by whoever dispatches, never guessed. |
| Fix dispatch | A Builder task sent back on a slice already built once, whether the finding came from a slice review or a verify return. What the fix-dispatch count counts, rather than review returns filed. |
| Live slice | A slice that can still receive a Fix dispatch: every status but `dropped`, while the effort is open. A merged slice stays live, because a verify return reopens it, and its count resumes rather than restarting. |
| Open | A log status. Raised and unsettled, with no default in force. |
| Assumed | A log status. Defaulted so work could proceed, carrying the condition that would reopen it. |
| Unformed | A log status. An area known to be unexplored, where the question itself cannot be phrased yet. Graduates into `Open` rather than being answered. |
