# Versioning and deprecation

VaneKit follows [Semantic Versioning 2.0.0](https://semver.org/spec/v2.0.0.html).

## Public API

Every `public` symbol of the `VaneKit` product. Internal symbols, snapshot
images and documentation text are not public API.

## What changes the version

| Change | Version |
|---|---|
| Remove or rename a public symbol; change a signature or documented behavior | Major |
| Add a case to a public enum | Major |
| Raise the minimum OS version or the Swift tools version | Major |
| Add public symbols or other backward-compatible additions | Minor |
| Change token values (for example a color) | Minor, listed under "Changed" |
| Bug fix, documentation, internal refactor without visible change | Patch |

Adding an enum case is treated as breaking because consumers build the package
from source, so an exhaustive `switch` in their code would stop compiling.

Token value changes must keep the contrast tests green and update the snapshot
references in the same release.

## Deprecation policy

1. Mark the symbol with `@available(*, deprecated, message: "...", renamed: "...")`.
2. Ship the replacement in the same release.
3. Announce it under "Deprecated" in `CHANGELOG.md`.
4. Keep it through at least the next minor release.
5. Remove it only in a major release, listed under "Removed".

## Pre-releases

Release candidates use tags such as `v1.1.0-rc.1` and are published as
GitHub pre-releases. Build metadata (`+build`) is not used in tags.
