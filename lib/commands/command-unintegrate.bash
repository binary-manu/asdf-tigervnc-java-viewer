#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../defs.sh
. "$(dirname "$0")/../defs.sh"
exec > >(log_stream) 2> >(error_stream)

case "$#" in
0)
    rm -fv "$HOME/.local/share/icons/hicolor/64x64/apps/asdf-$plugin-"*".png"
    rm -fv "$HOME/.local/share/applications/asdf-$plugin-"*".desktop"
    ;;
1)
    version="$1"
    rm -fv "$HOME/.local/share/icons/hicolor/64x64/apps/asdf-$plugin-$version.png"
    rm -fv "$HOME/.local/share/applications/asdf-$plugin-$version.desktop"
    ;;
*)
    error "unintegrate requires 0 or 1 arguments, $# given"
    exit 1
    ;;
esac

desktop_db_update
