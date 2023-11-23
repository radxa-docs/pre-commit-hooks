#!/usr/bin/env bash

main() {
    local TEMP ret=0

    local DRY_RUN="false"
    export DRY_RUN

    while getopts "hd" TEMP
    do
        case "$TEMP" in
            d)
                echo "Dry run. Files will not be changed!"
                DRY_RUN="true"
                ;;
            h|?)
                echo "$TEMP" "$(basename "$0") <files>"
                return
                ;;
        esac
    done
    shift $((OPTIND - 1))

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
