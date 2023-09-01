#!/usr/bin/env bash

check() {
    local ret=0

    # Image should be webp
    if ! [[ "$1" =~ .*\.webp ]]
    then
        echo "$1: forbidden image format. Use webp instead." >&2
        ret=1
    fi

    return $ret
}
