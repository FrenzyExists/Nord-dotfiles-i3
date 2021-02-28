#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    DIR=`dirname "$0"`
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
#bar=$(seq -s "─" $(($volume/5)) | sed 's/[0-9]//g')
if [ "$volume" = "0" ]; then
        icon_name="~/.config/dunst/icons/volume-mute.svg"
dunstify "$volume""      " -i "$icon_name" -t 3000 -h int:value:"$volume" -h string:synchronous:"─" -r 555
    else
	if [  "$volume" -lt "10" ]; then
	     icon_name="~/.config/dunst/icons/volume-2.svg"
dunstify "$volume""     " -i "$icon_name" -r 555 -t 3000
    else
        if [ "$volume" -lt "30" ]; then
            icon_name="~/.config/dunst/icons/volume-2.svg"
        else
            if [ "$volume" -lt "70" ]; then
                icon_name="~/.config/dunst/icons/volume-1.svg"
            else
                icon_name="~/.config/dunst/icons/volume.svg"
            fi
        fi
    fi
fi
bar=$(seq -s "━" $(($volume/5)) | sed 's/[0-9]//g')

let _progress=(${volume}*100/100*100)/100
let _done=(${_progress})*2/10
let _left=20-$_done
# Build progressbar string lengths
_fill=$(printf "%${_done}s")
_empty=$(printf "%${_left}s")
build_bar="${_fill// /━}${_empty// /-}|"

# Send the notification
dunstify "$volume""     ""$bar"  -i "$icon_name" -t 3000 -h int:value:"$volume" -h string:synchronous:"$bar" -r 555

}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer -D pulse sset Master 5%+ > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 5%- > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
    DIR=`dirname "$0"`
    dunstify -i "~/.config/dunst/icons/volume-mute.svg" -r 555 -u normal "Mute" -t 3000
	else
	    send_notification
	fi
	;;
esac

