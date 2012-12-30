#!/bin/bash

# ==============================================================================
# Application setup
# 
# Requires:
#   - os.sh
# ==============================================================================

. ./os.sh

# ------------------------------------------------------------------------------
# application_check $name
# 
# Check that an application $name is installed. If not, it will try to install
# it by calling application_install.
# ------------------------------------------------------------------------------
function application_check {
	if [ which "$1" >/dev/null 2>&1 ] then
		return 0
	fi
	application_install $@
	return 0
}