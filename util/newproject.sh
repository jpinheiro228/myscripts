#!/bin/bash

PROJECT_HOME=$HOME/git-repos
PROJECT_NAME=$1
PROJECT_PATH=$PROJECT_HOME/$PROJECT_NAME

if [ ! $# -eq 1 ]; then
    echo "Please name your project:"
    echo
    echo "./newproject MyProject"
    exit 1
fi

if [ ! -f $HOME/.gitconfig ]; then
    echo "Please configure git first:"
    echo
    echo "git config --global user.name \"Your Name\""
    echo "git config --global user.email \"Your Email\""
    exit 1
fi

if [ ! -d $PROJECT_PATH ]; then
    mkdir -p $PROJECT_PATH
else
    echo "Project already exists!"
    exit 0
fi

cd $PROJECT_PATH
echo "# $PROJECT_NAME" >> README.md

git init -q && git add . && git commit --quiet -m "Initial commit."

echo "Git repository initiated. Add your remotes if necessary."
echo
echo "Current branch is $(git branch --show-current)"
exit 0
