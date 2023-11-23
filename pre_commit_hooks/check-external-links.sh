#!/usr/bin/env bash

check() {
    local ret=0 EXTRA_CURL_ARGS=() err=0

    # Check if links can return valid response
    # High false positive rate
    while read -r
    do
        EXTRA_CURL_ARGS=()
        if ! grep -E "https?://mega.nz" >/dev/null <<< "$REPLY"
        then
            EXTRA_CURL_ARGS+=("-I")
        fi

        curl -sfLm 5 -o /dev/null "${EXTRA_CURL_ARGS[@]}" "$REPLY"; err=$?
        case "$err"
        in
            0) ;;
            *)
                echo "$1: Broken link ($err): $REPLY" >&2
                ret=1
                ;;
        esac
    done < <(grep -Eo "https?://[^\) ]+" "$1")

    return $ret
}
