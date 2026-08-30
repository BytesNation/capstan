---
name: setup
description: Configure where a project's durable artifacts live, in this repository or in a folder outside it, move what is already there, and change the answer later.
disable-model-invocation: true
argument-hint: "absolute path to the repository (defaults to the current one)"
---

# Setup

This configures the **document home**: the one root Capstan resolves every path to its own durable artifacts against, the glossary, the decision log, the decision records and the tracker. The default is `<working copy>/.capstan/`, and unset means nothing has chosen yet.

It also configures the **tracker surface**: whether slice state stays in the document home as `tracker.md`, or moves to a GitHub Projects v2 board instead. The two are separate questions asked separately below; the default document home and the default tracker are each reachable without reading about the other.

The operator types `setup` to run this. Nothing else reaches for it on its own reading of a sentence. Relocating someone's decision log on a guess is worse than the operator typing one command.

It is safe to run more than once. See **Re-running** at the end.

## Precondition: establish the working copy

Take the absolute path from the argument the operator typed after `setup`. If they typed none, use the session's own working directory. Either way, confirm it is a repository:

```bash
git -C <abs-path> rev-parse --show-toplevel
```

Everything below refers to that path. It is not necessarily the session's working directory when an argument was given, and it must never be assumed to be. Address every file by absolute path, `git -C <path>` included, and the session's own location stops mattering.

## The ask

Before asking anything, read `capstan-document-home` from `<working copy>/CLAUDE.md` and `<working copy>/AGENTS.md`, both addressed by absolute path against the working copy above. The key is a bare line, `capstan-document-home: <value>`, never frontmatter: reading it means finding that line, not parsing YAML. A file that does not exist and a file that exists but carries no such line reach the same result everywhere below: no value found there.

