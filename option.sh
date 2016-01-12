#!/bin/bash
#
# By: Rafael Silva & Diego Parra (copyleft) 2016

# Validate the cnofiguration file
if [[ ! -f /etc/usermin.conf ]]; then
	echo "Missing configuration file"
	exit 1	
fi 

# load the configuration file
source /etc/usermin.conf

# infinte loop to interate over the software over and
# over again, until user insert the '0' command. 
while [ 1 ]; do

	# create the dialog window and get user answer (input)
	answer=$(
		dialog \
			--stdout \
			--title "Userming - User Interface" \
			--menu  "Choose the option: " \
			0 0 0 \
			1 "Create user account"   \
			2 "Change user password"  \
			3 "List users" \
			4 "Delete a user account" \
			0 "Exit" \
	)

	# break whether the last commando fails 
	[[ $? -ne 0 ]] && break; 

	# handle user input 
	case "$answer" in
		1) bash "${SCRIPT_PATH}/adduser.sh"  ;;
		2) bash "${SCRIPT_PATH}/chpasswd.sh" ;;
		3) bash "${SCRIPT_PATH}/listuser.sh" ;;
		4) bash "${SCRIPT_PATH}/delete.sh"   ;;
		0) break ;;
	esac
done

# that's all folks. 
echo "Bye"
exit 0
