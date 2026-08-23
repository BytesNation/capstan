# Context

The words this repository uses, defined once. This describes Capstan itself; it is not a template or a file the plugin reads from your project.

| Term | Means |
|---|---|
| Effort | One run of work from concept to delivery, holding one claim. Three in flight is the ceiling. |
| Gate | A point where the run *ends* and the operator decides. Three per effort. Never a pause. |
| Operator | The person at the gates. Never the crew, and never an agent. |
| Crew | The five roles: Architect, Scout, Builder, Reviewer, Courier. |
| Architect | Owns the interview, the spec, the slice graph and the decision log. Your session, not a subagent. |
| Scout | Read-only reconnaissance. Returns cited findings and never decides. |
| Builder | Builds exactly one slice in its own worktree. Never reviews its own work. |
| Reviewer | Reviews one slice's diff without the Builder's reasoning. Reports, never fixes. |
| Courier | Packages a delivered effort, writes the knowledge-base note, commits it. Never sends. |
| Discipline | A skill the roles pull in, as opposed to a role itself. |
| Project | The work an Effort belongs to and outlives. One Project holds many Efforts, its own Document home, and, once built, its Tracker. |
| `capstan_type` | The frontmatter property naming which durable artifact a note is: `glossary`, `decision-log` or `decision-record`. Prefixed per the vault-wide typing rule. |
| `capstan-document-home` | The key in `<working copy>/CLAUDE.md` or `AGENTS.md` holding an absolute path to the Document home. Unset means the default. |
| Document home | Where the glossary, the log and the records live. Defaults to `.capstan/` in the repository; configurable to a vault so they render outside it. Never both. |
| Tracker | A surface holding slice and seam state through to completion, authoritative when configured. A separate feature from the Document home, and not yet built. |
| Front door | The `effort` skill, invoked by the operator to start a run. Neither a Discipline nor an Effort. |
| Walkthrough | The one-time script that carries the operator through a manual procedure, stage by stage, capturing what comes back. Discarded with the effort's scratch once run. |
| Spike | Throwaway work that answers one question: whether something behaves right or feels right. Never merged. |
| Stage | One step of a Walkthrough, confirmed with the operator before it is authored. Counted in `TOTAL_STAGES`. |
| Namespace | The `capstan:` prefix a plugin install puts on every skill and agent. Absent under a manual install. |
| `.capstan/` | The folder holding the artifacts Capstan writes for itself: `CONTEXT.md`, `decisions.md`, `decisions/`, and the effort scratch at `effort/`. Distinct from the namespace above, which is a prefix rather than a folder. |
| Slice | A change that can be demonstrated on its own once it is done. |
| Layer | A horizontal cut that nothing can demonstrate until other cuts land. What a slice must never be. |
| Seam | The test boundary agreed in the spec before the build, so a Builder never picks its own. |
| Frontier | Every decision whose prerequisites are already settled: the questions askable now. |
| Claim | `.capstan/effort/CLAIM.md`. Marks an effort as held, so a second Architect stops rather than starting. |
| Verify | Running the checks the repository declares against the merged result, and reporting what they showed. Never an exit code alone. |
| Axis | One of the two independent review questions: Standards (built right) and Spec (right thing). Never blended. |
| Fixed point | The commit, branch or tag a review diffs against. Supplied by whoever dispatches, never guessed. |
| Open | A log status. Raised and unsettled, with no default in force. |
| Assumed | A log status. Defaulted so work could proceed, carrying the condition that would reopen it. |
| Unformed | A log status. An area known to be unexplored, where the question itself cannot be phrased yet. Graduates into `Open` rather than being answered. |
