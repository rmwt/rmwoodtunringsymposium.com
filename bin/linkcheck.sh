#!/bin/bash

rm -rf /tmp/linklint
linklint -doc /tmp/linklint -http -host rmwoodturningsymposium.com '/@'
open /tmp/linklint/index.html
