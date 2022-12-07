#!/bin/bash

# TODO: lookup path to this directory
# TODO: and/or just port to Ruby

sed 's,\(.*\)$,curl -s https://ssl.gstatic.com/dictionary/static/sounds/oxford/\1--_us_1.mp3 -o audio/\1.mp3; echo "\1" | script/lookup.sh;  mpg123 -q -v audio/\1.mp3,' | sh -s
