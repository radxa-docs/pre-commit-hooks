#!/usr/bin/env bash

check() {
    local ret=0

    # Markdown title will be sidebar_label by default
    # This forces us to use concise title
    if pcregrep -M '(^---\s*$)((.|\n)*)(\n^sidebar_label:.*$)((.|\n)*)(^---\s*$)' "$1" >/dev/null
    then
        echo "$1: sidebar_label is not allowed." >&2
        ret=1
        if ! $DRY_RUN
        then
            perl -i -pe 'BEGIN{undef $/;} s/(^---\s*$)((.|\n)*)(\n^sidebar_label:.*$)((.|\n)*)(^---\s*$)/\1\2\5\7/gm' "$1"
        fi
    fi

    return $ret
}
