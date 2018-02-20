#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

for f in $(find images -type f); do

  if [ "$(basename $f)" != ".htaccess" ]; then

  if grep -q "$f" *.html; then

true
#    echo "$f" in use

  else

    echo =============== remove $f
     rm "$f"
  fi
fi
done
