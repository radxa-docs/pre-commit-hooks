#!/usr/bin/env bash

slug() {
    local file="$1" ret

    ret="$(jq -r ".link.slug" "$file")"

    if [[ "$ret" != "null" ]] && [[ "$(dirname "$file")" != *"$ret" ]]
    then
        echo "slug: $ret"
    fi
}

jq_printf() {
    local field="$1" file="$2" prefix="${3:-}" ret

    ret="$(jq -r "$field" "$file")"
    if [[ "$ret" == "null" ]]
    then
        return
    else
        echo "${prefix:+$prefix }$ret"
    fi
}

check() {
    local ret=0

    if [[ "$(basename "$1")" == "_category_.json" ]]
    then
        # _category_.json causes more trouble that what is worth
        # Convert it to README.md
        ret=1
        if [[ -e "$(dirname "$1")/README.md" ]]
        then
            echo "$1: Redundent _category_.json when there is README.md." >&2
        else
            echo "$1: _category_.json should be replaced by README.md." >&2

            if ! $DRY_RUN
            then
                cat << EOF > "$(dirname "$1")/README.md"
---
$(jq_printf ".position" "$1" "sidebar_position:")
$(slug "$1")
---

# $(jq_printf .label "$1")

$(jq_printf ".link.description" "$1")

<DocCardList />
EOF
            fi
        fi

        if ! $DRY_RUN
        then
            rm "$1"
        fi
    fi

    return $ret
}
