#!/bin/bash

# ==============================================================================
# PhantomJS installer & updater
# 
# Requires:
#   - application.sh
#   - github.sh
# ==============================================================================

. ./application.sh
. ./console.sh
. ./github.sh

set PHANTOMJS_GITHUB_REPO=ariya/phantomjs

# ------------------------------------------------------------------------------
# phantomjs_latest_version
# Displays the latest PhantomJS release
# ------------------------------------------------------------------------------
function phantomjs_latest_release {
	github_tag $PHANTOMJS_GITHUB_REPO '\d.\d.\d'
}

function phantomjs_current_version {
	phantomjs --version
}


if [ application_check phantomjs ]; then

	# --------------------------------------------------------------------------
	# Updater
	# --------------------------------------------------------------------------

	local current=$(phantomjs_current_version)
	echo -n "Found PhantomJS version $current, looking for a newer version... "
	local newer=$(phantomjs_latest_release)
	echo
	if [ "$current" == "$newer" ]; then
		echo "▸ Version $current is the latest version available"
	else
		echo "▸ Found new version $version"
		
		phantomjs_uninstall && 
		phantomjs_install_latest_release &&
	fi
else

	# --------------------------------------------------------------------------
	# Installer
	# --------------------------------------------------------------------------



fi