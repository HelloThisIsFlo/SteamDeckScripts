#!/bin/bash
set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

if [ -z ${1+x} ]; then 
    echo "Provide path to the video"
    exit 1
fi

movie_file_local=$1
movie_folder_on_deck=/home/deck/.steam/root/config/uioverrides/movies/
ssh steamdeck mkdir -p $movie_folder_on_deck
scp $movie_file_local steamdeck:$movie_folder_on_deck/deck_startup.webm


cd - >/dev/null
