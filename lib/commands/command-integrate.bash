#!/usr/bin/env bash

set -euo pipefail

# shellcheck source=../defs.sh
. "$(dirname "$0")/../defs.sh"
share_dir="$(dirname "$0")/../../share"

asdf list "$plugin" | while read -r version; do
    echo "$plugin: creating desktop entry for version $version"
    target_icon_file="$HOME/.local/share/icons/hicolor/64x64/apps/asdf-$plugin-$version.png"
    target_desktop_file="$HOME/.local/share/applications/asdf-$plugin-$version.desktop"

    install -d "$(dirname "$target_icon_file")"
    install -d "$(dirname "$target_desktop_file")"

    exec_path="$(echo -n "$(asdf where "$plugin" "$version")/bin/$wrapper_file" | escape_for_desktop_entry)"
    replace_in_text '@version@' "$version" < "$share_dir/$desktop_file" |
        replace_in_text '@plugin@' "$plugin" |
        replace_in_text '@wrapper_file@' "$exec_path" > "$target_desktop_file"
    chmod a+x "$target_desktop_file"

    cp "$share_dir/$icon_file" "$target_icon_file"
done

gtk-update-icon-cache -t -q "$HOME/.local/share/icons/hicolor/"
update-desktop-database "$HOME/.local/share/applications/"
