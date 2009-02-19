
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# prompt
#export PS1="\e[31;40m\w/\e[0m "

echo  "~/.bashrc called"

# readline bindings moved from .inputrc to here for convenience

# C-up,down
bind '"[1;5A"':history-search-backward
bind '"[1;5B"':history-search-forward

# C-left, right
bind '"[1;5D"':vi-bword
bind '"[1;5C"':vi-fword


# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_colored_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# -------------------------------------- Glynne --------------------------------

# aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export HISTSIZE=30000
export HISTFILESIZE=30000 

# bash command line history
# esc k: search hist, jkgh to navigate
# / to search
#set -o vi

# ------------------------------------------ xmodmap -------------------------------------

# xmodmap maps one key to another

# xev to find out what keycode a key maps to (left side of equals)
# xmodmap -pke to get a list of keynames (right side of equals)
# map CAPSLOCK to Ctrl
# xmodmap -e "keycode 66 = Control_L" 
# xmodmap -e "keycode 117 = a"
# xmodmap -e "keycode 66 = Control_L" 
# xmodmap -e "clear Lock"
# xmodmap -e "Control = Control_L" 
# map CAPSLOCK to Esc
# xmodmap -e "keycode 66 = Escape" 
# map right shift to Ctrl
# xmodmap -e "remove shift = Shift_R"
# xmodmap -e "add mod1 = Alt_R"

# ------------------------------------------ xbindkeys -------------------------------------

# xbindkeys maps keystrokes to `nix commands
# see .xbindkeys.rc for key mappings aka autohotkeys
# or press <C-Delete>

exists=`ps aux | grep -c xbindkeys`
[ $exists -eq "0" ] && xbindkeys && echo started xbindkeys

# --------------------------------------------- usenet ! --------------------------------
#export NNTPSERVER=freenews.netfront.net
#export NNTPSERVER=news.readfreenews.net

# -------------------------------------------- run screen ---------------------------------

#if [ $SHLVL -eq 1 ] ;then
#    screen -R
#fi

# force display power management to activate the display
set dpms force on


if [ -z "$SCREEN_LOADED" ]; then
    export SCREEN_LOADED=1
    screen -DR
    # -D -R   Attach here and now. In detail this means: If a session is running, then reattach.
    #         If  necessary  detach  and logout remotely first.  If it was not running create it
    #         and notify the user. This is the author’s favorite.
fi
