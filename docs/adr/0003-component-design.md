# ADR-0003: Component design

## Context
Components must be adoptable by many teams, accessible by default, and testable
without a rendering harness.

## Decision
- The button is a `ButtonStyle`, so the system `Button` semantics are preserved.
- Per-variant colors are plain data (`VaneComponentColors`) and contrast is
  asserted by unit tests in both color schemes.
- All text is supplied by the caller as an already localized `String`; the
  library ships no string resources.
- Field messages are resolved by a pure function: error beats helper, blank
  input is ignored. Errors use an icon plus text, not color alone.
- Tap targets have a 44 pt minimum and grow with Dynamic Type.

## Alternatives
- A custom `VaneButton` view: simpler call site, but loses `Button` semantics.
- `LocalizedStringKey` parameters: would resolve in the wrong bundle.
- Snapshot tests only: would not catch contrast regressions at the token level.

## Consequences
- Callers own localization.
- View bodies are verified visually by snapshot tests later (PR5), not unit tests.
- VoiceOver output of the field is not yet verified on a device.
