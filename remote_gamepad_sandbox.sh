#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$DIR"

echo 'Hello world! Waiting 3 sec'
sleep 3
echo 'Goodbye. Exiting in 1 sec'
sleep 1

cd - >/dev/null
