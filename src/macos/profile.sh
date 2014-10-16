#!/bin/bash

[ ! -d /etc/profile.d ] && sudo mkdir /etc/profile.d \
&& echo "Created /etc/profile directory" \
|| echo "/etc/profile.d already exists, skipping"

grep -q profile.d /etc/profile \
&& echo "/etc/profile is already up-to-date, skipping" \
|| (echo '
# Customization
for PROFILE_SCRIPT in $( ls /etc/profile.d/*.sh ); do
  . $PROFILE_SCRIPT
done' | sudo tee -a /etc/profile && echo "Updated /etc/profile")

source /etc/profile