#!/usr/bin/env bash

check() {
    local ret=0 i="" import="" comps=(
        "theme/Tabs"
        "theme/TabItem"
        "theme/DocCardList"
    )

    # Globally enabled components does not need to be imported again
    for i in "${comps[@]}"
    do
        import="import $(basename "$i") from ['\"]\@$(dirname "$i")\/$(basename "$i")['\"];\n"
        if pcregrep -M "$import" "$1" >/dev/null
        then
            echo "$1: $i is globally enabled." >&2
            ret=1
            if ! $DRY_RUN
            then
                perl -i -pe "s/$import//g" "$1"
            fi
        fi
    done

    return $ret
}
