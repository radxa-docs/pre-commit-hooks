#!/usr/bin/env bash

check() {
    local ret=0

    # Tabs must come with queryString
    if grep -P '<\s*Tabs\s*((?!queryString).)*>' "$1"
    then
        echo "$1: Tabs must come with queryString." >&2
        ret=1
        if ! $DRY_RUN
        then
            perl -i -pe 's/<\s*Tabs(((?!queryString).)*)>/<Tabs\1 queryString>/g' "$1"
        fi
    fi

    return $ret
}
