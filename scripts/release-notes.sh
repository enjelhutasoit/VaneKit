#!/usr/bin/env bash
# Prints the CHANGELOG section for a SemVer release tag.
# Usage: release-notes.sh <tag>       (for example v1.2.0 or v1.3.0-rc.1)
# Env:   CHANGELOG_FILE               (default: CHANGELOG.md)
# Exit:  0 ok, 2 invalid tag, 3 changelog missing, 4 section missing or empty
set -euo pipefail

readonly EXIT_INVALID_TAG=2
readonly EXIT_NO_CHANGELOG=3
readonly EXIT_NO_SECTION=4
readonly SEMVER_TAG='^v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-[0-9A-Za-z.-]+)?$'

tag="${1:-}"
changelog="${CHANGELOG_FILE:-CHANGELOG.md}"

if [[ ! "${tag}" =~ ${SEMVER_TAG} ]]; then
  echo "Invalid SemVer tag: '${tag}' (expected vMAJOR.MINOR.PATCH[-prerelease])" >&2
  exit "${EXIT_INVALID_TAG}"
fi

if [[ ! -f "${changelog}" ]]; then
  echo "Changelog not found: ${changelog}" >&2
  exit "${EXIT_NO_CHANGELOG}"
fi

version="${tag#v}"
notes="$(awk -v header="## [${version}]" '
  index($0, header) == 1 { found = 1; next }
  found && index($0, "## [") == 1 { exit }
  found { print }
' "${changelog}")"

if ! grep -q '[^[:space:]]' <<<"${notes}"; then
  echo "No release notes for ${version} in ${changelog}" >&2
  exit "${EXIT_NO_SECTION}"
fi

printf '%s\n' "${notes}"
