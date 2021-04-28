#!/usr/bin/env bash

# shellcheck disable=SC2034
plugin='tigervnc-java-viewer'
# shellcheck disable=SC2034
icon_file='tigervnc.png'
# shellcheck disable=SC2034
desktop_file='tigervnc.desktop'
# shellcheck disable=SC2034
jar_file='tigervnc.jar'
# shellcheck disable=SC2034
wrapper_file="vncviewer"

log() {
    echo "$@"
}

log_stream() {
    while read -r f; do echo "$plugin: $f"; done
}

error() {
    echo "$@" >&2
}

error_stream() {
    log_stream >&2
}

replace_in_text() {
    (
        set -euo pipefail

        local pattern="$1"
        local replacement="$2"

        local escaped_pattern
        escaped_pattern="$(echo -n "$pattern" | sed 's!/!\\/!g')"
        local escaped_replacement
        escaped_replacement="$(echo -n "$replacement" | sed -e 's/\\/\\\\/g' -e 's/&/\\\&/g' -e 's!/!\\/!g')"

        sed -E "s/$escaped_pattern/$escaped_replacement/g"
    )
}

ascii_check() {
    iconv --from-code=us-ascii --to-code=us-ascii
}

escape_for_desktop_entry() {
    # Note that \ is escaped twice, as per:
    # https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#recognized-keys
    (
        set -euo pipefail

        printf '"' &&
        replace_in_text '\\' '\\' |
        replace_in_text '"'  '\"' |
        replace_in_text '`'  '\`' |
        replace_in_text '\$' '\$' |
        replace_in_text '\r' '\r' |
        replace_in_text '\t' '\t' |
        replace_in_text ' '  '\s' |
        tr '\n' '\t'              |
        replace_in_text '\t' '\n' |
        replace_in_text '\\' '\\' |
        tr '[:cntrl:]' '\xFF' |
        ascii_check &&
        printf '"'
    )
}

desktop_integrate() { (
    set -euo pipefail

    local version="${1?-desktop_integrate needs a version}"
    local target_icon_file="$HOME/.local/share/icons/hicolor/64x64/apps/asdf-$plugin-$version.png"
    local target_desktop_file="$HOME/.local/share/applications/asdf-$plugin-$version.desktop"

    install -d "$(dirname "$target_icon_file")"
    install -d "$(dirname "$target_desktop_file")"

    local exec_path="$(echo -n "$(asdf where "$plugin" "$version")/bin/$wrapper_file" | escape_for_desktop_entry)"
    replace_in_text '@version@' "$version" < "$share_dir/$desktop_file" |
        replace_in_text '@plugin@' "$plugin" |
        replace_in_text '@wrapper_file@' "$exec_path" > "$target_desktop_file"
    chmod a+x "$target_desktop_file"

    cp "$share_dir/$icon_file" "$target_icon_file"
); }


desktop_db_update() { (
    set -euo pipefail

    gtk-update-icon-cache -t -q "$HOME/.local/share/icons/hicolor/"
    update-desktop-database "$HOME/.local/share/applications/"
); }
