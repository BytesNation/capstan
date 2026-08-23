# Audit

The editing pass that applies [`SKILL.md`](SKILL.md) to one target document. Run it against a single target at a time.

Work the steps in order. Each pass is cheap on its own and expensive to redo once a later one has moved things around.

## 1. Prune

Read the target sentence by sentence. For each, ask whether it changes behaviour versus the model's default. A sentence that fails is a no-op: delete the whole sentence rather than trimming words from it.

Done when every sentence has been judged once.

## 2. Deduplicate

List every meaning the document carries in more than one place. For each, pick the authoritative home and cut the rest. Repeating a leading word is not duplication; repeating its definition is.

Check the environment too. A line restating `package.json`, a config file, the directory layout, or `--help` output is a cache, and it earns its load only when the lookup is expensive or the knowledge is unwritten.

Counts are the cache that goes stale fastest. A number that only says how many items are in the list beneath it duplicates the list, and it is wrong the moment somebody adds an item without scrolling up. Delete it rather than correcting it. A count that constrains ("three efforts is the ceiling") or sets a bar ("all thirty-one, not the ones that come to mind") is doing work no list does, and stays.

Done when every repeated meaning has one home.

## 3. Sharpen the bounds

For every step, name its completion criterion and judge two properties: can the agent tell done from not-done, and does it demand enough legwork. Rewrite the fuzzy ones in place. Where the target is flat reference with no steps, state the exhaustiveness bar the whole body ends on.

Done when every step carries a criterion you could check yourself.

## 4. Rank the ladder

For each section, ask which branches reach it. Inline what every branch needs. Push behind a pointer what only some branches reach, and write the trigger branches into the pointer.

Then judge the sequence cut: split a run of steps when the later ones sit in view while an earlier one is being worked, **and** a real context boundary separates them — a hand-off, a subagent dispatch, or a run that ends. Without the boundary the split hides nothing, because the later steps stay in context either way.

Done when every section is placed and every pointer names its triggers.

## 5. Report

Walk the target section by section and say what happened to each.

**Every section accounted for**: kept, cut, moved down the ladder, or rewritten, each with a reason.
