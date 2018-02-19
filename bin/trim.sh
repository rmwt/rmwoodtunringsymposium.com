#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

for ff in images/*.* images/demos/*.* images/demos/*/*.* images/pdf/*.* images/vendors/*.*; do
  f=$(basename "$ff")

  if grep -q "$f" *.html; then

    echo $f in use

  else

    echo =============== remove $ff
    # rm "$ff"
  fi
done
