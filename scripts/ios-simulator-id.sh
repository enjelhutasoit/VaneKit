#!/usr/bin/env bash
# Prints the UDID of the first available iPhone simulator.
set -euo pipefail

udid="$(
  xcrun simctl list devices available iPhone \
    | grep -E '^[[:space:]]+iPhone' \
    | head -n 1 \
    | sed -E 's/.*\(([0-9A-Fa-f-]{36})\).*/\1/'
)"

if [[ -z "${udid}" ]]; then
  echo "No available iPhone simulator found." >&2
  exit 1
fi

echo "${udid}"