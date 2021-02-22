#!/bin/sh

#####################################
# SUPER CONVENIENT SCREENSHOT TAKER #
#####################################

set -e

# Screenshot nofify
_notify() {
	if >/dev/null 2>&1 command -v notify-send
	then
		dunstify -i ~/.config/dunst/icons/screenshot.svg 'Screenshot taken!'
	fi
}

# Flag, for additional functionality :D
while [[ "$1" ]]; do
	case $1 in
		"--mode") screeny="$2" ;;
	esac
	shift
done

me="save"
me_="copy"

if [[ "$screeny" =~ .*"$me".* ]]
then
	filename="$HOME/Pictures/Screenshots/$( date '+%Y-%m-%d %H:%M:%S' ).png"	
		maim -u -s $filename
		_notify
elif [[ "$screeny" =~ .*"$me_".*  ]]
then
	maim -u -s | xclip -selection clipboard -t image/png
	_notify
fi

