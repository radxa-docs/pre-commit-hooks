#!/usr/bin/env bash

check() {
    local ret=0

    # Image should be webp
    if ! [[ "$1" =~ .*\.webp ]]
    then
        echo "$1: forbidden image format. Use webp instead." >&2
        ret=1
        if ! $DRY_RUN
        then
            local webp="${1%.*}.webp"
            if [[ -f "$webp" ]]
            then
                echo "$1: found existing webp file. Will not attempt to fix this issue." >&2
                return $ret
            fi

            cwebp "$1" -o "$webp" &>/dev/null
            rm "$1"
            grep -rl "/$(basename "$1")" . --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=build | xargs sed -i -E 's|(!\[.+\]\(.*/)('"$(basename "$1")"')\)|\1'"$(basename "$webp")"')|g'
        fi
    fi

    return $ret
}
