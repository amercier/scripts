#!/usr/bin/env bash

if [ -e "/Applications/Spectacle.app" ]; then
  echo "Sublime Text is already installed"
  exit 0
fi

echo ".------------------------."
echo "| Spectacle installation |"
echo "'------------------------'"
 
cd \
&& temp=$TMPDIR$(uuidgen) \
&& mkdir -p $temp \
&& curl -# -L "$(curl -s -L http://spectacleapp.com/ | egrep -o 'https?://.*\.zip')" > $temp/1.zip \
&& unzip -d /Applications $temp/1.zip \
&& rm -r $temp \
&& echo ".----------------------------------." \
&& echo "| Spectacle installed successfully |" \
&& echo "'----------------------------------'"