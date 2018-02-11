#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )/.."

rm *.html

cd templates

for body in *_body.html; do

  title=$(head -1 $body | sed -n -e 's/<!-- \(.*\) -->/\1/p')

  basefile=${body%_body.html}
  file=../${basefile}.html

  sed -e "s/~~TITLE~~/$title/g" -e "s/~~FILE~~/$basefile/g" -e "/~~BODY~~/r $body" -e "/~~BODY~~/d" container.html > $file

done

cd ..

echo linklint:

linklint -warn -error -xref -root . '/#'

echo tidy:

for f in *.html; do
  tdy="$(tidy -e -q $f 2>&1 | grep -v 'proprietary attribute "x-')"
  if [ -n "${tdy}" ]; then
    echo "$f: <${tdy}>"
  fi
done
