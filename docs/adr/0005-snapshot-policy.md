# ADR-0005: Snapshot and accessibility test policy

## Context
Components need visual regression coverage. Snapshot output can differ across
CPU architecture, OS version and Xcode version; the size of that difference is
not measured here.

## Decision
- Snapshot tests run on the iOS Simulator on a single CI runner (macos-15, arm64).
- Reference images are recorded from CI artifacts, never from a developer machine.
- Tolerance (precision 0.995, perceptual 0.98) is an initial guess to be tuned from data.
- Three snapshots only: gallery in light, dark, and large Dynamic Type.
- Color scheme and Dynamic Type are set through SwiftUI environment values.
- Snapshot files are compiled only for iOS, so `swift test` on macOS skips them.
- Accessibility coverage is: contrast unit tests, the large-Dynamic-Type snapshot,
  and system text styles. VoiceOver behavior is not automated.

## Alternatives
- macOS snapshots via a hosting view: no Dynamic Type and not the target platform.
- Recording on a developer Intel machine: differs from the CI renderer.
- Exact matching on both architectures: doubles the references and the maintenance.
- No snapshot tests: visual regressions would go unnoticed.

## Consequences
- References must be regenerated when the runner image, Xcode or iOS runtime changes.
- Tolerance can hide very small regressions.
- The snapshot library is a test-only dependency; SwiftPM may still fetch it
  for consumers (not verified).
