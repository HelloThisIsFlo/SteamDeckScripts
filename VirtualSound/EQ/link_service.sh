#!/bin/bash
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

sudo ln -sf $PWD/easyeffects.service /usr/lib/systemd/user

cd - >/dev/null
