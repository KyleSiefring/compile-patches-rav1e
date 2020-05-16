#!/bin/bash

if [ "$1" != "" ]; then
    cd "$1"
fi

# 0 is true, 1 is false
git merge-base --is-ancestor 5d41507f51c43d67b53ded11bd0148a8957199c7 HEAD
