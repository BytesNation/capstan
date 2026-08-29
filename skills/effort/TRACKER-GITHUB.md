# Tracker: GitHub surface

The visibility gate that decides whether a write needs the operator's confirmation lives in the Authority table in `SKILL.md`, and only there. Read it before writing anything to this surface.

## The column mapping

`tracker.md` has four columns. Each maps onto a GitHub primitive built for that job, never onto a shape borrowed from elsewhere:

| Tracker column | GitHub primitive |
|---|---|
| Slice | An issue, titled with the slice's name — the only place that name lives on this surface |
| Effort | A milestone, grouping the issues that belong to it |
| Status | A **custom** single-select field on the Projects v2 board, named `Capstan Status` — never the built-in `Status` field |
| Commit | Posted as a comment on the issue once the slice merges |

A slice becomes an issue rather than a bare project item because only an issue can be closed by a pull request or linked from a commit, which is most of the reason to run this surface at all.

## The write path

Do these in order. Steps 1 and 2 happen once each — per board, per effort — and are already done for every slice after the first one. Steps 3 through 6 happen once per slice, and step 5 repeats every time that slice's status changes.

1. **The field, once per board.** Check whether `Capstan Status` already exists before creating it — a second `field-create` is not obviously a no-op:

   ```
   gh project field-list <project-number> --owner <owner>
   ```

   If `Capstan Status` is not in the list, whoever is making this board's first status write creates it, with the same four options `tracker.md` always used: `planned`, `building`, `merged`, `dropped`. Nothing else ever creates it — `setup` never touches the field, and there is no per-effort or per-slice variant:

   ```
   gh project field-create <project-number> --owner <owner> --name "Capstan Status" \
     --data-type SINGLE_SELECT --single-select-options "planned,building,merged,dropped"
   ```

2. **The milestone, once per effort.** `gh` has no `milestone` command at all. Check the effort already has one before creating it:

   ```
   gh api repos/<owner>/<repo>/milestones -q '.[].title'
   ```

   If `<effort>` is not in the list:

   ```
   gh api repos/<owner>/<repo>/milestones -f title="<effort>" -X POST
   ```

3. **The issue, once per slice.** `gh issue create -m <name>` needs the milestone from step 2 to already exist:

   ```
   gh issue create -R <owner>/<repo> --title "<slice>" --body "<what this slice does>" --milestone "<effort>"
   ```

4. **Add the issue to the board.** An issue carrying a milestone is not yet a project item — it becomes one only here. Skip this and step 5 has nothing to edit:

   ```
   gh project item-add <project-number> --owner <owner> --url <issue-url>
   ```

5. **Set the status**, by name, every time the slice moves: `planned` to `building` to `merged`, or to `dropped`. `gh project item-edit` resolves both the field and the option from what you pass it, which is the form `gh` itself documents as the usual one:

   ```
   gh project item-edit <project-number> --owner <owner> \
     --url <issue-url> --field "Capstan Status" --value "<status>"
   ```

6. **Close the issue.** This surface closes it explicitly, in both terminal cases — the write path never relies on a pull request or on GitHub's own automation to do it.

   For a `merged` slice, first post the merge commit as a comment, then close with reason `completed`:

   ```
   gh issue comment <issue-url> --body "merged in \`<commit-sha>\`"
   gh issue close <issue-url> --reason completed
   ```

   For a `dropped` slice there is no merge commit, and no pull request to close the issue either, so close it directly with reason `not planned`:

   ```
   gh issue close <issue-url> --reason "not planned"
   ```

## Reading the tracker back

`gh project item-list <project-number> --owner <owner> --format json` returns Effort, Slice and Status together, in one call — the milestone, the issue title, and the custom field's current value are all columns on the same item:

```
gh project item-list <project-number> --owner <owner> --format json \
  -q '.items[] | {slice: .title, status: ."capstan Status", effort: .milestone.title}'
```

`--format json` is not optional for this read. Bare `gh project item-list <project-number> --owner <owner>`, without it, returns a fixed table of TYPE, TITLE, NUMBER, REPOSITORY, ID — neither the milestone nor the custom field is on it.

In that JSON the field is keyed `capstan Status`, not `Capstan Status`: GitHub lowercases only the first word of a custom field's name when it renders the field into JSON, leaving the option values (`planned`, `building`, `merged`, `dropped`) untouched. Query `."capstan Status"`, or the read comes back empty against a field that is actually set.

Reconstructing three of the tracker's four columns this way costs exactly what reading `tracker.md` costs: one read.

The merge commit is the exception. It lives in an issue comment, not on the project item, so getting it back costs one further call per slice — `gh issue view` or an equivalent, run once for every issue whose commit you need. A read of the full tracker is 1+N calls against the board, where N is the number of slices, not the one file-read `tracker.md` gives an agent that already has it open. This surface is worth it for the visibility it gives people without a clone; it is not a drop-in replacement for the offline, single-read table underneath it.

## Why never the built-in `Status`

GitHub ships every Projects v2 board with a built-in `Status` field, defaulting to Todo / In Progress / Done. Do not write Capstan's statuses there. Create a separate custom single-select and write to that instead.

Closing an issue fires GitHub's own Projects workflow, and that workflow sets the built-in `Status` to `Done` on its own, overwriting whatever Capstan last wrote. `merged` and `dropped` both close the issue, so the built-in field collapses them into the same value — exactly the distinction a tracker exists to hold. A custom field carries all four of Capstan's statuses and survives closure untouched, because nothing but Capstan ever writes to it.

There is no repair path either. `gh` has no `project field-edit`, so the built-in field's options cannot be renamed or repurposed from the CLI. The custom field is the only way in.

## Unreachable stops the phase

GitHub unreachable stops the phase and says so. No retry, no backoff, no bounded wait. A rate limit and an expired token are the same case: the run ends rather than slows down. This is the same rule an unreachable document home already gets — a missing source of truth is not ambiguity to work around, it is a reason to stop.
