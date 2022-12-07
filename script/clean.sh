#!/bin/sh

grep '[a-zA-z]' | sed 's,\*,,g' | sed 's,^OR ,,' | sort
