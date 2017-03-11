#!/bin/bash
export SUDO_ASKPASS="`dirname $0`/myaskpass.sh"

listOs=`grep -i "menuentry " /boot/grub/grub.cfg | awk -F[\"\'] '{print NR-1 ";" $2";"}'`
IFS=";"
os=$(zenity --list --title "Select an OS" --column="Number (GRUB)" --column="Name"  --width 400 --height 250 --text "Select the OS to reboot on" $listOs 2>/dev/null);

if [ "$os" != "" ]
then
	returnMessage=$(sudo -A grub-reboot $os 2>&1);
	if [ "$?" != "0" ]
	then
		if [[ "$returnMessage" != "" ]]; then
			zenity --error --text="Following errors occured : \n$returnMessage" 2>/dev/null
		else
			exit 1
		fi
	else
		sudo reboot
	fi
fi
