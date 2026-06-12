#!/usr/bin/env bash
# Bump the skill version everywhere it lives:
#   .claude-plugin/plugin.json        (.version)
#   .claude-plugin/marketplace.json   (.metadata.version)
#   skills/storesynk-audit/SKILL.md   ("This skill is version **x.y.z**")
#
# Usage:   scripts/bump-version.sh 1.0.2
# Release: commit + push, then `claude plugin tag && git push origin --tags`

set -euo pipefail

NEW="${1:?usage: scripts/bump-version.sh <version, e.g. 1.0.2>}"
[[ "$NEW" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || { echo "Invalid version: $NEW (expected x.y.z)" >&2; exit 1; }

cd "$(dirname "$0")/.."

jq --arg v "$NEW" '.version = $v' .claude-plugin/plugin.json > .claude-plugin/plugin.json.tmp \
  && mv .claude-plugin/plugin.json.tmp .claude-plugin/plugin.json

jq --arg v "$NEW" '.metadata.version = $v' .claude-plugin/marketplace.json > .claude-plugin/marketplace.json.tmp \
  && mv .claude-plugin/marketplace.json.tmp .claude-plugin/marketplace.json

perl -pi -e "s/This skill is version \*\*[0-9]+\.[0-9]+\.[0-9]+\*\*/This skill is version **${NEW}**/" \
  skills/storesynk-audit/SKILL.md

echo "Bumped to ${NEW}:"
echo "  plugin.json:      $(jq -r .version .claude-plugin/plugin.json)"
echo "  marketplace.json: $(jq -r .metadata.version .claude-plugin/marketplace.json)"
echo "  SKILL.md:         $(grep -oE 'This skill is version \*\*[0-9.]+\*\*' skills/storesynk-audit/SKILL.md | grep -oE '[0-9.]+')"
echo
echo "Next: git add -A && git commit -m \"v${NEW}\" && git push && claude plugin tag && git push origin --tags"
