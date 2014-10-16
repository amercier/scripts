#!/usr/bin/env bash

if [ -e "/Applications/Sublime Text.app" ]; then
  echo "Sublime Text is already installed"
  exit 0
fi

echo ".---------------------------."
echo "| Sublime Text installation |"
echo "'---------------------------'"
 
cd \
&& temp=$TMPDIR$(uuidgen) \
&& mkdir -p $temp/mount \
&& curl -# -L "$(curl -s -L http://www.sublimetext.com/3 | egrep -o 'https?://.*\.dmg' | sed 's/ /%20/g')" > $temp/1.dmg \
&& yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/1.dmg \
&& cp -r $temp/mount/*.app /Applications \
&& hdiutil detach $temp/mount \
&& rm -r $temp \
&& echo ".-------------------------------------." \
&& echo "| Sulbime Text installed successfully |" \
&& echo "'-------------------------------------'" \
&& /Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text --version

/Applications/Sublime\ Text.app/Contents/MacOS/Sublime\ Text >/dev/null 2>&1 &