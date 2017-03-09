#!/bin/bash
export SUDO_ASKPASS="`dirname $0`/myaskpass.sh"

listOs=`grep -i "menuentry " /boot/grub/grub.cfg`
echo $listOs
os=`zenity --list --title "Select an OS" --column="Number (GRUB)" --column="Name" --column="Description" 0 "Ubuntu16" "Take control with Ubuntu" 1 "Windows10" "Windows"`
if [ "$os" != "" ]
then
	sudo -A grub-reboot $os
	sudo -A reboot
	if [ "$ERROR" != "" ]
	then
		zenity --error --text="$ERROR"	
	fi
fi
