#!/usr/bin/env bash

check() {
    local ret=0

    # queryString must be defined when groupId is not defined
    if grep -E '<\s*Tabs.*queryString' "$1" | grep -v -E 'groupId' | grep -v -E 'queryString\s*='
    then
        echo "$1: queryString must be defined when groupId is not defined." >&2
        ret=1
    fi

    return $ret
}
