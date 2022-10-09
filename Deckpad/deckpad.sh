#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"
set -eo pipefail




# add_pipenv_to_path
PATH=$PATH:$HOME/.local/bin

# show_prompt
# block_until_mouse_click

# exit

# pipenv run python sandbox.py


# echo "Need 'sudo' => PUt password"
# sudo echo 'all good'


# echo "now masking the targets, it shouldn't sleep anymore"
# sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target


# echo "now unmasking the targets, it should sleep again 😃"
# sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target



# DURATION=3
# echo "Sleeping for $DURATION sec"
# sleep $DURATION

# echo "Sleeping 1 hour"
# sleep 3600


# echo 'Setting Brightness to the Minimum'
# sleep 1
# echo 0 > /sys/class/backlight/amdgpu_bl0/brightness

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