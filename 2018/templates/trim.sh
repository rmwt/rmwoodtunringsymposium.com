#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

for ff in images/*; do
  f=$(basename "$ff")

  if grep -q "$f" templates/*.*; then

    echo $f in use

  else

    echo removing $ff
    rm "$ff"
  fi
done
