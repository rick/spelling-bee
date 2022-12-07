#!/bin/bash


sed 's,^\(.*\)$,curl -s -H "Accept: application/json" -H "Content-Type: application/json" -o - "https://www.dictionaryapi.com/api/v3/references/sd3/json/\1?key='${API_KEY}'",' | \
	 sh -s -x | \
	 jq '.[].def[].sseq[][][1].dt[0][1]' | \
	 sed 's,{[^\{]*},,g' | \
	 grep '[a-zA-Z]' | \
	 sed 's,^,    ,'
