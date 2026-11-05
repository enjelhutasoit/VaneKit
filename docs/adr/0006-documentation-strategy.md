# ADR-0006: Documentation strategy

## Context
The library must be adoptable by teams that did not write it. Documentation
that is not built in CI drifts.

## Decision
- Per-symbol documentation is written as `///` comments; the DocC catalog
  holds only articles and symbol curation.
- DocC is built in CI with `xcodebuild docbuild`; the archive is uploaded as an
  artifact. No extra package dependency.
- The adoption guide contains process recommendations only, no adoption claims.
- The accessibility page separates automated, by-construction and unverified items.
- The unused `VaneKit` namespace enum is removed to avoid dead code and an
  ambiguous root symbol.
- Fastlane is not used here: a single package with `swift test` and `xcodebuild`
  does not need it.

## Alternatives
- swift-docc-plugin: static-hosting transform, but adds a dependency.
- Hosting on GitHub Pages: more setup than the value for a portfolio library.
- A Markdown link checker script: not added; DocC covers symbol links and
  relative Markdown links are reviewed manually.

## Consequences
- Whether `--warnings-as-errors` is enforced through `OTHER_DOCC_FLAGS` was
  verified manually, not assumed (see the PR notes).
- Code samples in articles are not compiled; they mirror the snapshot gallery.
- Docs are not hosted online; reviewers open the archive in Xcode.
