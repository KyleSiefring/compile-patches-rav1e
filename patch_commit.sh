#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ "$1" != "" ]; then
    cd "$1"
fi

hash="$(git rev-parse HEAD)"
# Give up at about 17f8e1bb175f58ed0e4c735b8fc5e48e5a1cb375

if [ $hash = "85a440497b2a1b53b5de0c466ba31c2c7c1658c8" ] ||
   [ $hash = "5271249e90a8fd93554a706f358e2d035a77080e" ] ||
   [ $hash = "2c83dfd61b8b2662614c0c79a1739b3bfbe44891" ] ||
   [ $hash = "6d306b642494ad0a92bb57f72b185df9eb6fa63c" ] ||
   [ $hash = "ea5f9e5ab17abebf9d367e17bcb1e29cc5676414" ]; then
  git diff HEAD HEAD~ | git apply -
elif git merge-base --is-ancestor HEAD 71ce5b48829bed343d60ebab0fa32992eab9a657 &&
     git merge-base --is-ancestor 9aca6b2600a0c851f5a110906e21b96c9075041d HEAD; then
  # Move foward instead of back. Previous good commit requires different patch.
  git diff HEAD a5d985db95799391871f288084a615f739b5784d | git apply -
fi

# Patches are in order of oldest first.
if git merge-base --is-ancestor HEAD 01ead5dce5f1781d12dff31b9c3717cf84fa9fad ; then
  git submodule update --init
elif git merge-base --is-ancestor HEAD 16fbf3e27a0f728ea9af9e022c5cef0ccbfba436 ; then
  # Borrow checker problem gone.
  # do nothing
  [ ]
elif git merge-base --is-ancestor HEAD d91583887409aad4a55f5c7f4eee1d0f31ec9443 ; then
  git apply ${DIR}/patches/505-d91583887409aad4a55f5c7f4eee1d0f31ec9443.diff
  if [[ $? -ne 0 ]] ; then
    break
  fi
elif git merge-base --is-ancestor HEAD 13cfd2416c0e4905fbc9c84d207e7763111c3e14 ; then
  # err-derive gone
  # do nothing
  [ ]
elif git merge-base --is-ancestor HEAD 16cce1dc574b9b093d2f9decd2f576dcef606ab4 ; then
  git apply ${DIR}/patches/504-16cce1dc574b9b093d2f9decd2f576dcef606ab4.diff
  if [[ $? -ne 0 ]] ; then
    break
  fi
elif git merge-base --is-ancestor HEAD e44bf1cb93ceba16e6a845e27f1a1a9fbac80712 ; then
  git apply ${DIR}/patches/503-e44bf1cb93ceba16e6a845e27f1a1a9fbac80712.diff
  if [[ $? -ne 0 ]] ; then
    break
  fi
elif git merge-base --is-ancestor HEAD 39b93e6a7ea4f99361fd88ab997a96ee9bc7a6f2 ; then
  git apply ${DIR}/patches/502-39b93e6a7ea4f99361fd88ab997a96ee9bc7a6f2.diff
  if [[ $? -ne 0 ]] ; then
    break
  fi
elif git merge-base --is-ancestor HEAD 4245f89efcf0cc99ada59765d1f8323d56e76e1b ; then
  git apply ${DIR}/patches/501-4245f89efcf0cc99ada59765d1f8323d56e76e1b.diff
  if [[ $? -ne 0 ]] ; then
    break
  fi
elif git merge-base --is-ancestor HEAD 37e3b59c0185a4e13bd67f010cf61569603128fb ; then
  git apply ${DIR}/patches/500-37e3b59c0185a4e13bd67f010cf61569603128fb.diff
  if [[ $? -ne 0 ]] ; then
    break
  fi
fi

# skip 85a440497b2a1b53b5de0c466ba31c2c7c1658c8
#  Bug for one commit. Compiles from a clean compile.

# skip 5271249e90a8fd93554a706f358e2d035a77080e
#  Bug for one commit. In broken commit inside of monty's PR

# skip 71ce5b48829bed343d60ebab0fa32992eab9a657,
#      5daaff85e6335ddf7b96c5b931bc18d2bd1a48b3,
#      9aca6b2600a0c851f5a110906e21b96c9075041d
#  Bug for commits mid PR. Uncompilable due to brace mismatch

# 2c83dfd61b8b2662614c0c79a1739b3bfbe44891
#  Broken commit mid PR.

# 6d306b642494ad0a92bb57f72b185df9eb6fa63c
#  Conflict between PRs.

# ea5f9e5ab17abebf9d367e17bcb1e29cc5676414
#  Broken commit.
