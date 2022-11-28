#!/bin/bash
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

sudo ln -sf $PWD/easyeffects.service /usr/lib/systemd/user
systemctl --user enable easyeffects.service
systemctl --user start easyeffects.service


cd - >/dev/null
