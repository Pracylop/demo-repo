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


#push single fils
#take 3 arguments: filename message 1 and message 2
#E.g. push_all "file.txt"  "welcome" "created welcome message"
push_file(){
	echo "ARGS : $#"
	echo "Pushing all with message '$1'"
	git add "$1"
	if [ "$#" -eq 3 ]; then
		git commit -m "$2" -m "$3"
	else
		git commit -m "$2"
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

#4 args
if [ "$#" -eq 4 ]; then
	echo "Arg 1: '$1'"
	echo "Arg 2: '$2'"
	echo "Arg 3: '$3'"
	echo "Arg 4: '$4'"
	#pushfile -am "message" -m "message details"
	if [[ "$1" =~ -(am|ma)  ]]; then
		if [[ "$3" =~ (-m|--message)  ]]; then
			push_all "$2" "$4"
		else
			echo "ERROR: invalid message option '$3'"
			show_usage_info
		fi
		exit
	fi
	#pushfile -f filename.ext -m "message"
	if [[ "$1" =~ (-f|--file) ]]; then
		if [ -f "$2" ]; then
			if [[ "$3" =~ (-m|--message)  ]]; then
				push_file "$2" "$4"
			else
				echo "ERROR: invalid message option '$3'"
				show_usage_info
			fi
			exit
		else
			echo "ERROR: File '$2' does not exist in this directory."
			echo "Please provide a valid file name."
			exit
		fi
	fi
	#first arg is not -am, -f or --f
	echo "ERROR: invalid option '$1'"
	show_usage_info
	exit
fi
#5 args
if [ "$#" -eq 5 ]; then
	echo "Arg 1: '$1'"
	echo "Arg 2: '$2'"
	echo "Arg 3: '$3'"
	echo "Arg 4: '$4'"
	echo "Arg 5: '$5'"
	## pushfile -a -m "message" -m "another message"
	if [[ "$1" =~(-a|--all) &&  "$2" =~(-m|--message) ]]; then
		if [[ "$4" =~ (-m|--message)  ]]; then
			push_all "$3" "$5"
		else
			echo "ERROR: invalid message option '$4'"
			show_usage_info
		fi
		exit
	fi
	
	exit
fi
#6 args
if [ "$#" -eq 6 ]; then
	echo "Arg 1: '$1'"
	echo "Arg 2: '$2'"
	echo "Arg 3: '$3'"
	echo "Arg 4: '$4'"
	echo "Arg 5: '$5'"
	echo "Arg 6: '$6'"

	#pushfile -f filename.ext -m "message head" -m "message body"
	if [[ "$1" =~ (-f|--file) ]]; then
		if [ -f "$2" ]; then
			if [[ "$3" =~ (-m|--message) && "$5" =~ (-m|--message) ]]; then
				push_file "$2" "$4" "$6"
			else
				echo "ERROR: invalid message option '$3' or '$5'"
				show_usage_info
			fi
			exit
		else
			echo "ERROR: File '$2' does not exist in this directory."
			echo "Please provide a valid file name."
			exit
		fi
	fi

	exit
fi
