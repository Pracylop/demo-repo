#!/bin/bash

function show_usage_info(){
cat << _EOF_

USAGE pushfile FILEMODIFIER [FILENAME] MESSAGEMODIFIER MESSAGE

FILEMODIFIER:
	-f or --file : list of files to push
	-a or --all : push all files

MESSAGEMODIFIER:
	-m or --message : the push commit message

EXAMPLE:
	pushfile -f intro.js -m "First intro created"
	pushfile --file intro.js --message "First intro created"
	pushfile -a -m "Initial setup" -m "Created multiple files"
	pushfile --all --message "Initial setup" -message "Created multiple files"
	pushfile -a -m "Initial setup"
	pushfile --all --message "Initial setup"
	pushfile -am "Initial setup"

_EOF_

return	
}

#push all files
#take two arguments: message 1 and message 2
#E.g. push_all "welcome" "created welcome message"
push_all(){
	echo "ARGS : $#"
	echo "Pushing all with message '$1'"
	git add .
	if [ "$#" -eq 2 ]; then
		git commit -m "$1" -m "$2"
	else
		git commit -m "$1"
	fi
	git push
}


echo "Number of arguments " $#

#CHECK ARGUMENTS
#arguments less than 2, exit
if [ "$#" -lt 2 ]; then
	echo "ERROR: inadequate arguments provided"
	
	show_usage_info
	exit
fi
#two arguments, first is not -am or -ma, exit
if [ "$#" -eq 2 ]; then
	echo "First argument : " $1
	if [[ "$1" =~ -(am|ma)  ]]; then
		echo "Second argument : " $2
		
		# push all
		push_all "$2"
	else
		echo "ERROR: unknown option '$1'"
		show_usage_info
	fi
	
	exit
fi
#three arguments, first two are not -a -m or --all --message, exit
if [ "$#" -eq 3 ]; then
	echo "Arg 1: '$1'"
	echo "Arg 2: '$2'"
	echo "Arg 3: '$3'"
	if [[ "$1" =~(-a|--all) &&  "$2" =~(-m|--message) ]]; then
		echo "Valid arguments provided"
		push_all "$3"
	else
		echo "ERROR: invalid option '$1' or '$2'. -a comes before -m"
		show_usage_info
	fi	
	exit
fi

#print intro

