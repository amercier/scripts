#!/bin/bash

WIDTH=30

COLOR_RED='\e[0;31m'
COLOR_GREY='\e]4;8;#999999\a'
COLOR_END='\e[0m'

function print_indented {
	while read line; do
		printf "%s\n" "${1-	}$line"
	done
}

function print_colored {
	while read line; do
		printf "$1%s$COLOR_END\n" "$line"
	done
}

function print_red {
	print_colored $COLOR_RED
}
function print_grey {
	print_colored $COLOR_GREY
}

# console_task $message $command [$parameters...]
function console_task {
	
	printf "%-$((WIDTH-2))s" "$1 "

	# run the command with arguments
	$(${@:2} >/dev/null 2>/tmp/task_error.log) \
		&& (printf "%s\n" "✔" && return 0) \
		|| (printf "%s\n" "✘" && cat /tmp/task_error.log | print_red | print_indented && return 1)
}

#console_task "Testing which print" which print
#console_task "Testing which print2" which print2
#console_task "Testing which print with a very, very long message..." which print