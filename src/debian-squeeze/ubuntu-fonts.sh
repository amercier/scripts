#!/bin/bash

FONT_URL=http://font.ubuntu.com/
DIRECTORY=~/.fonts
TMP_FILE=/tmp/ubuntu-fonts.zip

if [ ! -e "$DIRECTORY" ]; then
	echo -n "Creating $DIRECTORY... "
	mkdir $DIRECTORY && echo OK
fi

if [ ! -d "$DIRECTORY" ]; then
	echo "$0: $DIRECTORY exists but is not a directory" >&2
	exit 1;	
fi

if [ ! -w "$DIRECTORY" ]; then
	echo "$0: $DIRECTORY exists but is not writeable" >&2
	exit 1;
fi

echo -n "Downloading fonts from $FONT_URL... "
wget --quiet -O $TMP_FILE $FONT_URL$(wget --quiet -O - $FONT_URL | grep -Po 'href="\K[^"]+(?=" type="application\/zip")') && echo "OK"

echo -n "Extracting fonts to $DIRECTORY... "
unzip $TMP_FILE -d $DIRECTORY && echo OK
