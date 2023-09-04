#!/usr/bin/env bash

check() {
    local ret=0

    # Image should be referenced by something
    if ! grep -q -I -r "/$(basename "$1")" . --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=build
    then
        echo "$1: unreferenced image." >&2
        ret=1
        if ! $DRY_RUN
        then
            rm "$1"
        fi
    fi

    return $ret
}
