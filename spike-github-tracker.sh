#!/usr/bin/env bash
# THROWAWAY. Capstan github-surface spike, decision 655. Never merged.
# Answers one question: does 647's mapping behave right?
#   slice -> issue, effort -> milestone, status -> single-select, commit -> comment
# No tests, no abstraction, no error handling beyond staying upright.
set -uo pipefail

. .capstan/effort/spike.env
OWNER=$(gh api user -q .login)
R="$SPIKE_REPO"; P="$SPIKE_PROJECT"

show() {  # the WHOLE condition, not just what moved
  echo "--- board ---"
  gh project item-list "$P" --owner "$OWNER" --format json \
    -q '.items[] | "\(.content.number // "-")  \(.title)  status=\(."capstan Status" // .status // "<unset>")  milestone=\(.milestone.title // "-")"' 2>/dev/null
  echo "--- issues ---"
  gh issue list -R "$R" --state all --json number,title,state,milestone \
    -q '.[] | "#\(.number) \(.title) state=\(.state) milestone=\(.milestone.title // "-")"'
  echo
}

echo "### CASE 0: can Capstan's four statuses exist at all?"
gh project field-create "$P" --owner "$OWNER" --name "Capstan Status" \
  --data-type SINGLE_SELECT --single-select-options "planned,building,merged,dropped" \
  --format json -q .name || echo "FIELD-CREATE FAILED"
gh project field-list "$P" --owner "$OWNER" | grep -i "capstan\|^Status"
echo

echo "### setup: milestone (effort) + two issues (slices)"
gh api "repos/$R/milestones" -f title="github-surface" -X POST -q .number >/dev/null 2>&1 || true
gh issue create -R "$R" --title "cart-api" --body "slice" --milestone "github-surface" -q .url --json url 2>/dev/null || \
  gh issue create -R "$R" --title "cart-api" --body "slice" --milestone "github-surface"
gh issue create -R "$R" --title "payment-flow" --body "slice" --milestone "github-surface"
U1=$(gh issue list -R "$R" --json number,url,title -q '.[]|select(.title=="cart-api")|.url')
U2=$(gh issue list -R "$R" --json number,url,title -q '.[]|select(.title=="payment-flow")|.url')
gh project item-add "$P" --owner "$OWNER" --url "$U1" >/dev/null
gh project item-add "$P" --owner "$OWNER" --url "$U2" >/dev/null
show

echo "### CASE 1: ordinary path, planned -> building -> merged + commit comment"
for S in planned building merged; do
  gh project item-edit --project-id "$(gh project view "$P" --owner "$OWNER" --format json -q .id)" \
    --id "$(gh project item-list "$P" --owner "$OWNER" --format json -q '.items[]|select(.title=="cart-api")|.id')" \
    --field-id "$(gh project field-list "$P" --owner "$OWNER" --format json -q '.fields[]|select(.name=="Capstan Status")|.id')" \
    --single-select-option-id "$(gh project field-list "$P" --owner "$OWNER" --format json -q ".fields[]|select(.name==\"Capstan Status\")|.options[]|select(.name==\"$S\")|.id")" \
    >/dev/null 2>&1 && echo "set cart-api -> $S" || echo "FAILED to set $S"
done
gh issue comment -R "$R" "$U1" --body "merged in \`deadbee\`" >/dev/null && echo "posted merge commit comment"
show

echo "### CASE 2: close the issue the way GitHub closes issues. Does Status survive?"
gh issue close -R "$R" "$U1" --reason completed >/dev/null && echo "closed cart-api"
sleep 3
show

echo "### CASE 3: dropped. Can a dropped slice be told from a merged one?"
gh project item-edit --project-id "$(gh project view "$P" --owner "$OWNER" --format json -q .id)" \
  --id "$(gh project item-list "$P" --owner "$OWNER" --format json -q '.items[]|select(.title=="payment-flow")|.id')" \
  --field-id "$(gh project field-list "$P" --owner "$OWNER" --format json -q '.fields[]|select(.name=="Capstan Status")|.id')" \
  --single-select-option-id "$(gh project field-list "$P" --owner "$OWNER" --format json -q '.fields[]|select(.name=="Capstan Status")|.options[]|select(.name=="dropped")|.id')" \
  >/dev/null 2>&1 && echo "set payment-flow -> dropped"
gh issue close -R "$R" "$U2" --reason "not planned" >/dev/null && echo "closed payment-flow"
sleep 3
show

echo "### READ-BACK: can the tracker table be reconstructed from the board alone?"
gh project item-list "$P" --owner "$OWNER" --format json \
  -q '.items[] | [(.milestone.title // "-"), .title, (."capstan Status" // "<unset>"), (.content.number|tostring)] | @tsv'

# ANSWER (see decisions 656 and 657):
#  - Capstan's four statuses work on a CUSTOM single-select and survive closure.
#  - The BUILT-IN Status field is unusable: GitHub's own workflow set it to Done
#    on close for both issues, collapsing merged and dropped into one value.
#  - Effort/Slice/Status read back in ONE item-list call. The commit does not:
#    it lives in a comment and costs one more call per slice.
#  - gh has no `project field-edit`, so the custom field must be created and the
#    built-in Status cannot be repurposed from the CLI.
