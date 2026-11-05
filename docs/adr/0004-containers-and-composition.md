# ADR-0004: Containers and composition

## Context
Card, list row and empty state are structural components. They should compose
with consumer views instead of owning behavior.

## Decision
- `VaneCard` takes a `@ViewBuilder` and only provides padding and surface.
- `VaneListRow` is generic over its trailing view and is not interactive;
  navigation and tap behavior stay with `Button` / `NavigationLink`.
- Row and empty-state text is grouped into one accessibility element; the
  decorative icon is hidden; the empty-state action stays a separate element.
- Blank optional strings are ignored through one shared helper.
- The card has no border; its separation from the background is decorative and
  not covered by contrast tests.

## Alternatives
- A `separator` color role for a card border: more tokens for a decorative effect.
- A row that owns tap handling: couples it to one navigation style.

## Consequences
- The card looks subtle on the light palette.
- Text pairs used here are already covered by the palette contrast tests.
- Screen reader output is not verified on a device.
