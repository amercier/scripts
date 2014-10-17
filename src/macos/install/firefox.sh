#!/usr/bin/env bash

if [ -e "/Applications/Firefox.app" ]; then
  echo "Firefox is already installed"
  exit 0
fi

VERSION=$(curl -sL https://www.mozilla.org/en-US/firefox/new/ | grep 'meta itemprop="softwareVersion"' | egrep -o '[0-9]+\.[0-9]+(\.[0-9]+)?')

echo ".----------------------."
echo "| Firefox installation |"
echo "'----------------------'"
 
cd \
&& temp=$TMPDIR$(uuidgen) \
&& mkdir -p $temp/mount \
&& curl -# -L https://download-installer.cdn.mozilla.net/pub/firefox/releases/$VERSION/mac/en-US/Firefox%20$VERSION.dmg > $temp/1.dmg \
&& yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/1.dmg \
&& cp -r $temp/mount/*.app /Applications \
&& hdiutil detach $temp/mount \
&& rm -r $temp \
&& echo ".--------------------------------." \
&& echo "| Firefox installed successfully |" \
&& echo "'--------------------------------'" \
&& /Applications/Firefox.app/Contents/MacOS/Firefox --version

/Applications/Firefox.app/Contents/MacOS/Firefox >/dev/null 2>&1 &
