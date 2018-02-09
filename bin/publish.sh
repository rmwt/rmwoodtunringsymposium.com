#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )/../remote"

dirs="/ /script/"

while [ $# != 0 ]; do
  case "$1" in
    --images) # include images
      dirs="$dirs /images/ /images/demo/ /images/vendor/ /images/sched/ /images/pdf/"
      shift
      ;;
    --test)
      site='ftp://srednal.com/rmwts2018'
      shift
      ;;
    --live)
      site='ftp://rmwoodturningsymposium.com'
      shift
      ;;
  esac
done

if [ -z "$site" ]; then
  echo "use --test OR --live"
  exit 1
fi

# git clean?
if [ -n "$(git status --porcelain)" ]; then
  git status
  echo
  echo Working directory unclean.  Fixit.
  exit 1
fi

for d in $dirs; do
  rm -f .${d}*.* .${d}.htaccess
  mkdir -p .${d}
  cp ..${d}*.* ..${d}.htaccess .${d}
done

if [ -n "$(git status --porcelain)" ]; then
  git add .
  remove="$(git diff --name-status --cached | awk '$1=="D" {print $2}')"
  changes="$(git diff --name-status --cached | awk 'BEGIN {ORS=","} $1!="D" {print $2}')"

  if [ -n "${changes}" ]; then
    curl -n --upload-file "{${changes%,}}" ${site}/
  fi

  for f in ${remove}; do
    curl -n --quote "-dele ${f}" ${site}
  done

  if [ -n "$(git status --porcelain)" ]; then
    git status
    echo Files published!  Commit or something.
  fi

else
  echo No changes to be published.
fi
