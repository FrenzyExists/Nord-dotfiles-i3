#!/bin/bash

#########################################################
#                                                       #
#        d8b                                            #
#    d8P ?88                                            #
# d888888P88b                                           #
#   ?88'  888888b  d8888b  88bd8b,d88b  d8888b .d888b,  #
#   88P   88P `?8bd8b_,dP  88P'`?8P'?8bd8b_,dP ?8b,     #
#   88b  d88   88P88b     d88  d88  88P88b       `?8b   #
#   `?8bd88'   88b`?888P'd88' d88'  88b`?888P'`?888P'   #
#                                                       #
#########################################################


config_directory="$HOME/.config"
rofi_theme="rofi -theme $config_directory/rofi/menus/shutdown/powermenu.rasi"
rofi_theme_2="rofi -theme /home/frenzy/.config/rofi/minimal.rasi"
SETUP_ROOT="$(dirname "$PWD")"

# Check if dots n themes exists
function search_for_dots() {
    echo "bruh"
}

# Copy dots
function copy_dots() {
    # Copy wallpapers
    cp -r ./.wallpapers $HOME/Pictures

    notify-send -i ./setup-scripts/resources/white-brush.png "[INFO]: Copying themes, icons, fonts and scripts..." &

}

# Download dots
function download_dots() {
    echo "bruh"
    
}

function setup_config {
    
}


# Menu Options
typeset -A menu_theme
function generate_map() {
	
	menu_theme[🗻 Nord]="setup_config 'Nord'"
	menu_theme[🏔 Nord Light]="setup_config 'NordLight'"
  	menu_theme[🏙 Argonaut Black]="setup_config 'ArgonautBlack'"
}
generate_map

# Store selection
selection="$(printf '%s\n' "${!menu_theme[@]}" | sort )"

# Variable passed to rofi
chosen="$(echo -e "$selection" | $rofi_theme -p " Choose your theme" -dmenu -selected-row 0)"


# Run this piece of garbage
if [[ $? -eq 0 && ! -z ${chosen} ]]; then
    echo "lebruh"
    echo "[ERROR]: no config with name " && notify-send -i $config_directory/dunst/icons/bruh.svg "[ERROR]: Selected theme does not exist"

    #i3-msg -q "exec ${menu[${chosen}]}"
else
    #echo "[ERROR]: no config with name \"$arg\" found" && notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[ERROR]: Selected theme does not exist" & ;;
    #echo "[ERROR]: no config with name \"$chosen\" found" && notify-send -i $config_directory/dunst/icons/bruh.svg "[ERROR]: Selected theme does not exist" & ;;
    echo "[ERROR]: no config with name " && notify-send -i $config_directory/dunst/icons/bruh.svg "[ERROR]: Selected theme does not exist"
fi

