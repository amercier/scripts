#!/usr/bin/env bash

# To disable .DS_Store files, use:
#
#    defaults write com.apple.desktopservices DSDontWriteNetworkStores true

echo "Deleting .DS_Store files..."
find / -type f -name .DS_Store 2>/dev/null | while read path; do
  echo $path
  rm "$path"
done