#!/bin/bash

INTERVAL=300

cd $1

if [[ -d .git ]]; then
    while true; do
        git add . && git commit -a -m "$(date) - Automatic commit."
        sleep $INTERVAL
    done
else
    echo "$1 is not a git repository."
fi
