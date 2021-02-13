#!/bin/sh

set -e

_notify() {
	if >/dev/null 2>&1 command -v notify-send
	then
		notify-send -u low 'Screenshot' "$1"
	fi
}

filename="$HOME/Pictures/Screenshots/$( date '+%Y-%m-%d_%H:%M:%S' )_maim.png"

if maim "$@" "$filename"
then
	echo "$filename"
	_notify "$filename"
else
	msg="Screenshot failed! status:$?"
	1>&2 echo "$msg"
	_notify "$msg"
fi
