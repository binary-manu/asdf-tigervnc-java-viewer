#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../defs.sh
. "$(dirname "$0")/../defs.sh"
share_dir="$(dirname "$0")/../../share"

case "$#" in
0)
    asdf list "$plugin" | while read -r version; do
        echo "$plugin: creating desktop entry for version $version"
        desktop_integrate "$version"
    done
    ;;
1)
    version="$1"
    if ! asdf where "$plugin" "$version" > /dev/null 2>&1; then
        echo "$plugin: version $version is not installed" >&2
        exit 1
    fi
    echo "$plugin: creating desktop entry for version $version"
    desktop_integrate "$version"
    ;;
*)
    echo "$plugin: integrate requires 0 or 1 arguments, $# given" >&2
    exit 1
    ;;
esac

desktop_db_update
