#!/bin/bash
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

# This script is SUPER basic for now
# Ideas for improvement
# - Make sure the file is in a subfolder called 'screenshots'
# - Make a script to automatically 'scp' all screenshots to my macbook
#   - Run it from macbook & connect to 'steamdeck' via ssh for the 'find' part


screenshots=$(ssh steamdeck find /home/deck/.local/share/Steam/userdata/12464430/ -name '*.jpg')

for file in $screenshots
do
   echo "$file"
   scp steamdeck:"$file" ./Screenshots
done


cd - >/dev/null
