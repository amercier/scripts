#!/bin/bash

SOURCE=/etc/apt/sources.list.d/mozilla.list

if [ ! -e "$SOURCE" ]; then
	
	# aptitude install debian-keyring
	# http://mozilla.debian.net/pkg-mozilla-archive-keyring_1.1_all.deb
	# gpg --check-sigs --fingerprint --keyring /etc/apt/trusted.gpg.d/pkg-mozilla-archive-keyring.gpg --keyring /usr/share/keyrings/debian-keyring.gpg pkg-mozilla-maintainers
	
	echo "deb http://backports.debian.org/debian-backports squeeze-backports main
deb http://mozilla.debian.net/ squeeze-backports iceweasel-release" > $SOURCE
	
	echo -n "Installing Mozilla repo key... "
	wget -O- -q http://mozilla.debian.net/archive.asc | gpg --import >/dev/null \
		&& gpg --export -a 06C4AE2A | sudo apt-key add - >/dev/null \
		&& echo OK
	
	echo -n "Updating package list... "
	aptitude update >/dev/null && echo OK
	
fi

apt-get install -t squeeze-backports iceweasel
cp fonts.conf ~/.fonts.con