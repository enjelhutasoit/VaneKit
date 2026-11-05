# Accessibility

What VaneKit guarantees, what it only supports, and what remains your responsibility.

## Verified by automated tests

- Text color pairs in both palettes meet a 4.5:1 contrast ratio, and accent
  and critical colors meet 3:1 against the backgrounds. Component color sets
  are checked the same way.
- A gallery snapshot renders at a large Dynamic Type size, recorded on CI.

## Supported by construction, not automated

- Typography uses system text styles, so Dynamic Type applies.
- Interactive components have a 44 pt minimum size that grows with text.
- Field errors use an icon plus text, not color alone.
- Decorative icons are hidden from VoiceOver, and row and empty-state text is
  read as one element.

## Your responsibility

- Provide localized strings and meaningful labels.
- Wrap tall content, such as an empty state at large text sizes, in a `ScrollView`.
- Test with VoiceOver on a device.
- Disabled controls are intentionally not held to contrast requirements.

## Not verified

VoiceOver output on a device, Switch Control, right-to-left layouts, and the
Increase Contrast and Reduce Motion settings.
