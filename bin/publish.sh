#!/bin/bash -x

cd "$( dirname "${BASH_SOURCE[0]}" )/../remote"

# git clean?

if [ -n "$(git status --porcelain)" ]; then
  git status
  echo
  echo Working directory unclean.  Fixit.
  exit 1
fi

rm -f *.* .htaccess
rm -fr images/*
rm -f scripts/*


cp ../*.* ../.htaccess .
cp -r ../images/* ./images
cp ../script/* ./script


if [ -n "$(git status --porcelain)" ]; then
  git add .
  remove="$(git diff --name-status --cached | awk 'BEGIN {ORS=","} $1=="D" {print $2}')"
  changes="$(git diff --name-status --cached | awk '$1!="D" {print $2}')"

  curl -n --upload-file "${${changes%,}}" ftp://srednal.com/rmwts2018/

  for f in ${remove} do;
    curl -n --quote "-delete $f" ftp://srednal.com/rmwts2018/$f 



else
  echo No changes to publish.
fi
