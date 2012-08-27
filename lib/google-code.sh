
. ./common.sh

# ------------------------------------------------------------------------------
# Get the downloads of a Google Code hosted project.
#
# Default format of response:
#
#     date    url    filename    summary
# 
# @param string $1 Name of the project
# @param string $1 Ordering. Possible values: "filename", "summary", "uploaded"
#                  as upload date, "releasedate", "size", "downloadcount".
#                  Values can be prefixed with "-" for descending ordering.
#                  Values can be combined using the separator "+".
#                  Default is "-releasedate" (Release date, descending)
# @param string $1 "+"-separated list of columns to be displayed.
#                  Default is "ReleaseDate+URL+Filename+Summary"
#
# Column names:
#    - URL          : The file url
#    - Filename     : The file name
#    - Summary      : A brief description of the download
#    - Uploaded     : The upload date
#    - ReleaseDate  : The release date
#    - Size         : The size, in a human-friendly format
#    - DownloadCount: The number of downloads
#    - Project      : The project name
#    - UploadedBy   : The e-mail address of the uploader
#    - Stars        : The number of stars
#    - Type         : The file type (Archive, Source, ...)
#    - Opsys        : Operating system (OSX, Windows, All, ...)
#
# @require download()
# ------------------------------------------------------------------------------
google-code-get-downloads()
{
	local DEFAULT_ORDERING="-releasedate"
	local DEFAULT_COLUMNS="ReleaseDate+URL+Filename+Summary"
	
	if [ "$1" == "" ]; then
		echo "${0}: missing project name in ${FUNCNAME}" >&2
		return 1
	fi
	
download-quiet "http://code.google.com/$(echo ${1} | head -c 1)/${1}/downloads/list?can=2&sort=${2-$DEFAULT_ORDERING}&colspec=${3-$DEFAULT_COLUMNS}" \
	| remove-lines \
	| html-trim
}


# ------------------------------------------------------------------------------
# Get the latest version of a project, based on the file names
# 
# @param string $1 Name of the project
# 
# @require google-code-get-downloads()
# @require grep
# ------------------------------------------------------------------------------
google-code-get-latest-version-number()
{
	google-code-get-downloads $1 -releasedate Filename | grep -e '\d+\.\d+(\.\d+)?'
}

google-code-get-downloads phantomjs