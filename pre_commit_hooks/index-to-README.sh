#!/usr/bin/env bash

check() {
    local ret=0

    # README.md is the preferred naming to have better integration with GitHub
    if [[ "$(basename "$1")" == "index.md" ]]
    then

        ret=1
        if [[ -e "$(dirname "$1")/README.md" ]]
        then
            echo "$1: index.md should not be created when there is README.md." >&23
            if ! $DRY_RUN
            then
                rm "$1"
            fi
        else
            echo "$1: index.md should be named to README.md." >&2
            if ! $DRY_RUN
            then
                mv "$1" "$(dirname "$1")/README.md"
            fi
        fi
    fi

    return $ret
}
