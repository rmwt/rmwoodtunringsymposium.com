#!/bin/bash -e

while [ $# != 0 ]; do
  case "$1" in
    --stage)
      site='srednal.com'
      dir='/rmwts2018/'
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

rm -rf /tmp/linklint
linklint -doc /tmp/linklint -http -host ${site} ${dir}@
open /tmp/linklint/index.html
