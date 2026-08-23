---
name: slicing
description: Cut a settled plan into vertical slices with explicit blocking edges, so parallel builders can work without colliding. Use after a concept is locked and before any building starts.
---

# Slicing

A slice is a thin, complete path through every layer of the change, demonstrable on its own the moment it lands.

This is the constraint that makes parallel building possible. Get it wrong and the fan-out is theatre: every worker's output depends on another's, they collide in the same files, and nothing can be verified until the last one arrives.

## The test

For every slice, answer in one sentence: **what can be demonstrated when this is done?**

The answer must be behaviour. "The schema has a `schedule` column" is not behaviour. "A user can set a schedule and see it persist across a reload" is.

A slice with no answer is a horizontal slice, and horizontal slices are the failure mode this skill exists to prevent. Cutting by layer means every acceptance criterion reaches into work another slice owns, so nothing can be verified until the last slice lands and the rework arrives all at once.

Ask the question once per slice. It takes seconds and it catches almost everything.

## Sizing

Each slice fits one fresh context window. The thing that will pick it up has never seen the spec and cannot ask you anything.

Too big is the more common error and it shows up as a build that keeps blowing out. The fix is upstream: split the slice, do not raise the effort level.

Too small is real too. Twelve slices for a three-line change means the units became atomic and lost the grouping that made them meaningful. If the whole change fits in one context window, do not slice at all. Build it.

## Single-artifact work does not fan out

Parallel builders need slices that own **different things**. When the whole deliverable is one artifact, a document, a script, a rendered video, a single config file, there is nothing to divide. Every candidate slice edits the same file, so parallel builders collide in the one place isolation cannot help them.

For that work the correct plan is **one slice**, and it is a correct plan rather than a failure to parallelise. Say so plainly instead of manufacturing slices to justify the machinery.

The tell is the artifact count, not the work's size. A large document is still one artifact. A small feature touching a schema, an API and a UI is three, and fans out fine.

This matters most when the same crew handles code and non-code work. Software usually fans out because slices own different files. Documents, content and single-file configuration usually do not, and expecting parallelism there will produce either a collision or a fake decomposition.

## Blocking edges

Name the files each slice owns: the ones it, and only it, touches, so every file the change touches has exactly one slice responsible for it.

Each slice declares which slices must finish before it can start. Those edges are the artifact.

Keep them honest. An edge that exists because it feels tidier to do A first is not an edge, and every false edge costs you a Builder that could have been running. An edge is real only when the later slice cannot be built or cannot be verified until the earlier one lands.

The slices with no open blockers are the **frontier**. Every one of them can be dispatched at once.

## Prefactoring goes first

Make the change easy, then make the easy change. When the current shape makes every slice awkward, the reshaping is its own slice and it sorts to the front, blocking the ones that need it. Do not smuggle it inside a feature slice.

## The wide refactor exception

One shape genuinely breaks the vertical rule: a single mechanical change whose blast radius fans across the whole codebase. Renaming a column, retyping a shared symbol. One edit breaks a thousand call sites and no vertical slice can land green.

Sequence that as expand, migrate, contract:

- **Expand**: add the new form beside the old. Nothing breaks.
- **Migrate**: move call sites in batches sized by blast radius, one slice per batch, each blocked by the expand. CI stays green because the old form still exists.
- **Contract**: delete the old form once no caller remains, blocked by every migrate batch.

Where even the batches cannot stay green alone, they share an integration branch and all block a final integrate-and-verify slice. Green is promised only there, and the plan says so.

## Seams

Name the test seam for each slice here, not during the build. A seam is the public boundary behaviour is observed at without reaching inside.

Prefer seams that already exist to new ones, and take the highest seam you can get away with. The ideal number of new seams across a change is zero.

A Builder handed no seam will invent one, and a test at an invented seam gets deleted the first time the implementation underneath it moves.

## Acceptance criteria that can fail

For each criterion, name the observation that would show it false, and confirm it fails at the commit the Builder starts from.

Three bad shapes recur: a criterion already true before any work, a criterion only satisfiable by work another slice owns, and a criterion that restates the request rather than deriving from the artifact. Vertical slicing prevents most of this by construction, since a slice delivering behaviour that did not exist before is red at the base commit automatically. Check anyway.

## Present before you publish

Show the numbered breakdown with its edges and get it confirmed before anything is dispatched. Ask directly whether the granularity is right, whether the edges are real, and whether anything should merge or split. This is the cheapest moment to fix a bad cut, and it is the last one.

**Done when** every slice carries Owns, Demonstrated, Seam, Red at base and Blocked by.
