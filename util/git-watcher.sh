#!/bin/bash

# Script to observe and perform auto-commits to a git repository.
# Usefull for keeping track of changes in codes/configurations in an automatic way.

# Author: Joao Pinheiro

PID_FILE=/tmp/git-watch.pid

if [[ $# -ge 1 ]]; then
    REPO=$1
    if [[ $# -ge 2 ]]; then
        INTERVAL=$2
    else
        INTERVAL=300
    fi
else
    echo -e "This script requires at least a repository path. Usage:\n"
    echo -e "\tgit-watcher.sh REPOSITORY_PATH [INTERVAL]\n"
    echo -e "For quiet operation, pipe STDERR and STDOUT to /dev/null: '&>/dev/null'"
    echo -e "Add '&' to the end of command to run in background."
    exit 1
fi

if [[ $1 == "kill" ]]; then
    if [[ -f $PID_FILE ]]; then
        echo -e "Killling process"
        kill $(cat $PID_FILE)
        rm $PID_FILE
        exit 0
    else
        echo "No process running."
        exit 0
    fi
elif [[ ! -d $REPO ]]; then
    echo -e "$REPO does not exist. Exiting."
    exit 1
elif [[ ! -d $REPO/.git ]]; then
    echo -e "$1 is not a git repository."
    exit 1
fi

echo "Monitoring $REPO with interval ${INTERVAL}s"

PID=$$
echo $PID > $PID_FILE
cd $REPO
while true; do
    if [[ ! -d $REPO/.git/rebase-merge ]] && [[ ! -d $REPO/.git/rebase-apply ]]; then
        git add . && git commit -a -m "$(date) - Automatic commit from git-watcher."
    else
        echo "Rebase in progress."
    fi
    sleep $INTERVAL
done
