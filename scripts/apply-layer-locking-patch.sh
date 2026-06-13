#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"

ZMK_DIR="$(realpath "${1:-$REPO_DIR/src}")"
PATCH_FILE="$(realpath "${2:-$REPO_DIR/patches/moergo-zmk-layer-locking.patch}")"
TOGGLE_BINDING="$ZMK_DIR/app/dts/bindings/behaviors/zmk,behavior-toggle-layer.yaml"

if grep -q "locking:" "$TOGGLE_BINDING"; then
    echo "ZMK layer locking already present; skipping patch" >&2
    exit 0
fi

git -C "$ZMK_DIR" apply --check "$PATCH_FILE"
git -C "$ZMK_DIR" apply "$PATCH_FILE"
echo "Applied ZMK layer locking patch" >&2
