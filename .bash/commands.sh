#!/bin/bash

# resource bashrc
sob() {
    echo "sourced ~/.bashrc."
    source ~/.bashrc
}

# cd into SCHOOL directory
cds () {
    if [ -z $1 ]; then
        ll "$SCHOOL"
        return
    fi

    echo "Use popd to go back to $(pwd)."
    pushd . > /dev/null
    cd "$SCHOOL/$1"
}

# get password from list
pass() {
    local PASSWORDS=~/.bash/assets/passwords.json
    if [ -z "$1" ]; then
        echo "Expecting 1 argument from list:" && echo ""
        jq -r "keys[]" "$PASSWORDS"
        return
    fi

    local val=$(jq -r '."'$1'".[] | "\(.key): \(.val)"' "$PASSWORDS" 2>/dev/null)
    if [ -z "$val" ]; then
        echo Invalid key.
        return
    fi

    echo "$val"
}

# launch zoom based on list
zoom() {
    local ZOOM_LINKS=~/.bash/assets/zoom_links.json
    if [ -z "$1" ]; then
        echo "Expecting 1 argument from list:" && echo ""
        jq -r '.[] | if .temp == true then "\(.key) (temp)" else "\(.key)" end' "$ZOOM_LINKS"
        return
    fi

    local link=$(jq -r '.[] | select(.key == "'$1'") | .val' "$ZOOM_LINKS")
    if [ -z "$link" ]; then
        echo Invalid key.
        return
    fi

    start "$link"
}

# view school schedule (chatgpt code)
sched() {
    local txt=~/.bash/assets/sched.txt
    local day=$1
    
    if [ -z $day ]; then
        cat "$txt"
        return
    fi

    awk -v day="--- ${day^}" '
    tolower($0) ~ tolower(day) { found = 1; print; next }
    /^---/ && found { exit } 
    found { print }                 
    ' "$txt"
}

vicd()
{
    local dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}

source ~/.bash/odoc.sh
source ~/.bash/tunt.sh
