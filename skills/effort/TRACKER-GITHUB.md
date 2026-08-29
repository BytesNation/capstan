# Tracker: GitHub surface

Reached from [`SKILL.md`](SKILL.md)'s `## Tracker` section when `capstan-tracker` names a GitHub surface. Carries the column mapping, the four statuses as GitHub holds them, and the unreachable stop.

The visibility gate that decides whether a write needs the operator's confirmation lives in the Authority table in `SKILL.md`, and only there. Read it before writing anything to this surface.

## The column mapping

`tracker.md` has four columns. Each maps onto a GitHub primitive built for that job, never onto a shape borrowed from elsewhere:

| Tracker column | GitHub primitive |
|---|---|
| Slice | An issue |
| Effort | A milestone, grouping the issues that belong to it |
| Status | A **custom** single-select field on the Projects v2 board — never the built-in `Status` field |
| Commit | Posted as a comment on the issue once the slice merges |

A slice becomes an issue rather than a bare project item because only an issue can be closed by a pull request or linked from a commit, which is most of the reason to run this surface at all.

## Why never the built-in `Status`

GitHub ships every Projects v2 board with a built-in `Status` field, defaulting to Todo / In Progress / Done. Do not write Capstan's statuses there. Create a separate custom single-select and write to that instead.

Closing an issue fires GitHub's own Projects workflow, and that workflow sets the built-in `Status` to `Done` on its own, overwriting whatever Capstan last wrote. `merged` and `dropped` both close the issue, so the built-in field collapses them into the same value — exactly the distinction a tracker exists to hold. A custom field carries all four of Capstan's statuses and survives closure untouched, because nothing but Capstan ever writes to it.

There is no repair path either. `gh` has no `project field-edit`, so the built-in field's options cannot be renamed or repurposed from the CLI. The custom field is the only way in.

## The four statuses

`planned`, `building`, `merged`, `dropped` — unchanged from `tracker.md`'s set. Create the custom field once per board, naming it however the setup step chose, with those four as its single-select options:

```
gh project field-create <project-number> --owner <owner> --name "<field name>" \
  --data-type SINGLE_SELECT --single-select-options "planned,building,merged,dropped"
```

Move a slice between statuses by name — `gh project item-edit` resolves both the field and the option from what you pass it, which is the form `gh` itself documents as the usual one:

```
gh project item-edit <project-number> --owner <owner> \
  --url <issue-url> --field "<field name>" --value "<status>"
```

## Unreachable stops the phase

GitHub unreachable stops the phase and says so. No retry, no backoff, no bounded wait. A rate limit and an expired token are the same case: the run ends rather than slows down. This is the same rule an unreachable document home already gets — a missing source of truth is not ambiguity to work around, it is a reason to stop.

## Reading the tracker back

`gh project item-list` returns Effort, Slice and Status together, in one call — the milestone, the issue title, and the custom field's current value are all columns on the same item. Reconstructing three of the tracker's four columns costs exactly what reading `tracker.md` costs: one read.

The merge commit is the exception. It lives in an issue comment, not on the project item, so getting it back costs one further call per slice — `gh issue view` or an equivalent, run once for every issue whose commit you need. A read of the full tracker is 1+N calls against the board, where N is the number of slices, not the one file-read `tracker.md` gives an agent that already has it open. This surface is worth it for the visibility it gives people without a clone; it is not a drop-in replacement for the offline, single-read table underneath it.
