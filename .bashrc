# from https://github.com/ElectricRCAircraftGuy/eRCaGuy_dotfiles/blob/master/etc/skel/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ================== END OF UBUNTU'S DEFAULT ~/.bashrc FILE ====================

# auto load ssh agent
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

# ================== ALIASES ====================

alias ll='ls -h -l -X'
alias la='ll -a'
alias l='ls -CF'

alias vim='nvim'
alias v='nvim'
alias date='date +%R\ on\ %a,\ %m-%d-%y'


alias clik='clikan'
alias wat='node ~/Documents/projects/watracker/index.js'
alias fp='fpilot'
alias lg='lazygit'

# ================== COMMANDS ====================

# resource bashrc
sob() {
    echo "sourced ~/.bashrc."
    source ~/.bashrc
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

complete -F _odoc_complete odoc

rs_shada() {
    path="$HOME/AppData/Local/nvim-data/shada"

    # shadaz='main.shada.tmp.z'
    files_to_delete=$(ls "$path")

    for i in $files_to_delete; do 
        rm -v "${path}/${i}"
    done
}

tunt() {
    local now="$(command date +%s)"

    if [ -z "$1" ]; then
        local then="$(command date -d "tomorrow 0" +%s)"
    else
        local then="$(command date -d "$1" +%s)"
    fi

    local time_between="$(($then - $now))"
    local past=""


    if [ "$time_between" -lt 0 ]; then
        past="-"
        time_between=$((-$time_between))
    fi

    if [ "$time_between" -le "60" ]; then
        echo "$past$(($time_between % 60))s"
    elif [ "$time_between" -le "3600" ]; then
        echo "$past$(($time_between / 60))m $(($time_between % 60))s"
    else
        echo "$past$(($time_between / 3600))h $(($time_between % 3600 / 60))m $(($time_between % 60))s"
    fi
}

source ~/.bash/bash_fzf.sh
# source ~/.bash/bash_prompt_str.sh
