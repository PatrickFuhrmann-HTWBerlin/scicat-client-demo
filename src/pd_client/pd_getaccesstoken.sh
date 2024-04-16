#!/bin/bash
#
if [ ! -f credentials.json ] ; then
   echo "Not found : credentials.json" >&2
   echo "" >&2
   echo "Format of credentials.json : '{\"username\":\"ingestor\", \"password\":\"<password>\"}'" >&2
   echo "" >&2
fi
#cat credentials.json | curl -s -L -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -d @- 'http://public-data.desy.de/api/v3/Users/login' | jq -r .access_token
