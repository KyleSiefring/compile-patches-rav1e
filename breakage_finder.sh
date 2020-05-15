#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "${DIR}/rav1e"

while git checkout HEAD~
do
  "${DIR}"/patch_commit.sh

  RUSTFLAGS=-Awarnings cargo build -q
  FAIL=$?
  git stash -q; git stash drop
  if [[ $FAIL -ne 0 ]] ; then
    break
  fi
done

# TODO
# Custom exit that clears git
