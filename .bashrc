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
EDITOR="nano"

# make sudo password prompt more verbose
export SUDO_PROMPT=${SUDO_PROMPT:-"[sudo] password for %u on %h: "}

# use UTF-8, but sort files by the C method
export LANG="en_US.utf8"
export LC_COLLATE="C"

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

	local    red='\[\e[0;31m\]'
	local  lblue='\[\e[1;34m\]'
	local  lcyan='\[\e[1;36m\]'
	local yellow='\[\e[0;33m\]'
	local  white='\[\e[0;00m\]'


	if [ "$color_prompt" = yes ]; then
		if [ "$EUID" -eq 0 ]; then
			local username_color="${red}"
		else
			local username_color="${lcyan}"
		fi

		export PS1="${PS_CHROOT}${username_color}\u@\h${white}:${yellow}\w${white}\$ "
	else
		export PS1="${PS_CHROOT}\u@\h:\w\$ "
	fi


	# If this is an xterm set the title to user@host:dir
	case "$TERM" in
		xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
			export PS1="\[\e]0;"${PS_CHROOT}"\u@\h:\w\a\]$PS1"
			;;
		*)
			;;
	esac
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
if [ ${PWD^^} == "/MNT/C/WINDOWS/SYSTEM32" ]; then
  cd -- ~
fi

##### FUNCTIONS #####

mkcd(){
	mkdir -p -v "$1"
	cd -- "$1"
}

# tars the current directory
# if no argument is give, the tar is created in the parent directory with this directory's name
# if an argiment is given, that directory will be tared into a tar file in the current directory
tarthis(){
	if [ -n "$1" ]; then
		tar -czvf "${1%/}.tar.gz" "$1"
	else
		tar -czvf "../${PWD##*/}.tar.gz" "../${PWD##*/}"
	fi
}

# display the internet-facing IP address of this host
pubip(){
	curl -s https://api.ipify.org && echo ''
}
