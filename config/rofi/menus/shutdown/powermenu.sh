#!/usr/bin/env bash
#############################################################################################
#																							#
# ?88,.d88b, d8888b ?88   d8P  d8P d8888b  88bd88b88bd8b,d88b  d8888b  88bd88b ?88   d8P 	#
# `?88'  ?88d8P' ?88d88  d8P' d8P'd8b_,dP  88P'  `88P'`?8P'?8bd8b_,dP  88P' ?8bd88   88  	#
#   88b  d8P88b  d88?8b ,88b ,88' 88b     d88    d88  d88  88P88b     d88   88P?8(  d88 	#
#   888888P'`?8888P'`?888P'888P'  `?888P'd88'   d88' d88'  88b`?888P'd88'   88b`?88P'?8b 	#
#   88P'		           	                                                              	#
#  d88																						#
#  ?8P       																				#
#																							#
############################################################################################# 


# A fork from Benjamin Chrétien menu
# Use rofi to change system runstate thanks to systemd.
#
# Inspired from i3pystatus wiki:
# https://github.com/enkore/i3pystatus/wiki/Shutdown-Menu
#


# Get updtime
uptime=$(uptime -p | sed -e 's/up //g')

#  Change rofi theme here
rofi_theme="rofi -theme /home/frenzy/.config/rofi/menus/shutdown/powermenu.rasi"
rofi_theme_2="rofi -theme /home/frenzy/.config/rofi/minimal.rasi"

# Whether to ask for user's confirmation
enable_confirmation=true

# This script depends on:
#   - systemd,
#   - i3,
#   - rofi
usage="$(basename "$0") [-h] [-c] -- display a menu for shutdown, reboot, lock etc.

where:
    -h  show this help text
    -c  ask for user confirmation

This script depends on:
  	-systemd,
  	-i3,
  	-rofi
"

# Generate Menu Map
typeset -A menu
function generate_map() {
	
	menu[⭘ Shutdown]="systemctl poweroff"
	menu[ Restart]="systemctl reboot"
  	menu[ Sleep]="systemctl suspend"
  	menu[ Lock]="zsh ~/.config/i3/scripts/lock.sh"
  	menu[ Logout]="i3-msg exit"
	
}
# Call the generator thingy
generate_map

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "You Sure? : "\
		-theme /home/frenzy/.config/rofi/minimal.rasi
}

# Check whether a command exists#####
function command_exists() {
  command -v "$1" &> /dev/null 2>&1
}

# systemctl required
if ! command_exists systemctl ; then
  exit 1
fi

# Store selection
selection="$(printf '%s\n' "${!menu[@]}" | sort )"

# Variable passed to rofi
chosen="$(echo -e "$selection" | $rofi_theme -p " Uptime: $uptime" -dmenu -selected-row 0)"

# Ask user for confirmation (so user can enable or disable the confirmation)
function ask_confirmation() {
	confirmed=$(echo -e "Yes\nNo" | rofi -dmenu -i -lines 2 -p "${chosen}?" ${rofi_theme_2} )
    [ "${confirmed}" == "Yes" ] && confirmed=0

	if [ "${confirmed}" == 0 ]; then
		i3-msg -q "exec ${menu[${chosen}]}"
	fi
}

# Run this piece of garbage
if [[ $? -eq 0 && ! -z ${chosen} ]]; then
  if [[ "${enable_confirmation}" = true ]]; then
    ask_confirmation
  else
    i3-msg -q "exec ${menu[${chosen}]}"
  fi
fi
