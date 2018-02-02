#!/bin/sh

cd "$( dirname "${BASH_SOURCE[0]}" )"

rm ../*.html

for body in *_body.html; do

  title=$(head -1 $body | sed -n -e 's/<!-- \(.*\) -->/\1/p')

  file=../${body%_body.html}.html

  sed -e "s/~~TITLE~~/$title/g" -e "/~~BODY~~/r $body" -e "/~~BODY~~/d" container.html > $file

done
