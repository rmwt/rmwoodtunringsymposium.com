#!/bin/sh

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
  mkdir -p .${d}
  find .${d}  -depth 1 -type f -print0 | xargs -0 rm

  pushd .${d}
    # keep only things with a .*
    files="$(curl -n -l ${site}${d} | awk 'BEGIN {ORS=","} /.*\.[^.].+/ {print}')"

    if [ -n "${files}" ]; then
      curl -n -O "${site}${d}{${files%,}}"
    fi
  popd

done

if [ -n "$(git status --porcelain)" ]; then
  git status
  echo
  echo Download resulted in unclean directory.  Fixit.
  exit 1
fi
