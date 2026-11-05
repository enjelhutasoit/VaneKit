#!/usr/bin/env bash
# Tests for scripts/release-notes.sh.
# Run: bash scripts/tests/release_notes_test.sh
set -uo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
script="${script_dir}/../release-notes.sh"
work="$(mktemp -d)"
trap 'rm -rf "${work}"' EXIT
changelog="${work}/CHANGELOG.md"
failures=0
output=""
status=0

write_changelog() {
  cat >"${changelog}" <<'EOF'
# Changelog

## [Unreleased]

## [1.1.0-rc.1] - 2026-01-02

- Candidate notes.

## [1.0.0] - 2026-01-01

- First stable notes.

## [0.9.0] - 2025-12-01
EOF
}

run() {
  output="$(CHANGELOG_FILE="${changelog}" bash "${script}" "$@" 2>/dev/null)"
  status=$?
}

fail() {
  echo "FAIL ${1}: ${2}"
  failures=$((failures + 1))
}

expect_status() {
  [[ "${status}" -eq "$2" ]] || fail "$1" "expected exit $2, got ${status}"
}

expect_contains() {
  [[ "${output}" == *"$2"* ]] || fail "$1" "output does not contain '$2'"
}

expect_not_contains() {
  [[ "${output}" != *"$2"* ]] || fail "$1" "output unexpectedly contains '$2'"
}

test_stableTag_returnsOnlyThatSection() {
  run v1.0.0
  expect_status "${FUNCNAME[0]}" 0
  expect_contains "${FUNCNAME[0]}" "First stable notes."
  expect_not_contains "${FUNCNAME[0]}" "Candidate notes."
  expect_not_contains "${FUNCNAME[0]}" "## ["
}

test_prereleaseTag_returnsPrereleaseSection() {
  run v1.1.0-rc.1
  expect_status "${FUNCNAME[0]}" 0
  expect_contains "${FUNCNAME[0]}" "Candidate notes."
  expect_not_contains "${FUNCNAME[0]}" "First stable notes."
}

test_unknownVersion_fails() {
  run v2.0.0
  expect_status "${FUNCNAME[0]}" 4
}

test_stableTag_doesNotMatchPrereleaseSection() {
  run v1.1.0
  expect_status "${FUNCNAME[0]}" 4
}

test_emptySection_fails() {
  run v0.9.0
  expect_status "${FUNCNAME[0]}" 4
}

test_invalidTags_failBeforeReadingChangelog() {
  local tag
  for tag in "1.0.0" "v1.0" "v01.0.0" "v1.0.0.0" "v1.0.0-" "v1.0.0+build" ""; do
    run "${tag}"
    expect_status "${FUNCNAME[0]} (tag '${tag}')" 2
  done
}

test_missingTagArgument_fails() {
  run
  expect_status "${FUNCNAME[0]}" 2
}

test_missingChangelog_fails() {
  output="$(CHANGELOG_FILE="${work}/does-not-exist.md" bash "${script}" v1.0.0 2>/dev/null)"
  status=$?
  expect_status "${FUNCNAME[0]}" 3
}

write_changelog
test_stableTag_returnsOnlyThatSection
test_prereleaseTag_returnsPrereleaseSection
test_unknownVersion_fails
test_stableTag_doesNotMatchPrereleaseSection
test_emptySection_fails
test_invalidTags_failBeforeReadingChangelog
test_missingTagArgument_fails
test_missingChangelog_fails

if [[ "${failures}" -ne 0 ]]; then
  echo "${failures} failure(s)"
  exit 1
fi
echo "All release-notes tests passed"
