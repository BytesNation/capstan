---
name: verify
description: Run the project's own checks against the integrated result and report what they showed. Use after slices merge and before a brief claims anything works.
---

# Verify

A slice that passed in its own worktree proves that slice. It says nothing about the ones landing beside it, and isolated parallel worktrees are a machine for producing changes that are each correct alone and broken together.

Reviewers do not close this gap. `two-axis-review` reads a diff and skips what a typechecker would catch, on the grounds that CI catches it. Something has to be CI.

## Find the checks the repository already declares

Never invent a command. Read what the project says about itself, in this order:

1. **CI workflow files.** `.github/workflows/`, `.gitlab-ci.yml`, `.circleci/`, whatever is there. This is the strongest source, because it is the project's own statement of what passing means.
2. **The task runner.** `package.json` scripts, `Makefile`, `justfile`, `Taskfile.yml`, `pyproject.toml`, `Cargo.toml`, `go.mod`.
3. **Commit hooks.** `.pre-commit-config.yaml`, a `husky/` directory.
4. **The contributing guide**, when one exists and the files above disagree with it.

Take the CI definition when there is one. A repository whose CI runs typecheck, then tests, then a lint step is telling you the order and the set.

**Done when** you can name every command you are about to run and the file each one came from.

## Know what was already red

A check that was failing before this effort started is not this effort's finding, and reporting it as one sends a Builder after somebody else's bug.

`CLAIM.md` records `head`, the commit the effort began from. That is the baseline. You do not need it until something fails: when a check goes red, run that one command again at `head` in a throwaway worktree before you report it.

```bash
git -C <repo> worktree add -q <tmp>/verify-baseline <head-from-CLAIM>
```

Red at `head` too means pre-existing. Say so, name it, and do not attribute it to a slice. Remove the worktree when you are done with it.

## Run them against the integration

Run on the branch every slice merged into, never on a slice branch, and address it with `git -C <repo>` rather than changing directory.

Keep the output out of your context. A test suite prints thousands of lines and you need the failures, not the run:

```bash
<command> > <tmp>/verify-<check>.log 2>&1; echo "exit $?"
```

Then read the tail, and grep the log for the failures. Read the whole log only when the tail does not say what broke.

## Report what you observed

An exit code is not an observation. "The suite ran, 412 passed, 3 failed, all three in `checkout_test.py`" is. Name the check, what it did, and what it said.

The gate-3 brief carries this, per the `brief` skill, which asks for what verification showed rather than what a command returned. That sentence has to be answerable from what you write here.

## When something is red

Do not fix it. This discipline reports, the same as a review does.

Slices merged in dependency order, so that order is the suspect list, most recent first. Hand the failure to a Builder with `diagnosing-bugs`: it owns building a loop that goes red on this, and a red check is most of a loop already. The fix is a Builder task against the slice that caused it, never the instance that wrote it.

## When there are no checks

Say so plainly and say what you did instead. A repository with no declared checks gets a degraded verification rather than none: run whatever the work itself claimed, and report that this was all that existed.

Silence reads as passing. That is the failure this rule exists for.

## Work that produces no code

The same question, asked of a different artifact: what would show this is wrong, and did you look? A document gets read against the spec it was written from. A configuration change gets applied in check mode and the running state observed, never the exit status. A migration gets run against a copy.

**Done when** every check named in the first step has been run against the integration, each result is stated as an observation rather than an exit code, and anything red is either traced to a slice or shown to have been red at `head`.
