#!/bin/sh
#
# cmus-status-display
#
# Usage:
#   in cmus command ":set status_display_program=cmus-status-display"
#
# This scripts is executed by cmus when status changes:
#   cmus-status-display key1 val1 key2 val2 ...
#
# All keys contain only chars a-z. Values are UTF-8 strings.
#
# Keys: status file url artist album discnumber tracknumber title date
#   - status (stopped, playing, paused) is always given
#   - file or url is given only if track is 'loaded' in cmus
#   - other keys/values are given only if they are available
#  

LOG_FILE="/tmp/cmus-status.log"

while test $# -ge 2 ; do
	eval _$1='$2'
	shift
	shift
done

sanitize_path() {
    sed 's/\.$/_/g' \
    | sed 's@/@_@g' \
    | sed 's/:/_/g' \
    | sed 's/Various Artists/Compilations/g' \
    | sed 's/\?/_/g' \
    | sed 's/\*/_/g'
}

get_cover_path() {
    # album artist to match how beet organizes music library
    ALBUMARTIST="$(cmus-remote -Q | grep -w albumartist | cut -d" " -f 3- | sanitize_path)"
    ARTIST="$(echo $1 | sanitize_path)"
    ALBUM="$(echo $2 | sanitize_path)"
    PATH1="$HOME/music/$ALBUMARTIST/$ALBUM/cover.jpg"
    PATH2="$HOME/music/$ARTIST/$ALBUM/cover.jpg"
    if [ -f "$PATH1" ] ; then
        echo "$PATH1"
    else
        echo "$PATH2"
    fi
}

if test -n "$_file" ; then
	h=$(($_duration / 3600))
	m=$(($_duration % 3600))

	duration=""
	test $h -gt 0 && dur="$h:"
	duration="$dur$(printf '%02d:%02d' $(($m / 60)) $(($m % 60)))"

    COVER_PATH="$(get_cover_path "$_artist" "$_album")"

    if [ -f "$COVER_PATH" ] ; then
            notify-send --icon="$COVER_PATH" "[$_status]" "$_artist - $_album - $_title ($_date) $duration"
            feh --bg-center --save "$COVER_PATH"
    else
        echo "failed to set background: $COVER_PATH does not exist" >> $LOG_FILE
        notify-send "[$_status]" "$_artist - $_album - $_title ($_date) $duration"
    fi
elif test -n "$_url" ; then
	notify-send "[$_status]" "$_url - $_title"
else
	notify-send "[$_status]"
fi