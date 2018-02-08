#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

dirs=$(ls|grep -v '\.')

for d in $dirs; do
  pushd $d

    cat info.html | tr '<>' '\n\n'  | sed -n -e 's|^.*src="\([^"]*\)".*$|../../../2017/\1|gp' > imgs

    while read -r img; do
      cp "$img" .
      rm -f "$img"
    done < imgs


  popd
done
