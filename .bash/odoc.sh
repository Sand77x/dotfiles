#!/bin/bash

odoc() {
    local DEF_GREP_N=10
    local DOCDIR="$HOME/Documents/docs"
    local HELP="$HOME/.bash/help/odoc.txt"
    local mode="$1"
    local arg="$2"
    local editor="v"

    # Error in input / show help
    if [ -z "$mode" ] || ([ -z "$arg" ] && [ "$mode" != "l" ] && [ "$mode" != "e" ] && [ "$mode" != "s" ]); then
        cat "$HELP"
        return
    fi

    local file="$DOCDIR/$arg.md"

    case "$mode" in 
        "a")
            if [ -e "$file" ]; then
                echo "Doc already exists."
                return
            fi
            touch "$file"
            echo "Doc created: $file" ;;

        "l")
            ls "$DOCDIR" ;;

        "rn")
            if [ ! -e "$file" ]; then
                echo "Doc doesn't exist."
                return
            fi

            local new_name="$3"
            if [ -z "$new_name" ] || [ -e "$DOCDIR/$new_name.md" ]; then
                echo "Invalid rename target. Provide a new name as the third argument."
                return
            fi

            mv "$file" "$DOCDIR/$new_name.md"
            echo "Doc renamed to: $new_name.md" ;;

        "s")
            # if no arg, open .scratch
            if [ -z "$arg" ]; then
                # if no scratch
                if [ ! -e "$DOCDIR/.scratch.md" ]; then
                    touch "$DOCDIR/.scratch.md" 
                    echo "# scratch" >> "$DOCDIR/.scratch.md"
                fi

                cat "$DOCDIR/.scratch.md"
                return
            fi

            if [ ! -e "$file" ]; then
                echo "Doc doesn't exist."
                return
            fi

            if [ -z "$3" ]; then
                cat "$file"
            else
                head -n "$3" "$file"
            fi ;;

        "gr")
            if [ ! -e "$file" ]; then
                echo "Doc doesn't exist."
                return
            fi

            if [ -z "$3" ]; then
                echo "Enter header to grep as 3rd arg."
                return
            fi

            if [ -z "$4" ]; then
                cat $file | grep "$3" -A $DEF_GREP_N
            else
                cat $file | grep "$3" -A "$4"
            fi ;;

        "e")
            # if no arg, open .scratch
            if [ -z "$arg" ]; then
                # if no scratch
                if [ ! -e "$DOCDIR/.scratch.md" ]; then
                    touch "$DOCDIR/.scratch.md" 
                    echo "# scratch" >> "$DOCDIR/.scratch.md"
                fi

                eval "$editor '$DOCDIR/.scratch.md'"
                return
            fi

            # Check if file exists
            if [ ! -e "$file" ]; then
                touch "$file"
            fi

            eval "$editor '$file'" ;;

        "d")
            if [ ! -e "$file" ]; then
                echo "Doc doesn't exist."
                return
            fi
            rm -i "$file" ;;

        *)
            echo "Invalid mode."
            echo "Usage: See $HELP for more details." ;;
    esac
}

source ~/.bash/odoc_completion.sh
