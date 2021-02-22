#!/usr/bin/env bash

# SDIR="$HOME/.config/polybar/scripts"

# # Launch Rofi
# MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
# -theme $SDIR/rofi/styles.rasi \
# <<< " Default| Nord| Gruvbox| Dark| Cherry|")"
#             case "$MENU" in
# 				*Default) "$SDIR"/styles.sh --default ;;
# 				*Nord) "$SDIR"/styles.sh --nord ;;
# 				*Gruvbox) "$SDIR"/styles.sh --gruvbox ;;
# 				*Dark) "$SDIR"/styles.sh --dark ;;
# 				*Cherry) "$SDIR"/styles.sh --cherry ;;
#             esac
SDIR="$HOME/.config/rofi/"

# Launch Rofi
MENU="$(rofi -no-config -no-lazy-grab -sep "|" -dmenu -i -p '' \
-theme $SDIR/minimal.rasi \
<<< "🏔 Nord Light|⛰ Nord Dark|🎓 Monochrome| Cherry|")"
            case "$MENU" in
				*Default) echo Bruh ;;
				*Nord) echo Bruh ;;
				*Gruvbox) echo Bruh ;;
				*Dark) echo Bruh ;;
				*Cherry) echo Bruh ;;
            esac