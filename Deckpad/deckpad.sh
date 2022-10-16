#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$DIR"
set -o pipefail

# add_pipenv_to_path
# PATH=$PATH:$HOME/.local/bin

# echo 'Starting Virtual Here ...'
# sleep 1
# sudo ~/.virtualhere/vhusbdx86_64

# Experiment
# source ./functions.sh
# battery=$(cat /sys/class/power_supply/BAT1/capacity)
# show_prompt "Tap To Quit!"
# show_prompt "$battery %"
# show_prompt $(date +'%s')
# run_prompt_start
# block_until_mouse_click
# run_prompt_stop

function run_as_root() {
    source ./functions.sh

    # Start
    set_brightness_to_minimum
    disable_sleep
    start_virtualhere

    # Run - Block until Tap on screen
    block_until_press_on_target

    # Quit
    run_prompt_stop
    quit_prompt &
    restore_brightness
    reenable_sleep
    stop_virtualhere
    wait
}

source ./functions.sh
prepare_fullscreen
show_prompt "Enter sudo password" 'big'
show_prompt "(screen will dim)" 'big'

FUNC=$(declare -f run_as_root)
sudo bash -c "$FUNC; run_as_root"

cd - >/dev/null
