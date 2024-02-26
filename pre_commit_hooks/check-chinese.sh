#!/usr/bin/env bash

check() {
    local ret=0

    # Check if English documents contain Chinese
    if grep -qP "[\p{Script=Han}]" "$1" >/dev/null
    then
        ret=1
        echo "$1: contains Chinese characters and it's English documents." >&2
    fi

    return $ret
}
