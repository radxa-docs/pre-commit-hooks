#!/usr/bin/env bash

main() {
    local TEMP ret=0

    if ! TEMP="$(getopt -o "hd" -l "help,dry-run" -n "$0" -- "$@")"
    then
        return 1
    fi
    eval set -- "$TEMP"

    local DRY_RUN="false"
    export DRY_RUN

    while true
    do
        TEMP="$1"
        shift
        case "$TEMP" in
            -h|--help)
                echo "$(basename "$0") <files>"
                return
                ;;
            -d|--dry-run)
                DRY_RUN="true"
                ;;
            --)
                break
                ;;
        esac
    done

    # loading check function
    # shellcheck source=/dev/null
    source "$SCRIPT_DIR/$1.sh"
    shift

    while (( $# != 0 ))
    do
        local FILE="$1"
        shift

        if ! check "$FILE"
        then
            ret=1
        fi
    done

    return $ret
}

set -euo pipefail
shopt -s nullglob
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

main "$@"
