# This file is part of eRCaGuy_dotfiles: https://github.com/ElectricRCAircraftGuy/eRCaGuy_dotfiles


# -----------------setting custom PS1 prompt string START ----------------

# ANSI color codes, formatting, or highlighting
# See:
# 1. https://github.com/ElectricRCAircraftGuy/eRCaGuy_hello_world/blob/master/bash/ansi_color_codes.sh
# 2. "ANSI escape code" on Wikipedia:
#   1. https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit
#   2. https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters
# ANSI_START="\e["    # start of an ANSI formatting sequence
ANSI_START="\e["
#
# --------- ANSI numeric codes start ----------
#         - these codes go **between** `ANSI_START` and `ANSI_END`
#
# inverted colors; see code 7 here: https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_
# (Select_Graphic_Rendition)_parameters
# ANSI_INV=";7"
#
# --------- ANSI numeric codes end ------------
#
# ANSI_END="m"        # end of an ANSI formatting sequence
ANSI_END="m"
# turn OFF ANSI formatting here; ie: disable all formatting by specifying `ANSI_START` and
# `ANSI_END` withOUT any formatting codes in between!
ANSI_OFF="${ANSI_START}${ANSI_END}"

# Get the short git hash, appended with the word `dirty`, if `git status` is
# dirty.
# See my answer here: https://stackoverflow.com/a/76856090/4561887
gs_git_get_short_hash_dirty() {
    test -z "$(command git status --porcelain)" \
        && echo "$(command git rev-parse --short HEAD)" \
        || echo "$(command git rev-parse --short HEAD) [+]"
}

# Get the git branch and hash.
# - Edit Prompt String 1 (PS1) variable to show 1) the shell level and 2) the currently-checked-out
#   git branch whenever you are inside any directory containing a local git repository.
# - See: [my ans]
#   https://stackoverflow.com/questions/4511407/how-do-i-know-if-im-running-a-nested-shell/57665918#57665918

# Print non-ANSI-formatted branch info, storing the results in global variables for later use.
gs_git_show_branch_and_hash_no_formatting() {
    # See my comment: 
    # https://stackoverflow.com/questions/15715825/how-do-you-get-the-git-repositorys-name-in-some-git-repository#comment137449876_15716016
    git_repo="$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")"

    git_branch="$(command git symbolic-ref -q --short HEAD 2>/dev/null)"
    # See: https://stackoverflow.com/a/16925062/4561887
    if [ "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ] && [ -z "$git_branch" ]; then
        # similar to what `git status` shows when the HEAD is detached
        git_branch="HEAD detached at"
    fi

    # See: https://stackoverflow.com/a/5694416/4561887
    git_short_hash="$(gs_git_get_short_hash_dirty 2>/dev/null)"

    # See: https://stackoverflow.com/a/33733020/4561887
    git_tag="$(command git tag --points-at HEAD 2>/dev/null)"
    if [ -n "$git_tag" ]; then
        git_tag="tag: $git_tag"
        # Replace all newlines between tags at this commit with spaces
        # - See: https://unix.stackexchange.com/a/26798/114401
        git_tag="$(echo "$git_tag" | sed ':a;N;$!ba;s/\n/, tag: /g')"
    fi

    if [ -n "$git_repo" ] || [ -n "$git_branch" ] || [ -n "$git_short_hash" ] || [ -n "$git_tag" ]; then
        branch_info="${git_repo}  ${git_branch}  ${git_short_hash}  ${git_tag}"
        echo "$branch_info"
    fi
}

gs_git_show_branch_and_hash() {
    # format on
    # F="${ANSI_START}${ANSI_INV}${ANSI_END}"
    GREENF="\033[32m"
    BLUEF="\033[96m"
    REDF="\033[31m"
    # format off
    # f="${ANSI_OFF}"
    WHITEF="\033[0m"


    gs_git_show_branch_and_hash_no_formatting > /dev/null

    if [ -n "$git_repo" ] || [ -n "$git_branch" ] || [ -n "$git_short_hash" ] || [ -n "$git_tag" ]; then
        # branch_info="${git_repo} ${git_branch} ${git_short_hash} ${git_tag}"
        branch_info="${BLUEF}${git_branch} ${WHITEF}${git_short_hash} ${REDF}${git_tag}"
        echo -e "$branch_info"  # NB: DON'T FORGET THE `-e` here to escape the color codes!
    fi
}

# OLD:
# - shows shell level, git branch (if in a dir with one), and `hostname present_dir $ ` only,
#   rather than username too
# - has no color
# PS1="\e[7m\$(gs_git_show_branch_and_hash)\e[m\n\h \w $ "
# PS1='\$SHLVL'":$SHLVL $PS1"
#
# NEW:
# - shows shell level, git branch (if in a dir with one), and `username@hostname:present_dir$ `
# - ie: it simply adds the shell level and git branch on a line above the
#   default-Ubuntu-18-installation prompt!
# - has color, like a default Ubuntu 18 installation does too!
#
# Back up the `PS1` prompt 1 string for the user in case they want to revert to it later.
# - This is especially important on Git Bash on Windows, where resetting the terminal does **not**
#   reset the PS1 string back to default like it does on Linux. 
if [ -z "$PS1_BAK" ]; then
    PS1_BAK="$PS1"
fi
#
# Allow the user to quickly reset the PS1 prompt string back to the system default if they want to.
# - Again, this is especially useful on Git Bash on Windows.
reset_ps1_to_system_default() {
    PS1="$PS1_BAK"
}
alias gs_reset_ps1_to_system_default="reset_ps1_to_system_default"
#
#
# Comment this block out to NOT show the git branch!
# New: 
# - Note: on Windows, you **must** use the backtick-style command substitution, as the `$()` style
#   does NOT work in the PS1 prompt string in Git Bash on Windows! See my answer: 
#   https://stackoverflow.com/a/78520260/4561887
# See my answer: https://stackoverflow.com/a/78480875/4561887
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # OS is Linux
    # NB: don't forget the `\` to escape the `$`!
    PS1="\$(gs_git_show_branch_and_hash)\n$PS1_BAK"
elif [[ "$OSTYPE" == "msys" ]]; then 
    # OS is Windows using Git Bash
    
    # Default PS1 prompt string on Windows Git Bash. 
    # - Note: I found this by manually running `echo $PS1_BAK` in the Git Bash terminal. Let's store
    #   it into `PS1_DEFAULT` for reference.
    PS1_DEFAULT='\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$'
    # Customize the PS1 script ourselves. 
    # - Don't include the call to `__git_ps1` since that's redundant with our custom, and
    #   more-thorough, `gs_git_show_branch_and_hash` function. 
    # - Also, delete the newline before the `$` prompt char, and add a space after it to make it 
    #   look just like the terminal prompt on Linux! 
    # PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w\[\033[36m\]\[\033[0m\]$ '
    # PS1='`gs_git_show_branch_and_hash`'"$PS1"
    PS1='\[\033]0;$TITLEPREFIX:$PWD\007\]\n\[\033[32m\]\u@\h \[\033[35m\]$MSYSTEM \[\033[33m\]\w \[\033[36m\]`gs_git_show_branch_and_hash` \[\033[0m\]\n$ '
fi
#
# Comment this line out to NOT show shell level!
# PS1='\$SHLVL'":$SHLVL  $PS1"  # double space between items
# PS1='\$SHLVL'":$SHLVL $PS1"  # single space between items

# -----------------setting custom PS1 prompt string END ----------------
