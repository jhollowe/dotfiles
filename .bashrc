#!/usr/bin/env bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL='ignoredups:ignorespace'
# ignore common commands that are not important
HISTIGNORE='fg:bg:history:pwd'
# store the date and time of command execution in the history file
HISTTIMEFORMAT='%F %T '
# keep 100,000 lines of history (or up to 2MB)
HISTSIZE=100000
HISTFILESIZE=2000000

# append to the history file, don't overwrite it
shopt -s histappend
# write multiline commands as a single line in the history file
shopt -s cmdhist

# if attempting to run a dir as command, cd to that dir
shopt -s autocd

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Prevent files from being overwritten by redirection.
# Use >| to overwrite file with redirect
set -o noclobber

# default to nano for editing files
export EDITOR='nano'
export VISUAL=$EDITOR

# make sudo password prompt more verbose
export SUDO_PROMPT=${SUDO_PROMPT:-'[sudo] password for %u on %h: '}

# use UTF-8, but sort files by the C method
export LANG='en_US.utf8'
export LC_COLLATE='C'
export CHARSET='UTF-8'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

__bash_prompt() {
	# set variable identifying the chroot you work in (used in the prompt below)
	if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
		debian_chroot=$(cat /etc/debian_chroot)
	fi
	local PS_CHROOT='${debian_chroot:+($debian_chroot)}'

	# set a fancy prompt (non-color, unless we know we "want" color)
	case "$TERM" in
		xterm-color|*-256color) color_prompt=yes;;
	esac

	local     red='\[\e[0;31m\]'
	local lpurple='\[\e[1;35m\]'
	local   lblue='\[\e[1;34m\]'
	local   lcyan='\[\e[1;36m\]'
	local  yellow='\[\e[0;33m\]'
	local   white='\[\e[0;00m\]'


	if [ "$color_prompt" = yes ]; then
		if [ "$EUID" -eq 0 ]; then
			local username_color="${red}"
		else
			local username_color="${lcyan}"
		fi

		export PS1="${PS_CHROOT}${lpurple}\$(__get_term_name)${username_color}\u@\h${white}:${yellow}\w${white}\$ "
	else
		export PS1="${PS_CHROOT}\$(__get_term_name)\u@\h:\w\$ "
	fi


	# If this is an xterm set the title to user@host:dir
	case "$TERM" in
		xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
			export PS1='\[\e]0;'${PS_CHROOT}${PS_TERM_NAME:+"\"$PS_TERM_NAME\""}"\u@\h:\w\a\]$PS1"
			;;
		*)
			;;
	esac
	# remove this function if never used again
	unset -f __bash_prompt
}

__bash_prompt

# bash v4+ will trim the directory in the promot to N levels
export PROMPT_DIRTRIM=3

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

if [ -f ~/.aliases ];then
	. ~/.aliases
fi

##### ENVIRONMENTS #####

# if starting WSL bash from the default location, cd to home.
# if a custom location is set, leave it there
if [ "${PWD^^}" == '/MNT/C/WINDOWS/SYSTEM32' ]; then
  cd -- $HOME
fi

##### FUNCTIONS #####

function mkcd {
	mkdir -p -v "$1"
	cd -- "$1"
}

# tars the current directory
# if no argument is give, the tar is created in the parent directory with this directory's name
# if an argiment is given, that directory will be tared into a tar file in the current directory
function tarthis {
	if [ -n "$1" ]; then
		echo "creating tar file \"${1%/}.tar.gz\""
		tar -czvf "${1%/}.tar.gz" "$1"
	else
		echo "creating tar file \"../${PWD##*/}.tar.gz\""
		tar -czvf "../${PWD##*/}.tar.gz" "../${PWD##*/}"
	fi
}

# display the internet-facing IP address of this host
function pubip {
	curl -s https://api.ipify.org && echo ''
}

# sets a name for a terminal, used to help differentiate terminal sessions
# name is added to prompt and tab/window title
# do not give name to clear
function set_term_name {
	export PS_TERM_NAME="$*"
	if [ ! -z "$TMUX" ]; then
		# rename the session if there is only one window, else rename the window
		if [ $(tmux display-message -p '#{session_windows}') -eq 1 ];then
			tmux rename-session $PS_TERM_NAME
		else
			tmux rename-window $PS_TERM_NAME
		fi
	fi
}
function __get_term_name {
	echo -en ${PS_TERM_NAME:+\"$PS_TERM_NAME\"}
}

if [ -f ~/.bashrc_local ];then
	. ~/.bashrc_local
fi
