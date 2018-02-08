#!/bin/sh

# include images
dirs="/ /script/"
if [ "$1" = "-i" ]; then
  dirs="$dirs /images/ /images/demo/ /images/vendor/ /images/sched/ /images/pdf/"
fi

cd "$( dirname "${BASH_SOURCE[0]}" )/../remote"

# git clean?

if [ -n "$(git status --porcelain)" ]; then
  git status
  echo
  echo Working directory unclean.  Fixit.
  exit 1
fi

for d in $dirs; do
  mkdir -p .$d
  pushd .$d
  rm -f .* *
    # remove . and .., keep only things with a . (*.*, not dirs)
    files="$(curl -n -l ftp://srednal.com/rmwts2018$d | awk 'BEGIN {ORS=","} /.*\.[^.].+/ {print}')"

    curl -n -O "ftp://srednal.com/rmwts2018$d{${files%,}}"

  popd

done

if [ -n "$(git status --porcelain)" ]; then
  git status
  echo
  echo Download resulted in unclean directory.  Fixit.
  exit 1
fi
