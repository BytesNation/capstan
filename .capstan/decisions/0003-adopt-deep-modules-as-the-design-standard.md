# 0003. Adopt deep modules as the design standard

**Status**: accepted
**Date**: 2026-08-21

## Context

Capstan has a word for everything the work is *about* and no word for how the work is *shaped*. `.capstan/CONTEXT.md` settles domain terms one line at a time, and every agent that writes or reviews code reads it, so a name that contradicts it is a review finding. Nothing plays that role for structure.

The cost lands on the Reviewer. `two-axis-review` asks whether the diff is built right, and the standards axis answers that from repository convention plus whatever the Reviewer already believes about good code. Convention catches formatting, naming, and the shape of neighbouring files. It has nothing to say about whether an interface earns its size, whether a seam belongs where it was put, or whether a new module is a pass-through. Two Reviewers on the same diff can disagree about all three and both be defensible, which is the tell that a standard is missing rather than unenforced.

Matt Pocock's `codebase-design` supplies exactly that vocabulary: module, interface, depth, seam, adapter, leverage, locality, each with a stated preferred usage and a list of words to avoid. It also carries checks a Reviewer can actually apply. The deletion test asks what complexity reappears if the module were removed. "One adapter means a hypothetical seam, two means a real one" turns a judgement call into a count.

## Decision

The `codebase-design` vocabulary becomes Capstan's design standard, vendored under MIT with `DEEPENING.md` and `DESIGN-IT-TWICE.md` beside it, and preloaded on the Reviewer.

This is a position, not a reference. Depth-as-leverage is Ousterhout-derived, and the skill explicitly rejects competing framings, including Ousterhout's own implementation-lines-to-interface-lines ratio. Adopting it means a Capstan review can now find that a module is too shallow, which was not previously a defect anyone could name.

## Alternatives

**Vendor it as an optional reference, invoked when someone asks.** Rejected for the reason the design doc gives about preloading: a discipline that has to be remembered is a discipline that gets skipped at exactly the moment it matters. A design vocabulary nobody loads is a glossary nobody reads.

**Write our own.** Rejected. The value here is a settled vocabulary with rejected framings written down, and a fresh one would be this one with different words and no better claim.

**Take the vocabulary, drop the opinion.** Attractive and incoherent. Depth is the load-bearing term; without it, seam and adapter are just synonyms for boundary and implementation, which is the ambiguity the skill exists to remove.

**Keep the status quo.** Leaves the standards axis answering a question it has no standard for, which is the problem.

## Consequences

Capstan now holds an opinion about code structure, and it is the first one. Every prior discipline is about process: how to interview, how to slice, when to stop. This one says what good code looks like.

That is also the first standard Capstan imposes on a repository from outside it. `two-axis-review` has always said the repository overrides, but it said so about documentation the repository wrote; a preloaded skill is a standard nothing local consented to. So the override is stated explicitly for imported standards, and the repository declines one the same way it settles anything else, as a line in its own `.capstan/decisions.md`. The Reviewer reads that file before grading, which is what makes the line binding. Silence still means the standard applies: requiring every repository to adopt it twice would make preloading pointless.

The examples are TypeScript while Capstan claims to run a client document or an infrastructure change as readily as a feature. The principles behind them are language-agnostic; the illustrations are not. This is a known rough edge, recorded rather than papered over.

`DESIGN-IT-TWICE.md` spawns parallel sub-agents to design one interface several ways. That is the Architect's fan-out, not a new seat, and it belongs to the moment a spec cannot be written because the interface shape is the open question.

Three more vendored files means more upstream to track. `CREDIT.md` carries the same mechanical refresh contract as the other four.

## Revisit when

A repository declines this standard in its decision log and the Reviewer grades against it anyway. The opt-out is prose in three files, not a mechanism anything enforces, so the failure mode is an agent that reads past it. That is the thing to watch, and the first instance is worth a fix rather than a second record.
