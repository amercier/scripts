#!/bin/bash

# ==============================================================================
# Utility functions
# ==============================================================================

# ------------------------------------------------------------------------------
# function_parameter $parameter_name $parameters
# 
# Return the value of a parameter from a list of parameters.
# Ex: 
#     # function_parameter --debug somevalue --debug true --what ever
#     > somevalue
# ------------------------------------------------------------------------------
function function_parameter {
	local index=1
	local found=
	for value in "$@"; do

		# Found on previous iteration
		if [ $found ]; then
			echo $value
			return 0
		fi

		# If found, set $found for next iteration
		if [[ $index != 1 && "$value" == "$1" ]]; then
			let found=1
		fi

		let index=index+1
	done

	# Found but no argument
	if [ "$found" == true ]; then
		return 0
	fi

	# Not found
	return 1
}

#echo "function_parameter --debug --debug true"
#function_parameter --debug --debug true
#echo $?
#echo "function_parameter --notdebug --debug true"
#function_parameter --notdebug --debug true
#echo $?
#echo "function_parameter --debug --debug --whatever"
#function_parameter --debug --debug --whatever
#echo $?