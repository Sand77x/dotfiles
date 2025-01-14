#!/bin/bash

# ~/.odoc_completion.sh
# Autocompletion for odoc command - suggest filenames without .md and full path

_odoc_complete() {
    local cur opts files
    cur="${COMP_WORDS[COMP_CWORD]}"  # Current word
    opts="a l rn s e d"              # Modes for the odoc command

    if [ $COMP_CWORD -eq 1 ]; then
        # Suggest modes (a, l, rn, s, e, d)
        COMPREPLY=($(compgen -W "$opts" -- "$cur"))
    elif [ $COMP_CWORD -eq 2 ]; then
        # If 'rn' is selected, suggest filenames for renaming (without full path and .md)
        if [ "${COMP_WORDS[1]}" == "rn" ]; then
            # Only suggest files without the full path and strip the .md extension
            files=$(ls $HOME/Documents/docs/*.md | xargs -n 1 basename | sed 's/\.md$//')
            COMPREPLY=($(compgen -W "$files" -- "$cur"))
        else
            # Suggest filenames for other modes, without the full path and .md extension
            files=$(ls $HOME/Documents/docs/*.md | xargs -n 1 basename | sed 's/\.md$//')
            COMPREPLY=($(compgen -W "$files" -- "$cur"))
        fi
    fi
    return 0
}

# Register the function for the odoc command
complete -F _odoc_complete odoc
