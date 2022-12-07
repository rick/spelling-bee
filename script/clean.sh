#!/bin/sh

#
# given a list of words on STDIN (from our original PDF of 2022 spelling bee words)
# remove all `*` and `OR` (for alternative spellings) and sort the list,
# then output the list to STDOUT
#
#
# Usage: ./clean.sh < spelling-bee-words.txt > spelling-bee-words-clean.txt

grep '[a-zA-z]' | sed 's,\*,,g' | sed 's,^OR ,,' | sort
