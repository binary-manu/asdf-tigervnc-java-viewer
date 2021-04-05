#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../defs.sh
. "$(dirname "$0")/../defs.sh"

case "$#" in
0)
    {
        rm -fv "$HOME/.local/share/icons/hicolor/64x64/apps/asdf-$plugin-"*".png"
        rm -fv "$HOME/.local/share/applications/asdf-$plugin-"*".desktop"
    } | while read -r f; do echo "$plugin: $f"; done
    ;;
1)
    version="$1"
    {
        rm -fv "$HOME/.local/share/icons/hicolor/64x64/apps/asdf-$plugin-$version.png"
        rm -fv "$HOME/.local/share/applications/asdf-$plugin-$version.desktop"
    } | while read -r f; do echo "$plugin: $f"; done
    ;;
*)
    echo "$plugin: unintegrate requires 0 or 1 arguments, $# given" >&1
    exit 1
    ;;
esac

desktop_db_update
