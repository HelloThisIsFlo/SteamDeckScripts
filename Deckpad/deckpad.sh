#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"
set -eo pipefail

# add_pipenv_to_path
# PATH=$PATH:$HOME/.local/bin


# echo 'Starting Virtual Here ...'
# sleep 1
# sudo ~/.virtualhere/vhusbdx86_64


function run_as_root() {
    source ./functions.sh

    # Start
    start_prompt
    set_brightness_to_minimum
    disable_sleep
    start_virtualhere

    # Run - Block until Tap on screen
    show_prompt "Tap To Quit !"
    block_until_mouse_click

    # Quit
    quit_prompt &
    restore_brightness
    reenable_sleep
    stop_virtualhere
}

FUNC=$(declare -f run_as_root)
sudo bash -c "$FUNC; run_as_root"

cd - >/dev/null