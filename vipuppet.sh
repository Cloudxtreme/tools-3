#!/bin/bash
#
# Simple script to edit a puppet file 
# and run a puppet validate syntax before 
# close the new manifest.
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
		while [[ true ]]; do
			echo -en "\nEdit again[Y/n]: "
			read input
			case ${input} in
				Y|y) break ;;
				n|N) exit 1;;
				*) echo "Invalid options" ;;
			esac
		done
	else
		break;
	fi
done
