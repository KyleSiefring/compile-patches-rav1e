#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ "$1" != "" ]; then
    cd "$1"
fi

git checkout -q master

while "$DIR"/can_patch.sh
do
  git rev-parse HEAD
  git checkout -q HEAD~
done
