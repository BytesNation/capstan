---
capstan_type: decision-record
---

# 0001. Rename the plugin from claude-tools to capstan

**Status**: accepted
**Date**: 2026-08-21

## Context

`claude-tools` collides with an existing, unrelated Claude Code plugin marketplace of the same name that ships a similar-sounding set of delegation plugins. The name is also purely descriptive, which the marketplace data argues against: among 9,000+ third-party entries the community plugins that gained traction carry distinctive names (Superpowers, Caveman, Context7) while descriptive names belong to Anthropic's own curated set.

The name is not cosmetic here. `name` in `plugin.json` is the skill namespace, so it is the string typed at every invocation and the prefix on every agent the Architect spawns. Renaming it later costs strictly more than renaming it now, because the migration cost scales with the install count.

## Decision

The plugin becomes `capstan`. Both names change: `plugin.json` `name`, which is the namespace, and the marketplace entry `name`, which is the install identifier. The GitHub repository renames to `BytesNation/capstan`. The marketplace id stays `bytesnation`.

## Alternatives

**Keep `claude-tools`.** Free, and leaves the collision in place along with a name that the ecosystem data says does not travel.

**Rename the namespace only, leaving the marketplace entry as `claude-tools`.** Verified to validate cleanly, and it would let existing installs update rather than reinstall. Rejected because every future user would then install a thing called `claude-tools` and receive skills called `capstan`, trading a one-time cost for permanent confusion.

**A name free across npm, GitHub orgs and PyPI.** Pursued and abandoned. Every candidate checked was taken on all three, as are `superpowers`, `caveman`, `context7`, `linear` and `vercel`. A markdown-only plugin publishes to none of those registries, so the constraint was self-imposed.

## Consequences

Every `/claude-tools:*` invocation becomes `/capstan:*` and the old namespace disappears. Because the install identifier changes too, existing installs cannot update across this; they uninstall and reinstall. That is what makes it 2.0.0.

The name no longer says what the plugin does, so `description` carries that load and its wording becomes load-bearing rather than decorative.

`capstan` is taken on npm, as a GitHub org, and on PyPI, and shares a name with a 377-star OSv packaging tool. None of those bind a plugin distributed through a marketplace, and the pairing that matters, capstan plus Claude, is unclaimed.

## Revisit when

Someone reports confusing this with the OSv tool or the npm VPS CLI in a way that costs a real install, or the plugin starts shipping something that needs an npm or PyPI package.
