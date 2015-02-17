#!/bin/bash
#
#     After write a lot of puppet manifest, type the command
# to validate the syntax was becoming a little annoying. 
#     I Develop this little script to do that for me.
# 
#
# By: Rafael Silva - (Copyleft)
# Date: Seg Fev 16 14:48:32 BRST 2015
##
FILE=${1}
PUPPET=$(which puppet)

# check the parameter
[[ ! ${FILE} ]] && echo "Usage: $0 <file>.pp" && exit 1;

# define the default editor
if [[ ${EDITOR} ]]; then
	BIN=$(which ${EDITOR})
	echo $BIN
	if [[ -f $BIN ]] && [[ -x $BIN ]]; then
		echo "Could not find the editor, using vi as default"
		BIN=vi
	fi
else
	BIN=vi
fi

# main loop
while [[ true ]]; do
	${BIN} ${FILE}
	
	# check the puppet syntax
	${PUPPET} parser validate ${FILE}

	if [[ $? -ne 0 ]]; then
	
		# loop to get user input
		while [[ true ]]; do
			echo -en "Edit again[Y/n]: "
			read input
			case ${input} in
				Y|y) break ;;
				n|N) exit 1;;
				*) echo -ne "Invalid options, " ;;
			esac
		done
	else
		break;
	fi
done
