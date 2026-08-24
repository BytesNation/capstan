---
name: setup
description: Configure where a project's durable artifacts live, in this repository or in a folder outside it, move what is already there, and change the answer later.
disable-model-invocation: true
---

# Setup

This configures the **document home**: the one root Capstan resolves every path to its own durable artifacts against, the glossary, the decision log, the decision records and the tracker. The default is `<working copy>/.capstan/`, and unset means nothing has chosen yet.

The operator types `setup` to run this. Nothing else reaches for it on its own reading of a sentence. Relocating someone's decision log on a guess is worse than the operator typing one command.

It is safe to run more than once. See **Re-running** at the end.

## Precondition: name the working copy

Establish the **absolute path** of the repository this configures, the same way `effort`'s own Precondition section does:

```bash
git -C <abs-path> rev-parse --show-toplevel
```

Everything below refers to that path. It is not necessarily the session's working directory, and it must never be assumed to be. Address every file by absolute path, `git -C <path>` included, and the session's own location stops mattering.

## The ask

Before asking anything, read `capstan-document-home` from `<working copy>/CLAUDE.md` and `<working copy>/AGENTS.md`, both addressed by absolute path against the working copy above. Call whatever this settles to **the home currently in force**: the value found, or `<working copy>/.capstan/` when neither file carries the key.

If the two files carry the key with different values, report both: "`CLAUDE.md` says `<value>`. `AGENTS.md` says `<value>`." Ask which one is correct before anything else. The answer becomes the home currently in force, and step 5 removes the key from the file that lost. Otherwise, if either file carries it, report the current value: "Currently: `<value>`." Then continue below regardless, since changing an existing answer runs the same procedure as setting it the first time.

Two steps. Never a three-way menu, since someone who wants the default should not read two paragraphs about vault layouts to get there.

**First, the fork.** Ask where the glossary, the decision log, the decision records and the tracker should live:

- In the repository, at `.capstan/`. Where they already sit if nothing has been configured elsewhere.
- In a folder outside the repository, such as an Obsidian vault.

**Second, only on "outside."** Describe the two layouts the operator can choose between, one line each, then ask for an absolute path. Describe them; do not coin a short name for either, because Capstan stores neither choice and a coined name would be vocabulary for a distinction nothing persists:

- One vault per project, where the absolute path is that vault's own root.
- One folder per project in a shared vault, where the absolute path is this project's own folder inside it.

Both resolve to the same thing from here on, an absolute path configured away from the default. The description above exists to help a person choose; nothing below branches on which one they picked.

## Then, in order

### 1. Confirm the path

The confirmed path is `<working copy>/.capstan/` for "in the repository," or the path the operator just gave for "outside." An absolute path only. A relative one is rejected right here, before it gets the chance to stop a later step on an assumption about the session's own directory.

### 2. Create the folder if it does not exist

After the operator confirms the path, create it if it is missing. Without this, choosing a folder outside the repository fails on its first run every time. A project folder named for the first time inside a vault is unreachable by definition, and an unreachable configured root stops the phase.

### 3. Check the destination

If the confirmed path already holds any of `CONTEXT.md`, `decisions.md`, `decisions/` or `tracker.md`, report exactly what is there and ask the operator how to proceed: give a different path, or keep this one and move nothing further. Never merge, never overwrite. This step runs every time, including when the confirmed path is where the artifacts already live (confirming the same answer back, for instance), and the expected answer there is simply to proceed, since nothing needs to move. Two working copies pointed at one home means one decision log numbered by two different runs, and nothing else catches it. A working-copy-local claim file cannot see a working copy it does not know about.

### 4. Report what would move, then move it

List which of the four artifacts sit at **the home currently in force** (the value read at the top of **The ask**) today and would move to the confirmed path. On the operator's approval, move them. On refusal, move nothing, and say plainly that a stale copy remains at the home currently in force.

The move covers exactly those four: `CONTEXT.md`, `decisions.md`, `decisions/`, `tracker.md`. The effort scratch stays at `<working copy>/.capstan/effort/` under every configuration, and `.capstan/` itself stays too, since the scratch lives there and `.gitignore` points at it.

Skip this step when the confirmed path is the home currently in force already. There is nothing to move.

### 5. Write the key

Write `capstan-document-home: <confirmed path>` into whichever of `<working copy>/CLAUDE.md` and `<working copy>/AGENTS.md` exists. Both existing means asking which one to write into, even when the two do not yet disagree. Writing into only one of them is exactly how they end up disagreeing later, and that is a state this step must not create. Neither existing creates `AGENTS.md`, since both Claude Code and Codex read it.

When **The ask** found the two files disagreeing, write the confirmed path into the file the operator picked as correct, and remove the `capstan-document-home` line entirely from the other. One file carries the key from here on; the mismatch does not survive this run.

Append the key as a bare line at the end of the file, under no heading:

```
capstan-document-home: /Users/example/vault/ProjectName
```

A file this step creates holds one sentence above that line saying what the file is, for example:

```
This file carries configuration read by Capstan and by other agents working in this repository.

capstan-document-home: /Users/example/vault/ProjectName
```

### 6. Write the key even when the answer is the default

Write it even when the confirmed path is `<working copy>/.capstan/`. Otherwise a project that was never asked and a project that was asked and chose the default look identical on disk, and telling those two states apart is the reason this skill exists.

### 7. Add `.capstan/effort/` to `.gitignore`

Add the line if it is missing from `<working copy>/.gitignore`. A committed effort scratch is a stale spec sitting in someone's repository, read by the next agent as current when it no longer is.

### 8. Commit everything, once

Commit every change this run made to the working copy as a single commit, ordinary unattended work: the mismatch resolved in **The ask**, if there was one; the artifacts removed from the home currently in force, if they moved out of the working copy; the key written in steps 5 and 6; and the `.gitignore` line from step 7. Do not commit anything on the far side of a move. That is the operator's, always, the same as anything else in a vault they did not ask this skill to touch.

Nothing to commit is a valid outcome. Confirming the same answer back changes none of the working copy's own files, and this step is then a no-op.

### 9. Say the vault is theirs to commit

When the confirmed path is a folder outside the repository, tell the operator that the vault is theirs to commit and that a document home can sit unversioned for days if they let it. Nothing here runs git outside the working copy.

**Done when** the key is in exactly one of `<working copy>/CLAUDE.md` and `<working copy>/AGENTS.md`, `<working copy>/.gitignore` carries `.capstan/effort/`, and the four artifacts sit at the confirmed path, or the operator was told a stale copy remains at the home currently in force.

## Re-running

Running this a second time is not a special mode. It is the same skill, and the read at the top of **The ask** is what makes re-running work. It reports the current value, or the disagreement between the two files if there is one, before offering the fork again, so the operator always sees what is in force before they change it.

Confirming the same value back finds nothing to move. Step 3 sees the artifacts already at the destination and the expected answer is to proceed, step 4 sees the confirmed path is the home already in force and does nothing, step 5 rewrites the same line, step 7 is a no-op once the `.gitignore` line already carries it, and step 8 commits nothing. Choosing a different answer runs steps 1 through 9 exactly as a first run would, moving the four artifacts from the home currently in force, wherever that is today, to the newly confirmed path: vault A to vault B, `.capstan/` back to a vault, or any pair between them.

This is what a one-shot question could not do. An operator who wants to change the answer runs `setup` again, rather than editing the key by hand and hoping the artifacts follow it there on their own.
