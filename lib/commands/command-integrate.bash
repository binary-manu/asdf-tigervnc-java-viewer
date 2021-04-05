#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../defs.sh
. "$(dirname "$0")/../defs.sh"
exec > >(log_stream) 2> >(error_stream)
share_dir="$(dirname "$0")/../../share"


case "$#" in
0)
    asdf list "$plugin" | while read -r version; do
        log "creating desktop entry for version $version"
        desktop_integrate "$version"
    done
    ;;
1)
    version="$1"
    if ! asdf where "$plugin" "$version" > /dev/null 2>&1; then
        error "version $version is not installed"
        exit 1
    fi
    log "creating desktop entry for version $version"
    desktop_integrate "$version"
    ;;
*)
    error "integrate requires 0 or 1 arguments, $# given"
    exit 1
    ;;
esac

desktop_db_update