Reject three shapes rather than resolve past them, in either file: the key appearing twice in one file, an empty value, and a value that is neither the literal `default` nor itself an absolute path (resolving a relative one would mean assuming the session's own directory, exactly what the Precondition above forbids). Each ends the run: report what was found and ask the operator to fix the file by hand before running this again. A file already carrying two contradictory lines is not made safe by guessing which one to keep.

Strip any trailing slash from a value found before comparing it to anything else; `<working copy>/.capstan` and `<working copy>/.capstan/` name the same path. Call whatever this settles to **the home currently in force**: `<working copy>/.capstan` when neither file carries the key or the value found is the literal `default`, or the absolute path found otherwise. A value of `default` still counts as "a key was found" everywhere below that distinction matters; it only collapses to the same path as the absent case, not to the same history.

Report the home currently in force before asking anything else, always under the same word, "Currently:". If the two files carry the key with different values, there is no single value to put there; report both under it instead, "Currently: `CLAUDE.md` says `<value>`. `AGENTS.md` says `<value>`.", and ask which one is correct before anything else. The answer becomes the home currently in force, and step 4 removes the key from the file that lost, without asking again which file that is. Otherwise, "Currently: `<value>`." carries the single value, whether a file carries the key or not: an operator who has never run this before sees the default stated as plainly as one changing an existing answer does. Then continue below regardless, since changing an existing answer runs the same procedure as setting it the first time.

Check too, in the same breath, whether the home currently in force exists on disk right now, before step 1 gets the chance to create the confirmed path and erase the signal. If it does not and a key was found for it in either file, say so plainly: it held something once and that is gone now. If it does not and no key was found anywhere, there is nothing recorded to say it ever held anything; the "Currently:" line above already covers it, and nothing more is added here. This is a fact about the home in force itself, true regardless of which path gets confirmed below or which branch the run takes from there, so it is said once, here, rather than inside whichever branch happens to notice it later.

The layout ask below is two steps, never a three-way menu: someone who wants the default should not read two paragraphs about vault layouts to get there. Step 4 can ask a further question per key, which file it lives in, whenever both `CLAUDE.md` and `AGENTS.md` exist and nothing above already settled it for that key; a disagreement already resolved above does not ask again, and either way that is a separate ask that does not turn this one into three.

**First, the fork.** Ask where the glossary, the decision log, the decision records and the tracker should live:

- In the repository, at `.capstan/`. Where they already sit if nothing has been configured elsewhere.
- In a folder outside the repository, such as an Obsidian vault.

**Second, only on "outside."** Describe the two layouts the operator can choose between, one line each, then ask for an absolute path. Describe them; do not coin a short name for either, because Capstan stores neither choice and a coined name would be vocabulary for a distinction nothing persists:

- One vault per project, where the absolute path is that vault's own root.
- One folder per project in a shared vault, where the absolute path is this project's own folder inside it.

Both resolve to the same thing from here on, an absolute path configured away from the default. The description above exists to help a person choose; nothing below branches on which one they picked.

## The tracker-surface ask

A second ask, kept apart from the fork above rather than folded into it: someone who wants the default tracker should never have to read a sentence about GitHub to get there, and the reverse holds too, the two are asked separately because they answer separately.

Before asking, read `capstan-tracker` from `<working copy>/CLAUDE.md` and `<working copy>/AGENTS.md`, both by absolute path, under the same bare-line rule as `capstan-document-home` above: a bare `capstan-tracker: <value>` line, never frontmatter. Reject the key appearing twice in one file and an empty value, the same way and for the same reason as above; each ends the run, reported so the operator can fix the file by hand. Report the value currently in force before asking anything else, under "Currently:" as above: "`tracker.md` in the document home." when unset, the value itself when one file carries it, or the two-file disagreement, worded the same way as above, when they differ, asking which is correct before anything else and treating that answer as the value in force from here on.

Ask where slice state should live:

- **The default.** `tracker.md` in the document home, unchanged from every project today.
- **GitHub.** A Projects v2 board on the working copy's own remote.

**On the default.** When nothing is currently recorded, there is nothing to write: step 4 below writes no `capstan-tracker` line, because an unset key already means `tracker.md`. When a `capstan-tracker` line already exists from an earlier run and the operator is choosing the default back, step 4 removes it instead: a line spelling out the default would be a second way of saying what its own absence already says.

**On GitHub.** If the project already has a `tracker.md`, say plainly that choosing GitHub carries every row it holds onto the board and then deletes the file, under **Migrate `tracker.md` onto the board** in step 5 below, once the scope check has passed and, on a public repository, the operator has approved the batch.

Ask for the project number alone; the owner and repository are never asked for, they come from the working copy's own remote. Resolve that remote without assuming its name is `origin`, since a repository can call its GitHub remote `upstream`, `github`, or anything else:

```bash
git -C <working copy> remote -v
```

Read `<owner>/<repo>` out of whichever remote's URL has `github.com` as its host. No remote does, or the working copy has no remote at all, means this surface cannot be reached from this working copy at all: say so and stop, before asking for a project number nothing can use.

The tracker value to write is `github:<owner>/<repo>#<project-number>`. It is not written yet: the scope check that must pass first runs later, under **Before writing, on GitHub** in step 4 below, not here. Running it here would walk the operator through granting a scope for a run that step 2's partial collision or step 3's refusal could still abort before writing anything.

## Then, in order

### 1. Confirm the path, and make sure it exists

The confirmed path is `<working copy>/.capstan` for "in the repository," written and compared without a trailing slash from here on even though the rest of this document spells the directory `.capstan/` to mark it as one, or the path the operator just gave for "outside." An absolute path only. A relative one is rejected right here, before it gets the chance to stop a later step on an assumption about the session's own directory. Strip any trailing slash before comparing it to the home currently in force below; the two are compared by path, not by spelling.

Create the confirmed path if it does not already exist, before anything below can branch on it. Without this, choosing a folder outside the repository fails on its first run every time: a project folder named for the first time inside a vault is unreachable by definition. It also closes the case a re-confirmed key can otherwise reach: a folder deleted since the last run, waved through by every branch below because each one continues past this point rather than through it. This runs whether the confirmed path matches the home already in force or not, and whether the collision check below finds all the artifacts, some, or none: the guarantee is a property of the confirmed path itself, not of whichever branch happens to ask for it first.

Created empty, it can still be empty when this run ends, most often a fresh repository choosing the default with nothing yet to move into it, or a later step that stops before anything moves. Git does not track an empty directory, so step 7 commits nothing for it, and there is nothing to unwind either way: an empty directory left here is the same expected outcome as a fresh repository choosing the default, and the operator removes it by hand if they would rather it were gone.

### 2. Check the destination

The artifacts this step and step 3 track are `CONTEXT.md`, `decisions.md` and `decisions/`, always, plus `tracker.md` too when **The tracker-surface ask** settled on the default. When it settled on GitHub there is no `tracker.md` at all: it is never part of this set, and its absence is never a collision. Call this set **the artifacts** for the rest of this step and the next.

When the confirmed path is the home currently in force already, there is nothing to check or move: continue at step 4. This is the ordinary case of confirming the same answer back, even on a project too new to have any of the artifacts yet; whether it existed a moment ago is already said above.

Otherwise, check whether the confirmed path already holds any of the artifacts.

**All of them are there.** Report it, and ask the operator to choose:

- **Give a different path.** Return to **The ask** and ask it again from the fork, so choosing the default is a live answer this time too, then return to step 1 with whatever the operator gives. **The tracker-surface ask** does not run again here: it already answered its own separate question once this run, a document-home collision has nothing to do with it, and the answer it settled on stands.
- **Proceed.** The confirmed path's existing artifacts become the ones in force from here on. Skip step 3 entirely, and continue at step 4: the key still gets written, pointing at the confirmed path. If the home currently in force holds any of the artifacts, say plainly that it now holds a stale copy; if it holds none, there is nothing to say.

**Some but not all of them are there.** Never merge, never overwrite: a partial merge is the most dangerous kind, indistinguishable from data loss until someone diffs it by hand. Report exactly what is there, and offer only:

- **Give a different path.** Same as above, return to step 1.
- **Stop.** End the run here. The operator clears the destination by hand before running this again.

There is no third answer for a partial collision. Leaving the uncollided artifacts behind reaches the same split state a merge would, only by omission instead of by overwrite.

**None are there.** Continue to step 3.

This step runs every time a different path is in play, because two working copies pointed at one home would otherwise mean one decision log numbered by two different runs, and nothing else catches it: a working-copy-local claim file cannot see a working copy it does not know about.

### 3. Report what would move, then move it

List which of the artifacts sit at **the home currently in force** (the value read at the top of **The ask**) today and would move to the confirmed path.

If none of them do, ask the operator which is true, since nothing here can tell the two apart:

- **Nothing exists yet.** Proceed to step 4 with nothing moved.
- **This is not where the artifacts live.** The home currently in force, whether that came from a key or from standing at the default, is pointing at the wrong place; they sit somewhere else. Stop here. The operator points it at the right place by hand, then runs this again.

Otherwise, on the operator's approval, move them and continue to step 4. On refusal, move nothing, say plainly that `<home currently in force>` still holds what was just listed and the confirmed path is not receiving it, and stop here: do not write the key and do not commit. A refusal that still rewrote the key would leave that key pointing at an empty destination while the real log sat untouched at the old home, worse than either finishing the move or leaving everything as it was.

The move covers exactly the artifacts defined in step 2, nothing more and nothing less: `CONTEXT.md`, `decisions.md` and `decisions/` always, `tracker.md` too on the default and never on GitHub, where none exists to move. The effort scratch stays at `<working copy>/.capstan/effort/` under every configuration, and `.capstan/` itself is never deleted by this step. It can end up empty once the artifacts move out and no effort is currently running, the same expected emptiness as step 1's newly created folder.

### 4. Write the keys

**Before writing, on GitHub.** When **The tracker-surface ask** settled on GitHub, confirm the scope now, having reached this point only after steps 1 through 3 have run and after step 3's approval, if step 3 asked for one. Checking any earlier would walk the operator through granting a scope for a run that step 2's partial collision or step 3's refusal could still abort before writing anything. Check whether the token in force can reach Projects v2 by calling the thing the surface itself will call, rather than by reading the scope list `gh auth status` reports:

```bash
gh project list --owner <owner>
```

**It succeeds.** The token already reaches Projects v2. Continue below to write the key.

**It fails naming a missing scope.** Reading a board needs a scope this token does not carry. Hand off to the `walkthrough` skill for one stage: it tells the operator to run `gh auth refresh -s project` themselves, since granting a scope is an auth change and never this skill's to run, then stops and waits for the operator to confirm they ran it. Once confirmed, re-run the same `gh project list --owner <owner>` call. It succeeding now is the grant landing; continue below. It failing again is not a step to loop on: stop the run here and report what still fails.

**It fails any other way.** A network failure, an expired token, a rate limit, or `gh` itself missing all land here, along with anything else that is not the missing-scope error above. Per 648: say so and stop, no retry. `gh auth refresh -s project` fixes none of these, so do not send the operator to run it on the strength of this failure.

Each key picks its own file, independently of the other — this is what puts `capstan-document-home` and `capstan-tracker` in different files on a project that wants that, rather than forcing both into one:

- **The ask, or the tracker-surface ask, found the two files disagreeing on this key.** The operator already picked which one is correct there; write into that file, and do not ask again.
- **Neither `CLAUDE.md` nor `AGENTS.md` exists.** Create `AGENTS.md`, since both Claude Code and Codex read it; `CLAUDE.md` is never created by this step.
- **Exactly one of the two exists.** Write into that one.
- **Both exist, and nothing above settled it for this key.** Ask which file carries this key, naming it: "Which file should carry `capstan-document-home`?" or "Which file should carry `capstan-tracker`?", asked separately because they are settled separately. `capstan-document-home` always reaches this branch when both files exist and no earlier disagreement resolved it, since it is written every run; `capstan-tracker` reaches it only on a run that actually writes or removes its line — a run that leaves it alone has nothing to place.

Write `capstan-document-home: default` into its chosen file when the confirmed path is the default, or `capstan-document-home: <confirmed path>` when the operator named a path outside the repository. If that file already carries a `capstan-document-home` line, replace that line in place; never append a second one. A file with no existing key gets the line appended at the end, under no heading. A file this step creates holds one sentence above the key line saying what the file is, for example:

```
This file carries configuration read by Capstan and by other agents working in this repository.

capstan-document-home: default
```

Write `capstan-tracker` into its own chosen file, by the same replace-in-place rule, never a second line: **on GitHub**, `capstan-tracker: github:<owner>/<repo>#<project-number>` from the value **The tracker-surface ask** settled on. **On the default**, the opposite of the document-home key above: if the chosen file carries a `capstan-tracker` line, remove it; if it carries none, write nothing. Unset already means `tracker.md`, so nothing here needs distinguishing a project that was never asked from one that was asked and chose the default, the way `capstan-document-home` does; `capstan-tracker` carries no such ambiguity to resolve.

For each key, once its own file is chosen: if the other file — `CLAUDE.md` or `AGENTS.md`, whichever was not chosen for that key — still carries that key's line, remove it entirely; a stray line left standing there states a second, contradicting answer for a project that now has one settled. This runs every time both files exist, not only when an earlier ask found them disagreeing: a file that already agreed, or a file that carried a key while the chosen one did not, leaves a stray line behind exactly the same way if this is skipped. Once both keys have settled where they live, delete either `CLAUDE.md` or `AGENTS.md` that now carries neither key and nothing else, sentence this step wrote included, rather than leave an empty file behind; a zero-byte file in git history looks like it means something.

Write `capstan-document-home` even when the confirmed path is the default — as the literal `default`, never spelled out as `<working copy>/.capstan`, so a project that commits this file never commits the operator's own filesystem layout. Otherwise a project that was never asked and a project that was asked and chose the default also look identical on disk, and telling those two states apart is the reason this skill exists. `capstan-tracker` does not carry the same reason: its own unset state already means `tracker.md` before this skill ever runs.

### 5. Migrate `tracker.md` onto the board

Reached only when **The tracker-surface ask** settled on GitHub this run and `tracker.md` exists at **the home currently in force** — it is never one of step 2's artifacts on that surface, so it is still there rather than at the confirmed path. Nothing to do otherwise: continue to step 6.

Read every row and follow the write path in [`TRACKER-GITHUB.md`](../effort/TRACKER-GITHUB.md) for each one: the field once, a milestone once per distinct Effort column, an issue once per row under its Effort's milestone, added to the board, set to its own Status, and, for a `merged` row, its Commit posted as a comment before closing. Check for each create's own result first, by milestone title and by issue title within that milestone, before creating it — this is what makes an interrupted run resume rather than duplicate.

A migrated issue's body carries where the row came from and nothing else. Once, before creating the first issue, read the commit `tracker.md` is at right now, from whichever repository holds the home currently in force: `git -C <that repository> log -1 --format=%H -- tracker.md`. Every issue this run creates carries that same commit:

```
Migrated from `tracker.md` at commit <sha>.
```

**Visibility.** Per the Authority table in `skills/effort/SKILL.md`, a write a third party will see needs the operator; a private repository's does not. Check which this is:

```bash
gh repo view <owner>/<repo> --json visibility -q .visibility
```

Public: before writing anything, describe the batch — how many rows, how many milestones, that `tracker.md` is deleted once every row carries an issue — and ask for one approval covering all of it, not one per write, per 695. Refusing leaves the switch incomplete rather than half-made: undo the `capstan-tracker` line step 4 just wrote, restoring whatever it held before this run or removing it if it held nothing, say plainly that `tracker.md` still holds every row and none of it moved, and stop the run here, before step 6. Private: proceed unattended, the same as any other crew work at that visibility.

Delete `tracker.md` only once every row it held has an issue carrying its status, never before — an interrupted run leaves the file in place, and the next run resumes into whatever check-before-create already found on the board.

### 6. Add `.capstan/effort/` to `.gitignore`

Create `<working copy>/.gitignore` if it does not exist, and add the line if it is missing. A committed effort scratch is a stale spec sitting in someone's repository, read by the next agent as current when it no longer is.

### 7. Commit everything, once

Commit every change this run made to the working copy as a single commit, ordinary unattended work: whichever keys step 4 wrote, replaced, or removed, and a second file's key removed or the file deleted alongside it if step 4 found one; the artifacts removed from the home currently in force, if they moved out of the working copy; `tracker.md` deleted if step 5 finished migrating it; and the `.gitignore` line from step 6. Subject it `Configure document home`. Do not commit anything on the far side of a move. That is the operator's, always, the same as anything else in a vault they did not ask this skill to touch.

Nothing to commit is a valid outcome. Confirming the same answer back changes none of the working copy's own files, and this step is then a no-op.

### 8. Say the vault is theirs to commit

When the confirmed path is a folder outside the repository, tell the operator that the vault is theirs to commit, and that a document home can sit unversioned for days if they let it. When the artifacts also moved out of a vault, the source is theirs to commit too, for the same reason: this step ran no git there either, and the deletions sitting inside it are just as real as the arrivals in the destination. Nothing here runs git outside the working copy.

**Done when** exactly one `capstan-document-home` line exists across `<working copy>/CLAUDE.md` and `<working copy>/AGENTS.md` combined and reads `default` or an absolute path, at most one `capstan-tracker` line exists across those same two files combined and where one is present it reads `github:<owner>/<repo>#<project-number>`, `<working copy>/.gitignore` carries `.capstan/effort/`, listing the confirmed path directly, not recalling what an earlier step reported, shows a directory that exists and holds every one of the artifacts (step 2's set, for whichever surface **The tracker-surface ask** settled on) that exists anywhere, and, when that surface is GitHub, no `tracker.md` remains at the home currently in force. Zero of the artifacts, some of them, or all of them all satisfy this equally, since step 2 itself calls some-but-not-all the ordinary case; what fails it is one of the artifacts sitting somewhere else without also sitting at the confirmed path, or the confirmed path not existing at all. A stale copy left behind at the old home under step 2's full-collision Proceed, reported there as stale, does not fail this on its own: the confirmed path still holds every artifact currently in force.

## Re-running

Running this a second time is not a special mode. It is the same skill, and the reads at the top of **The ask** and **The tracker-surface ask** are what make re-running work. Each reports the current value, or the disagreement between the two files if there is one, before offering its own fork again, so the operator always sees what is in force before they change it, one surface at a time.

Confirming the same document-home value back finds nothing to move. Step 2 sees the confirmed path is the home already in force and skips straight to step 4, step 4 replaces the key line with the same value, step 6 is a no-op once the `.gitignore` line already carries it, and step 7 commits nothing further for it. Choosing a different answer runs steps 1 through 8 exactly as a first run would, moving the artifacts from the home currently in force, wherever that is today, to the newly confirmed path: vault A to vault B, `.capstan/` back to a vault, or any pair between them.

The tracker surface re-runs the same way on its own question, independent of whatever the document-home fork answered this time: confirming GitHub back re-checks the `project` scope and replaces the key line with the same value; moving from GitHub to the default removes it; moving from the default to GitHub writes it for the first time. None of this touches step 2's move or the artifacts it moves, since the tracker surface was never one of them. Confirming GitHub back also re-runs step 5: any row that already has an issue is found by its own title and skipped, so a run interrupted partway through a migration finishes it on the next run rather than repeating it.

This is what a one-shot question could not do. An operator who wants to change either answer runs `setup` again, rather than editing a key by hand and hoping the rest follows it there on their own.
