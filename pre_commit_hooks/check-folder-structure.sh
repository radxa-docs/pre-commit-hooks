#!/usr/bin/env bash

check() {
    local ret=0

    # I18n folder structure should mirror each other
    if [[ "$1" == docs/* ]] && [[ ! -e "i18n/en/docusaurus-plugin-content-docs/current/${1#docs/}" ]]
    then
        ret=1
        echo "$1: missing English translation." >&2
    elif [[ "$1" == i18n/en/docusaurus-plugin-content-docs/current/* ]] && [[ ! -e "docs/${1#i18n/en/docusaurus-plugin-content-docs/current/}" ]]
    then
        ret=1
        echo "$1: missing Chinese translation." >&2
    fi

    return $ret
}
