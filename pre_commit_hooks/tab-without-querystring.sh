#!/usr/bin/env bash

check() {
    local ret=0

    # Tabs must come with queryString
    if grep -E '<\s*Tabs' "$1" | grep -v -E queryString
    then
        echo "$1: Tabs must come with queryString." >&2
        ret=1
        if ! $DRY_RUN
        then
            sed -i -E 's/(<\s*Tabs)/<Tabs queryString/g' "$1"
        fi
    fi

    return $ret
}
