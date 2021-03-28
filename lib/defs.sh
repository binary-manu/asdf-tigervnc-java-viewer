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
wrapper_file="tigervnc"

replace_in_text() {
    (
        set -eo pipefail

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
        set -eo pipefail

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
