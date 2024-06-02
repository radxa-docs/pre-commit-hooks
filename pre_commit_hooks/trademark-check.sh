#!/usr/bin/env bash

check() {
    local ret=0 registered=(
        "Fogwise"
    )

    # Add missing (r) to trademarks
    for i in "${registered[@]}"; do
        if grep -E "$i " "$1"
        then
            echo "$1: $i: (r) missing on trademark." >&2
            ret=1
            if ! $DRY_RUN
            then
                sed -i -E "s/$i /${i}® /g" "$1"
            fi
        fi
    done

    return $ret
}
