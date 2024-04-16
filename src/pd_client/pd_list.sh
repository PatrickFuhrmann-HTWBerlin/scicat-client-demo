#!/bin/bash
#
curl --silent -H "Accept: application/json" -H "Authorization: Bearer $SC_TOKEN" 'https://public-data.desy.de/api/v3/Datasets/?access_token=$SC_TOKEN' | jq . | egrep '"id"|datasetName' | awk -F: '/datasetName/{ name=$2 }/"id"/{ printf "%s -> %s\n",$2,name }'
exit 0
