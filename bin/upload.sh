#!/bin/bash -e

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

while [ $# != 0 ]; do
  case "$1" in
    --stage)
      site='srednal.com'
      dir='/rmwts2018'
      shift
      ;;
    --live)
      site='rmwoodturningsymposium.com'
      dir='/'
      shift
      ;;
  esac
done

if [ -z "${site}" ]; then
  echo "Use --stage or --live"
  exit 1
fi

lftp <<EOF
set cmd:fail-exit yes
set ftp:list-options -a
set ssl:verify-certificate no

open ${site}
cd ${dir}

mirror --reverse --verbose --delete --use-cache --parallel=2 --exclude-glob-from=bin/upload-excludes
EOF
