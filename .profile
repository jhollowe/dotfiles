# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi


pathDirs="$HOME/bin $HOME/.local/bin"

#echo $PATH
for dir in $pathDirs; do
#	echo -ne $dir
	case ":$PATH:" in
		*:$dir:*)
#			echo " PRESENT"
			;; # dir is in path
		*)
			if [ -d "$dir" ] ; then
				PATH="$dir:$PATH"
#				echo " ADDED"
			fi
			;;
	esac
done
unset pathDirs

# disable user-to-user messaging
# mesg n 2> /dev/null || true

if [ -f "$HOME/.profile_local" ];then
	. "$HOME/.profile_local"
fi
