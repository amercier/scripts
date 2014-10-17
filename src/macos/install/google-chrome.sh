#!/usr/bin/env bash

if [ -e "/Applications/Google Chrome.app" ]; then
  echo "Google Chrome is already installed"
  exit 0
fi

echo ".----------------------------."
echo "| Google Chrome installation |"
echo "'----------------------------'"
 
cd \
&& temp=$TMPDIR$(uuidgen) \
&& mkdir -p $temp/mount \
&& curl -# -L https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg > $temp/1.dmg \
&& yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/1.dmg \
&& cp -r $temp/mount/*.app /Applications \
&& hdiutil detach $temp/mount \
&& rm -r $temp \
&& echo ".--------------------------------------." \
&& echo "| Google Chrome installed successfully |" \
&& echo "'--------------------------------------'" \
&& /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --version

/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome >/dev/null 2>&1 &
