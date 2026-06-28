#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"

ZMK_DIR="$(realpath "${1:-$REPO_DIR/src}")"
PATCH_FILE="$(realpath "${2:-$REPO_DIR/patches/moergo-zmk-mouse-mode-indicator.patch}")"
RGB_UNDERGLOW="$ZMK_DIR/app/src/rgb_underglow.c"

if grep -q "mouse_mode_indicator" "$RGB_UNDERGLOW"; then
    echo "ZMK mouse mode indicator already present; skipping patch" >&2
    exit 0
fi

git -C "$ZMK_DIR" apply --check "$PATCH_FILE"
git -C "$ZMK_DIR" apply "$PATCH_FILE"
echo "Applied ZMK mouse mode indicator patch" >&2
