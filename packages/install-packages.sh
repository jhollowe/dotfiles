#!/bin/sh

# cd to the directory of the script, not whatever the PWD was
cd "${0%/*}"

# TMP DISABLE
exit 0

if [ $(id -u) -ne 0 ]; then
	echo "Need root to install packages"
	exit 1
fi

if [ -x "$(command -v apt)" ]; then
	apt update
	cat common-packages.txt apt-packages.txt | xargs apt install -y
fi

if [ -x "$(command -v yum)" ]; then
	cat common-packages.txt yum-packages.txt | xargs yum install -y
fi

if [ -x "$(command -v apk)" ]; then
	cat common-packages.txt apk-packages.txt | xargs apk add -y
fi
