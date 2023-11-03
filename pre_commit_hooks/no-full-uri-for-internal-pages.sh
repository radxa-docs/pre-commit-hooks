#!/usr/bin/env bash

check() {
    local ret=0

    # Prevent full URI for internal pages
    # This way Docusaurus knows a link is broken
    if grep -E ']\(https?://docs.radxa.com/' "$1"
    then
        echo "$1: Full URI used for internal page." >&2
        ret=1
        if ! $DRY_RUN
        then
            sed -i -E 's|]\(https?://docs.radxa.com/|](/|g' "$1"
        fi
    fi

    return $ret
}
