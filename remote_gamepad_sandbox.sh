#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

echo "Need 'sudo' => PUt password"
sudo echo 'all good'


# echo "now masking the targets, it shouldn't sleep anymore"
# sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target


# echo "now unmasking the targets, it should sleep again 😃"
# sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target


echo "Sleeping 1 hour"
sleep 3600


# echo 'Setting Brightness to the Minimum'
# sleep 1
# echo 0 > /sys/class/backlight/amdgpu_bl0/brightness

# echo 'Starting Virtual Here ...'
# sleep 1
# sudo ~/.virtualhere/vhusbdx86_64

cd - >/dev/null
