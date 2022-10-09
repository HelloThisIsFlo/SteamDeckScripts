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
    set_brightness_to_minimum
    disable_sleep
    show_prompt
    block_until_mouse_click
    reenable_sleep
    restore_brightness
}

FUNC=$(declare -f run_as_root)
sudo bash -c "$FUNC; run_as_root"

cd - >/dev/null