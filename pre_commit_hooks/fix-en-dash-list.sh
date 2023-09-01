#!/usr/bin/env bash

check() {
    local ret=0

    # Detect fake Makrdown listing with en dash
    if grep -E '^\s*–\s+' "$1"
    then
        echo "$1: En dash used in Markdown listing." >&2
        ret=1
        if ! $DRY_RUN
        then
            sed -i -E 's/^(\s*)–(\s+)/\1-\2/g' "$1"
        fi
    fi

    return $ret
}
