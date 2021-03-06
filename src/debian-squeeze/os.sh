#!/bin/bash

# ==============================================================================
# Operating System related functions
# ==============================================================================

# ------------------------------------------------------------------------------
# os_distribution
# 
# Show the current distribution
# Ex: 
#     # os_distribution
#     > Debian
# ------------------------------------------------------------------------------

function os_distribution {
	local n
	if [[ -r '/etc/lsb-release' ]]; then
		. /etc/lsb-release
		[[ "$DISTRIB_ID" ]] && n="$DISTRIB_ID"
	elif [[ -r '/etc/release' ]]; then
		n=`head -1 /etc/release | sed 's/ *\([[^0-9]]*\) [0-9].*/\1/'`
	elif [[ -r '/etc/arch-release' ]]; then
		n="Arch Linux"
	elif [[ -r '/etc/debian_version' ]]; then
		n='Debian'
	elif [[ -r '/etc/gentoo-release' ]]; then
		n='Gentoo'
	elif [[ -r '/etc/knoppix-version' ]]; then
		n='Knoppix'
	elif [[ -r '/etc/mandrake-release' ]]; then
		n='Mandrake'
	elif [[ -r '/etc/pardus-release' ]]; then
		n='Pardus'
	elif [[ -r '/etc/puppyversion' ]]; then
		n='Puppy Linux'
	elif [[ -r '/etc/redhat-release' ]]; then
		n='Red Hat'
	elif [[ -r '/etc/sabayon-release' ]]; then
		n='Sabayon'
	elif [[ -r '/etc/slackware-version' ]]; then
		n='Slackware'
	elif [[ -r '/etc/SuSE-release' ]]; then
		n='SuSE'
	elif [[ -r '/etc/xandros-desktop-version' ]]; then
		n='Xandros'
	elif [[ -r '/etc/zenwalk-version' ]]; then
		n="Zenwalk"
	elif [[ "$OS" == 'Windows_NT' ]]; then
		n="Cygwin"
	fi
	[[ "${n:-}" = '' ]] && echo "$0: Could not determine the distro name" >&2 && return 1 || echo $n && return 0
} # get_distro_name