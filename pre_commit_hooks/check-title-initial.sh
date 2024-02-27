#!/usr/bin/env bash

check() {
    local ret=0

    # Check if the first letter of the title is capitalized
    if grep -qE '^# [a-z]' "$1" >/dev/null
    then
        ret=1
        echo "$1: First letter of the title should be capitalized" >&2
        if ! $DRY_RUN
        then
            sed -i -E 's/^# ([a-z])/# \U\1/' "$1"
        fi
    fi

    return $ret
}
