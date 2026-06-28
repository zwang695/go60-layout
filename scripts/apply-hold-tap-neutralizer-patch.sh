#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"

ZMK_DIR="$(realpath "${1:-$REPO_DIR/src}")"
PATCH_FILE="$(realpath "${2:-$REPO_DIR/patches/moergo-zmk-hold-tap-neutralizer.patch}")"
HOLD_TAP="$ZMK_DIR/app/src/behaviors/behavior_hold_tap.c"

if grep -q "hold_while_undecided_neutralizer" "$HOLD_TAP"; then
    echo "ZMK hold-tap neutralizer already present; skipping patch" >&2
    exit 0
fi

git -C "$ZMK_DIR" apply --check "$PATCH_FILE"
git -C "$ZMK_DIR" apply "$PATCH_FILE"
echo "Applied ZMK hold-tap neutralizer patch" >&2
