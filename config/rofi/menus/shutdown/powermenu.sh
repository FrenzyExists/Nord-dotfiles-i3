#!/usr/bin/env bash



uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme /home/frenzy/.config/rofi/menus/shutdown/powermenu.rasi"

# Options
shutdown="⭘ Shutdown"
reboot=" Restart"
lock=" Lock"
suspend=" Sleep"
logout=" Logout"

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "You Sure Boi? : "\
		-theme /home/frenzy/.config/rofi/minimal.rasi
}

# Message
msg() {
	rofi -theme "/home/frenzy/.config/rofi/minimal.rasi" -e "Available Options  -  yes / y / yeh / no / n / nope"
}

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)

		if [[ ${ans^^} == "YES" || ${ans^^} == "YEH" || ${ans^^} == "Y" ]]; then
			systemctl poweroff
		if [[ ${ans^^} == "YES" || ${ans^^} == "YEH" || ${ans^^} == "Y" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $reboot)
		ans=$(confirm_exit &)
		if [[ ${ans^^} == "YES" || ${ans^^} == "YEH" || ${ans^^} == "Y" ]]; then
			systemctl reboot
		if [[ ${ans^^} == "YES" || ${ans^^} == "YEH" || ${ans^^} == "Y" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $suspend)
		ans=$(confirm_exit &)
		if [[ ${ans^^} == "YES" || ${ans^^} == "YEH" || ${ans^^} == "Y" ]]; then
			mpc -q pause
			amixer set Master mute
			systemctl suspend
		if [[ ${ans^^} == "YES" || ${ans^^} == "YEH" || ${ans^^} == "Y" ]]; then
			exit 0
        else
			msg
        fi
        ;;
    $logout)
		ans=$(confirm_exit &)
		if [[ ${ans^^} == "YES" || ${ans^^} == "YEH" || ${ans^^} == "Y" ]]; then
			if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
				openbox --exit
			elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
				i3-msg exit
			fi
		if [[ ${ans^^} == "YES" || ${ans^^} == "YEH" || ${ans^^} == "Y" ]]; then
			exit 0
        else
			msg
        fi
        ;;
esac
