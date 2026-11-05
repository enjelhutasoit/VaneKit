# ADR-0007: Release flow

## Context
Consumers adopt VaneKit by Git tag through Swift Package Manager. A wrong or
undocumented tag is hard to retract once consumers have resolved it.

## Decision
- Releases are triggered by pushing a `v*` tag.
- Tag format and changelog content are validated by `scripts/release-notes.sh`,
  covered by shell tests that run on Linux and macOS in CI.
- The workflow verifies the tagged commit is an ancestor of `origin/main`, runs
  `swift test`, and creates the GitHub Release with the changelog section as notes.
- Pre-release tags are published as pre-releases; build metadata is not accepted.
- Published tags are immutable; fixes ship as new patch releases.
- Adding an enum case is a major change (see `docs/versioning.md`).

## Alternatives
- release-please or semantic-release: automatic versioning, but new tooling and
  a commit convention for a single small package.
- Manual releases: no guard against a bad tag or an empty changelog.
- Re-running snapshot and DocC jobs in the release workflow: more coverage,
  but duplicates CI and adds cost; the process requires a green `main` instead.

## Consequences
- The release job does not itself prove that snapshot tests passed.
- Choosing the version number is a human judgement based on the policy.
- Strict enum rules make some additions expensive.
