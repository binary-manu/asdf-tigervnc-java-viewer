#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../defs.sh
. "$(dirname "$0")/../defs.sh"

{
    rm -fv "$HOME/.local/share/icons/hicolor/64x64/apps/asdf-$plugin-"*".png"
    rm -fv "$HOME/.local/share/applications/asdf-$plugin-"*".desktop"
} | while read -r f; do echo "$plugin: $f"; done

gtk-update-icon-cache -t -q "$HOME/.local/share/icons/hicolor/"
update-desktop-database "$HOME/.local/share/applications/"
