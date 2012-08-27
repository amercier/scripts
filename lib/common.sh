
remove-lines()
{
	#sed ':a;N;$!ba;s/\n//g'
	tr '\n' ' '
}

html-trim()
{
	sed -e 's/ *[>] */##&1##########/g'
}


# ------------------------------------------------------------------------------
# Download a file or a document and outputs it on the standard output.
# 
# @param string $1 The URL to download
#
# @require wget
# ------------------------------------------------------------------------------
download()
{
	if [ "$1" == "" ]; then
		echo "${0}: missing URL in ${FUNCNAME}()" >&2
		return 1
	fi
	wget --no-verbose --output-document=- "${1}"
}

download-verbose()
{
	if [ "$1" == "" ]; then
		echo "${0}: missing URL in ${FUNCNAME}()" >&2
		return 1
	fi
	wget --output-document=- "${1}"
}

download-quiet()
{
	if [ "$1" == "" ]; then
		echo "${0}: missing URL in ${FUNCNAME}()" >&2
		return 1
	fi
	wget --quiet --output-document=- "${1}"
}