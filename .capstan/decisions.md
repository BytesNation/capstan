# Decisions

| # | Date | Decision | Status |
|---|------|----------|--------|
| 146 | 2026-08-21 | `[redacted]` maps BytesNation to `[redacted]` and appends sub-ventures (`[redacted]`), which contradicts 119 and would produce `[redacted]/capstan`. That file states it wins over an agent prompt. The exception is documented nowhere | open |
| 145 | 2026-08-21 | The vault's `AGENTS.md` rule 7 forbids automatic commits; decision 117 makes committing the Courier's job and phase 4 depends on that commit existing. The Courier is sent to `AGENTS.md` for the schema, so it reads rule 7 on the way past, and nothing says which wins | open |
| 144 | 2026-08-21 | The five pre-existing notes carrying `[redacted]` are the operator's call, not this effort's. They predate it and mass-editing committed vault notes is not a delivery step | accepted |
| 143 | 2026-08-21 | Review caught the frontmatter defect only by running the knowledge base's own validator. Reading frontmatter and finding it plausible is what failed five times; the check that worked was executing the repository's tooling | accepted |
| 142 | 2026-08-21 | `[redacted]` is wrong for a note under `[redacted]/`. The vault's `[redacted]` makes the Efforts folder the lifecycle authority and `[redacted]` errors on anything but `[redacted]` there. Corrected by a second commit, per 127 | accepted |
| 141 | 2026-08-21 | Supersedes 138. The close-out's derived-versus-copied statement goes to the Architect and the operator, never into the Reviewer's dispatch. It is the Courier's reasoning, and a Reviewer holding the writer's reasoning is the bias the separation exists to prevent. What the Reviewer gets is the standard, `agents/courier.md`, not the account of how it was applied | accepted |
| 140 | 2026-08-21 | An acceptance criterion counting `grep -c` results is counting lines, not occurrences. Four criteria in this effort were defective, all mine; the Builder that refused to pad prose to satisfy a wrong number did the right thing | accepted |
| 139 | 2026-08-21 | `two-axis-review` says to grade against a writing skill without applying it. `unslop`'s stated job is to rewrite text, and a Reviewer that loads it while forbidden to fix anything is being handed a contradiction the file resolves only implicitly | accepted |
| 138 | 2026-08-21 | The Courier's close-out states which frontmatter values it derived and which it copied. The tested Courier volunteered exactly this; a behaviour the review depends on is required rather than volunteered | superseded by 141 |
| 137 | 2026-08-21 | Phase 4 hands the Reviewer `agents/courier.md` as the note's standard, alongside the spec and the decision log. A standard is not the Builder's reasoning, so independence holds | accepted |
| 136 | 2026-08-21 | Found by running it, with every static check green: the review would have re-introduced the tag bug. The Reviewer graded the derived tag as a blocking defect and would have sent the Courier back to copy the organisation's, because the copied-versus-derived rule lives only in `agents/courier.md`, which no Reviewer reads | accepted |
| 135 | 2026-08-21 | A change to Capstan cannot be verified by dispatching Capstan's own agents. `capstan:courier` and the rest resolve from the installed plugin cache, not the working copy, so a live test in the same session runs the previous release. Test the changed prose by handing it to a generic agent instead | accepted |
| 134 | 2026-08-21 | "Knowledge base" gets no glossary row. It is ordinary English naming a setup-specific location, on the same reasoning as "project" | accepted |
| 133 | 2026-08-21 | Phase 4's delete step carries the rationale that binds how exhaustive the delete must be, not the history of which role used to own it. A stale spec is read as current by the next agent; that changes behaviour, and where the step moved from does not | accepted |
| 132 | 2026-08-21 | Naming a writing standard is not enough: the discipline tells the Reviewer to invoke the skill and grade against its body. `writing-for-agents` describes itself as for creating or editing, so nothing in a review fires that pointer and the agent-side standard would silently go ungraded | accepted |
| 131 | 2026-08-21 | The Courier reports the commit SHA and the paths that commit touched, observed with `git log --name-only -1`. "Report the commit" is not observable, and a fixed point that cannot be resolved is not one | accepted |
| 130 | 2026-08-21 | Phase 4 gains a fifth act: report to the operator what review found. Spec behaviour 6 landed in no slice because the plan listed four acts against the spec's six. A plan omission, mine | accepted |
| 129 | 2026-08-21 | `two-axis-review` names two forms of fixed point plus a case where there is none, rather than three forms one of which is an absence. A defined term does not widen to admit its own absence | accepted |
| 128 | 2026-08-21 | `Fixed point` keeps its existing definition and stops being stretched. The Courier reports a commit; the fixed point is that commit's parent and the term stays with the review. Acceptance criterion 4 tested for a term my own spec misused, so it is replaced by one testing the positive staging form | accepted |
| 127 | 2026-08-21 | A blocking finding on a note already committed is corrected by a second commit. Never `--amend` in a repository the operator owns and may already have pushed | accepted |
| 126 | 2026-08-21 | `two-axis-review` names the writing standard instead of the Reviewer's frontmatter granting it: `unslop` for prose a person reads, `writing-for-agents` for prose an agent consumes. The Reviewer holds the Skill tool and invokes whichever applies, so code review is untouched | accepted |
| 125 | 2026-08-21 | Version goes to 2.3.0. A new step in phase 4 and a new tool grant are behaviour rather than a typo | accepted |
| 124 | 2026-08-21 | A knowledge base that is not a git repository degrades rather than skips. The Reviewer reads the note by absolute path and reports that no fixed point was available. Skipping would ship a feature that only works where the knowledge base happens to be versioned | accepted |
| 123 | 2026-08-21 | The Standards axis grades the note's schema and its prose, conditional on the Courier being granted `unslop` in the same change. Grading prose against a rule the writer never received is acceptance criteria testing for something the spec never supplied | accepted |
| 122 | 2026-08-21 | `two-axis-review` is extended rather than joined by an eleventh discipline. Its fixed-point section names one repository and one command form, so it changes either way, and the axes map onto a note without strain | accepted |
| 121 | 2026-08-21 | Teardown moves from the Courier to the Architect in phase 4. The Courier holds no Task tool so it cannot dispatch its own Reviewer, and its step 4 deleted the spec the Spec axis grades against. The Courier becomes three steps | accepted |
| 120 | 2026-08-21 | Rows 21 and 20 move to their sorted position. They sat above 114 at the top of the file, so the newest-first reading order broke at the first two lines a reader sees | accepted |
| 119 | 2026-08-21 | Supersedes 113. An `effort/*` tag names the project, not the individual effort. Confirmed on a second folder: `[redacted]/[redacted]/` holds [redacted], every one carrying the parent tag | accepted |
| 118 | 2026-08-21 | The note review stays in phase 4 and adds no fourth gate. The Architect actions the findings and reports them in the close-out; a blocking finding goes back as a fix task on the same note | accepted |
| 117 | 2026-08-21 | The Courier commits the note to the knowledge base as one commit touching one path, and reports the commit as the fixed point. A knowledge base with unrelated work in its tree is the normal case, so the commit is never staged with `git add -A` | accepted |
| 116 | 2026-08-21 | A Reviewer reviews the note, not the Architect. The Architect wrote the spec the note summarises, so it holds the Courier's context by construction, which is the bias the separation exists to block | accepted |
| 115 | 2026-08-21 | Only the knowledge-base note is reviewed. The package reports verification already performed, the operator reads every brief before sending, and teardown removes what is not allowed to survive. The note is the only Courier output that is permanent and read by nobody when it is written | accepted |
| 114 | 2026-08-21 | "Project" in the Courier is ordinary English rather than Capstan vocabulary and gets no glossary row, on the same reasoning as "operating layer" | assumed |
| 113 | 2026-08-21 | An `effort/*` tag names the project, not the individual effort. Counted: [redacted] on the three commonest, against one each on the two I first cited as the convention. My diagnosis was wrong; the Courier filed a project under its parent organisation | superseded by 119 |
| 112 | 2026-08-21 | The Courier distinguishes copied frontmatter fields from derived ones, keyed on whether the value is a property of the folder or a fact about this effort. Not on counting neighbours: a folder is uniform until the moment the rule has to fire | accepted |
| 111 | 2026-08-21 | "Two skills are more than one file" becomes three. `walkthrough/SKILL.md` points at two siblings, so lifting it alone leaves the dangling pointers that section exists to warn about | accepted |
| 110 | 2026-08-21 | "Operating layer" lives in `DESIGN.md` only, where the paragraph around it defines it. No glossary row: a term used once, in the place it is explained, is not vocabulary | accepted |
| 109 | 2026-08-21 | The first screen keeps a concrete positive claim. Forty-five words of negation would fit any repository; "plain markdown" fits this one and a stranger can check it in two seconds | accepted |
| 108 | 2026-08-21 | The licence section counts three vendored skills. The slice made "Nothing else here is vendored" false while line 7 of the same file called `walkthrough` vendored, a contradiction inside one commit | accepted |
| 107 | 2026-08-21 | Two of my own acceptance criteria were wrong again. Criterion 3 demanded `CREDIT.md` state nothing changed when it correctly records one; criterion 7 was looser than decision 88 and graded a lost requirement green | accepted |
| 106 | 2026-08-21 | A spike flips its line to `accepted`, not `assumed`. An `assumed` line is re-raised in the next interview's first round, which is the silent return this discipline exists to stop | accepted |
| 105 | 2026-08-21 | A spike names its branch in the decision line it settled. The rewrite fixed which line the answer goes into and dropped what that line has to carry | accepted |
| 104 | 2026-08-21 | A walkthrough's confirm prompt prints the target the script actually resolves rather than a hand-typed literal. Asserting at authoring time what resolves at run time is a false assurance, which is worse than saying nothing | accepted |
| 103 | 2026-08-21 | A walkthrough's confirm is a construction, not a call. `if confirm ...; then ... fi`. Reproduced: a bare call under `set -e` exits the run on a decline, before the summary, leaving written values unrecorded | accepted |
| 102 | 2026-08-21 | `AUDIT.md` is Capstan-authored, not vendored, and my claim otherwise was wrong. The em dash is not graded. If zero em dashes is the rule for agent-facing prose it gets written into `writing-for-agents` rather than enforced case by case | accepted |
| 101 | 2026-08-21 | `.capstan/CONTEXT.md` gains a `Stage` row. It is the unit a walkthrough is built from, appears twelve times, and carries its own rules. `Route` is not added: with 100 in force the collision disappears | accepted |
| 100 | 2026-08-21 | "Route" is reserved for `interview`'s three stall exits. `spike` says path. My own spec used "three routes for a UI" against my own criterion 9 and is corrected | accepted |
| 99 | 2026-08-21 | No committed `scripts/` path for a walkthrough. One that persists is an operating layer, which 86 says Capstan does not have. The line was inherited from upstream rather than derived from Capstan's position | accepted |
| 98 | 2026-08-21 | Spike branches are `spike/<slug>`, outside the effort namespace so the Architect's merge loop cannot pick one up, and pushed and never deleted so the reference survives a fresh clone | accepted |
| 97 | 2026-08-21 | A spike writes its answer into the `open` line the stall route already created, flipping its status. Appending a second line leaves the first open forever and the next interview re-asks a question already answered | accepted |
| 96 | 2026-08-21 | The agent never runs a walkthrough it authored. With stdin not a tty every prompt returns empty, an empty secret overwrites a real one, and the script still prints success and exits zero | accepted |
| 95 | 2026-08-21 | A walkthrough stage that writes outside the local `.env`, or that cannot be undone, is gated by `confirm` and names its target first. The Authority table reserves third-party writes for the operator, every time | accepted |
| 94 | 2026-08-21 | Shipped skills never cite decision numbers. `skills/` is the plugin payload and `.capstan/decisions.md` lives in the user's repository, so a number points at whatever line they happen to have | accepted |
| 93 | 2026-08-21 | `spike` is named inside `interview`'s existing stall route rather than replacing it. The route already asks who builds the throwaway; it gains a name and a discipline | assumed |
| 92 | 2026-08-21 | Both new skills are model-invoked, like every other discipline. Only `effort` is a front door | assumed |
| 91 | 2026-08-21 | `effort`'s human-task-step section becomes a pointer to `walkthrough`. Four paragraphs for a branch most runs never take | accepted |
| 90 | 2026-08-21 | Version 2.2.0. Two disciplines added, nothing moved, nothing broken | accepted |
| 89 | 2026-08-21 | `spike` keeps two branches, recast by the question rather than the technology: does it behave right, does it feel right. Capstan runs efforts on documents and infrastructure, not only code | accepted |
| 88 | 2026-08-21 | Throwaway code lives on a branch that is never merged, named in the decision line it settled. The answer persists in the log; the code persists only as a reference | accepted |
| 87 | 2026-08-21 | No sixth role. A Builder carries a spike with a different definition of done. A role is a permanent widening of the crew for something that runs occasionally | accepted |
| 86 | 2026-08-21 | Supersedes 83. "No scripts" is qualified rather than dropped. The rule Capstan actually holds is no operating layer: nothing that must be maintained to keep the workflow alive | accepted |
| 85 | 2026-08-21 | `template.sh` is vendored with `CREDIT.md` and `LICENSE`, per the `writing-for-agents` precedent. See [0002](decisions/0002-vendor-the-walkthrough-library.md) | accepted |
| 84 | 2026-08-21 | The two disciplines are `walkthrough` and `spike`. Nautical names were considered and rejected: `sounding` is apt and nobody would know what it meant | accepted |
| 83 | 2026-08-21 | Whether "Plain markdown. No scripts, no schemas, no hooks, no scheduler" reads as a reason to choose Capstan or as an implementation note | superseded by 86 |
| 82 | 2026-08-21 | The Architect's does-not-move-delete-or-commit guarantee is restored explicitly. It thinned one word per round across three rounds without anyone deciding to drop it, and the commit half had no carrier left | accepted |
| 81 | 2026-08-21 | The first screen says the disciplines run through to delivery, not through to the review. Review stopped one phase short of the headline two lines above it, and of the Courier named in the same sentence | accepted |
| 80 | 2026-08-21 | `DESIGN.md` is verbatim with two recorded exceptions: the disciplines lead line, which carries both the count fix per 75 and the preload correction, and one blank line at the seam where two sections became neighbours for the first time | accepted |
| 79 | 2026-08-21 | The no-scripts line sits below the counts rather than above them. It lands harder once the reader knows what there is to have no scripts for | accepted |
| 78 | 2026-08-21 | The spec and plan are corrected rather than the deliverable. Six spec lines and two criteria went stale as decisions 73 to 77 landed mid-build, and criterion 4 was grading correct work as wrong | accepted |
| 77 | 2026-08-21 | The unverified-sequence hedge returns, scoped to the 2.1.0 file move, which has not been run. The 2.0.0 uninstall and reinstall was verified live at that effort's delivery, so the old blanket hedge was stale | accepted |
| 76 | 2026-08-21 | "Plain markdown. No scripts, no schemas, no hooks, no scheduler" returns to the first screen. It is the only sentence giving a stranger a reason to choose this, and decision 67's "four things" governed structure rather than withholding the reason | accepted |
| 75 | 2026-08-21 | `effort` is not a discipline. Both tables read eight disciplines plus the front door, and `CONTEXT.md` gains a row for the operator-invoked front door that is neither a Discipline nor an Effort | accepted |
| 74 | 2026-08-21 | The headline names the platform. Decision 65's own wording carried "Claude" and my sentence dropped it, so the platform first appeared inside a shell command | accepted |
| 73 | 2026-08-21 | "Five roles", not "five agents". `agents/` holds four files and the Architect is the operator's session. A spec defect of mine, implemented faithfully and tested for by criterion 4 | accepted |
| 72 | 2026-08-21 | No version bump. Documentation only, and the README people read is the one on GitHub rather than the copy in their plugin cache | accepted |
| 71 | 2026-08-21 | No competitor is named. Position by what Capstan does; naming one invites a comparison we do not control and ages the moment either project moves | accepted |
| 70 | 2026-08-21 | `Known limits` and `Configure` stay in the README, below the fold. Limits are a buying signal rather than a caveat, and configuration belongs beside the install | accepted |
| 69 | 2026-08-21 | Decisions 8, 13, 19, 26 and 64 were put to the operator twice and went unanswered twice. Defaulted rather than asked a third time, per the interview's stall route | accepted |
| 68 | 2026-08-21 | The `Upgrading` section stays, compressed and below the fold. Two efforts made it correct and deleting it strands everyone on 1.x and 2.0 | accepted |
| 67 | 2026-08-21 | Install lands in the first screen. What it is, what you get, how to install, then depth | accepted |
| 66 | 2026-08-21 | The design material moves to `DESIGN.md`, linked once. Too good to delete, too long for a page whose job is getting someone to install | accepted |
| 65 | 2026-08-21 | The README is written for someone choosing a full Claude skills and agent environment for taking work from concept to delivery. Deciding, not operating | accepted |
| 64 | 2026-08-21 | The three italic bullet leads become bold, matching the repository's 39 others. The revisit condition on this line fired: this is the README effort | accepted |
| 63 | 2026-08-21 | `.effort/` is deleted from this working copy at delivery. Nothing else deletes it, and left in place it fires the trigger built in this effort and stops the next one | accepted |
| 62 | 2026-08-21 | `.effort/` is never moved. The operator deletes it. Moving it would put a stale `CLAIM.md` where the next run reads a live one | accepted |
| 61 | 2026-08-21 | The step reads the recorded `assumed` line before asking. A line written to stop a question recurring has to be read by the thing that asks it | accepted |
| 60 | 2026-08-21 | Any path confirmed as Capstan's stops the run. Mixed answers resolve to stop rather than to nothing | accepted |
| 59 | 2026-08-21 | The claim check runs before the provenance question. A claim is a fact about the repository, not an opinion the operator supplies, and asking first lets a "not ours" answer step past live work | accepted |
| 58 | 2026-08-21 | The Architect detects a pre-2.1.0 layout and **stops**. The operator moves the files. Supersedes 36, 43, 46, 49, 51, 54 and 57, and deletes `MIGRATION.md`. Seven review rounds on a procedure the crew was going to run against a user's files is the signal the README already names: simplify rather than keep it alive | accepted |
| 57 | 2026-08-21 | Not-Capstan's and Capstan's-but-declined are different answers. The first proceeds normally, the second stops the run per 47. Folding the two asks into one confirmation had merged them | superseded by 58 |
| 56 | 2026-08-21 | The `Claim` glossary row is not widened for the pre-2.1.0 path. Settled: `CONTEXT.md` describes the current convention, and `MIGRATION.md` is deletable once served. Raised five times; recorded so it stops recurring | accepted |
| 55 | 2026-08-21 | A trigger firing on a repository that is not Capstan's is recorded as an `assumed` line, so it does not ask again on every later effort | accepted |
| 54 | 2026-08-21 | Deleting `.effort/` is gated on the same per-path confirmation as the move and named in what the operator approves. The Authority table puts deletes with the operator every time | superseded by 58 |
| 53 | 2026-08-21 | Nothing confirmed means the migration returns control and the run proceeds normally. The trigger is a candidate signal, not proof | accepted |
| 52 | 2026-08-21 | Scope widened: the README's upgrade note is corrected. Its premise that the reader has a root `.effort/` is false for any repository that has delivered an effort | accepted |
| 51 | 2026-08-21 | `.effort/` is deleted before the migration commit, not after, so it is never both unignored and untracked while something is staged | superseded by 58 |
| 50 | 2026-08-21 | Taking over a pre-2.1.0 claim is not supported. Finish or abandon that effort under 2.0.0, or delete `.effort/` and start fresh | accepted |
| 49 | 2026-08-21 | Provenance is confirmed with the operator before any path moves. This is what makes broad detection safe, and it closes a guard that covered the trigger but never the move | superseded by 58 |
| 48 | 2026-08-21 | Supersedes 33. Detection triggers on any root artifact, not on `.effort/`. That directory was never tracked and the Courier deletes it at delivery, so a delivered or freshly cloned 2.0.0 repository has none and the migration would never have fired | accepted |
| 47 | 2026-08-21 | Supersedes 45. Declining the migration ends the run. There is no decline mode, because honouring one means every phase file and skill consults a flag, which is the dual-read fallback decision 32 refused | accepted |
| 46 | 2026-08-21 | The operator deletes `.effort/` as the last step of migration. Nothing else does, so leaving it makes the trigger fire on every later effort | superseded by 58 |
| 45 | 2026-08-21 | A declined migration is recorded in `CLAIM.md`, which survives the run boundary, and governs reads and writes for all three paths. "For the rest of this run" expires at a gate; an effort spans four | superseded by 47 |
| 44 | 2026-08-21 | The migration pointer sits between the claim check and the claim write. One reorder closes three findings at once | accepted |
| 43 | 2026-08-21 | The migration lives in `skills/effort/MIGRATION.md` behind a pointer, not inline in `Before you start`. It is a branch most runs never take, and when it has served its purpose it can be deleted whole rather than unpicked | superseded by 58 |
| 42 | 2026-08-21 | Drop "live claim" as a term. A claim exists or it does not, matching the wording already in the file | accepted |
| 41 | 2026-08-21 | The claim check has one home. The existing step absorbs the old-path case rather than a second rule sitting above it | accepted |
| 40 | 2026-08-21 | The migration confirms each of the three paths rather than assuming all three are Capstan's. A repository can hold `.effort/` and an unrelated `decisions.md` | accepted |
| 39 | 2026-08-21 | `CONTEXT.md` gains a `.capstan/` row. The word was doing two jobs, the folder and the `capstan:` namespace prefix, which the interview skill says to challenge | accepted |
| 38 | 2026-08-21 | The `.gitignore` rewrite for an upgrading repository belongs to slice 2's detection step. A gap in the plan, found in review, that would have shipped as unignored scratch | accepted |
| 37 | 2026-08-21 | No marker file inside `.capstan/`. `CONTEXT.md` sits there and introduces the vocabulary better than a README nobody updates | accepted |
| 36 | 2026-08-21 | The migration lands as its own commit at the moment of the move, never folded into a slice commit | superseded by 58 |
| 35 | 2026-08-21 | Version 2.1.0. Nothing a user types changes; only the on-disk layout of their artifacts, and the Architect moves it | accepted |
| 34 | 2026-08-21 | Detection checks for a live `CLAIM.md` before moving anything, and reports rather than relocating a running effort | accepted |
| 33 | 2026-08-21 | The Architect detects a pre-migration layout and offers to move it. Prose in a skill, not a script, and not release notes nobody reads | superseded by 48 |
| 32 | 2026-08-21 | Hard cut. The skills read the new paths only. No dual-read fallback, because it would never be removed | accepted |
| 31 | 2026-08-21 | `.effort/` becomes `.capstan/effort/`. The word stays, since `Effort` is a defined term in `CONTEXT.md` | accepted |
| 30 | 2026-08-21 | The README rewrite is a separate effort, sequenced after the path migration. Mixing them hides which change broke what | accepted |
| 29 | 2026-08-21 | Capstan's own repo follows the same convention. Its root `CONTEXT.md`, `decisions.md` and `decisions/` move too | accepted |
| 28 | 2026-08-21 | `.capstan/` is committed. Only `.capstan/effort/` is gitignored. A blanket ignore would stop decisions entering git and contradict the thesis | accepted |
| 27 | 2026-08-21 | Every artifact Capstan writes lives under `.capstan/` in the working copy. The repo root stays the user's, and `CONTEXT.md` stops colliding with the same filename in other plugins | accepted |
| 26 | 2026-08-21 | `Upgrading` documents the orphan-on-refresh in one clause. Defaulted after two unanswered rounds; revisit if the section should stay shorter | assumed |
| 25 | 2026-08-21 | `plugin.json` holds the canonical description. `marketplace.json` and the README copy it, and the next editor changes all three | accepted |
| 24 | 2026-08-21 | The `Namespace` row in `CONTEXT.md` is forward-looking rather than a retrofit against decision 4, because the prefix itself resolved in this effort | accepted |
| 23 | 2026-08-21 | Scope widened again: `Known limits` says `/capstan:effort`, and the manual-install section gets its own start line | accepted |
| 22 | 2026-08-21 | Supersedes 21. The manifest description stays as agreed, but the README keeps a subtitle that names what Capstan is. A gallery card has a category and an install button for context; a README has neither | accepted |
| 21 | 2026-08-21 | Scope widened two lines: README line 98's `/effort` becomes `/capstan:effort`, and the line 3 tagline adopts the new description | superseded by 22 |
| 20 | 2026-08-21 | Both descriptions carry identical text. The longer gallery variant is dropped: "stops for your approval at three points along the way" contradicts `CONTEXT.md`, which defines a Gate as never a pause | accepted |
| 19 | 2026-08-21 | Dropped "and waits for your go" from the description. It duplicated the closing line. Revisit if the approved wording is wanted verbatim | assumed |
| 18 | 2026-08-21 | The description is plain language. No role names, no internal vocabulary | accepted |
| 17 | 2026-08-21 | `displayName` is "Capstan" with no descriptive tail | accepted |
| 16 | 2026-08-21 | Version goes to 2.0.0. The skill namespace is the public interface and it breaks | accepted |
| 15 | 2026-08-21 | The GitHub repo renames to `BytesNation/capstan`. The marketplace id stays `bytesnation` | accepted |
| 14 | 2026-08-21 | Rename to `capstan`. Both the skill namespace and the install identifier change. See [0001](decisions/0001-rename-to-capstan.md) | accepted |
| 13 | 2026-08-21 | The in-session equivalent of `claude plugin update <plugin>@<marketplace>`. Not verified; the CLI form is documented instead | open |
| 12 | 2026-08-21 | The `Upgrading` section documents the full two-step sequence. Refreshing the marketplace alone does not install a new version | accepted |
| 11 | 2026-08-21 | The `Upgrading` section documents both refresh forms, in-session and CLI, since `## Install` is written for the CLI | accepted |
| 10 | 2026-08-21 | No release tags while the core is still moving. Revisit when someone needs to pin a version, or when the marketplace entry stops tracking the default branch | accepted |
| 9 | 2026-08-21 | Scope widened by one line: the `claude plugin update` mention in `## Install` is reconciled with the new `Upgrading` section | accepted |
| 8 | 2026-08-21 | The README recommends leaving auto-update off rather than presenting both paths neutrally. Revisit if steering the reader is unwanted | assumed |
| 7 | 2026-08-21 | The version bump ships inside this effort, not as a separate release commit | accepted |
| 6 | 2026-08-21 | Both update paths are documented: marketplace auto-update, and the manual `/plugin marketplace update` | accepted |
| 5 | 2026-08-21 | The README `Upgrading` section is rewritten to cover the marketplace install, not only the manual copy | accepted |
| 4 | 2026-08-21 | `CONTEXT.md` is created forward only, from the next term that resolves. Never retrofitted from existing code | accepted |
| 3 | 2026-08-21 | The upgrade explanation lives in the README `Upgrading` section. No `CHANGELOG.md` | accepted |
| 2 | 2026-08-21 | Updating installs need no migration step. The new files appear on their own | accepted |
| 1 | 2026-08-21 | Plugin version goes to 1.1.0 for the glossary and log-status change | accepted |
