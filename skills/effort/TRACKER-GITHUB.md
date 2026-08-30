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

Do these in order. Steps 1 and 2 happen once each — per board, per effort — and are already done for every slice after the first one. Steps 3 through 6 happen once per slice, and step 5 repeats every time that slice's status changes; step 6's merge-commit comment can be revisited afterward too, per the declaration below.

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

   For a `merged` slice, first post the merge commit as a comment, in the format declared below, then close with reason `completed`:

   ```
   gh issue comment <issue-url> --body "merged in \`<commit-sha>\`"
   gh issue close <issue-url> --reason completed
   ```

   If a later fix dispatch changes which commit merged the slice's final state, correcting the row is an edit of that comment, never a second one posted alongside it — the declaration below says why. Either of these edits it in place, both verified against a live comment:

   ```
   gh issue comment <issue-url> --edit-last --body "merged in \`<commit-sha>\`"
   gh api -X PATCH repos/<owner>/<repo>/issues/comments/<comment-id> -f body="merged in \`<commit-sha>\`"
   ```

   `--edit-last` edits the authenticated user's own most recent comment on the issue — correct as long as nothing else posts under that same identity after the merge comment. The `PATCH` form edits by comment ID instead, so it works regardless of who posted it or what else was said afterward; reach for it once a run has already located the single conforming comment by ID while reading the issue back.

   For a `dropped` slice there is no merge commit, and no pull request to close the issue either, so close it directly with reason `not planned`:

   ```
   gh issue close <issue-url> --reason "not planned"
   ```

## The merge-commit comment format

The comment step 6 posts on a `merged` row's issue is a contract, not just an example: this is the one declaration of it, and every direction that writes or reads it points here rather than restating it. A conforming comment's body is exactly

```
merged in `<commit-sha>`
```

equivalently, the whole body matches

```
^merged in `[0-9a-f]{4,40}`$
```

where `<commit-sha>` is the commit's SHA in lowercase hexadecimal, abbreviated or full. Nothing precedes or follows it, and the SHA sits inside the single pair of backticks shown.

A `dropped` row never carries this comment — step 6 closes it directly, naming no commit — so an issue with no merge-commit comment is a conforming `dropped` row, not a gap to fill in.

A `merged` row's issue carries exactly one conforming comment. When a later fix dispatch changes which commit merged the slice's final state, the correction edits that comment in place, the same way `tracker.md`'s Commit column is a cell overwritten rather than a log appended to. It never posts a second conforming comment alongside the first — two would read back no differently than one that changed its mind, and nothing on this surface could say which is current.

An issue can otherwise carry any number of comments that do not match the pattern above — a question, a status update, a remark from anyone with access to the repository. Those are ordinary discussion, not a gap or a corruption, and reading the tracker back ignores them. What stops the run is a count: a `merged` row whose issue carries zero conforming comments, or more than one, has no single commit to read, and reports what it found rather than guessing at what was meant.

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
