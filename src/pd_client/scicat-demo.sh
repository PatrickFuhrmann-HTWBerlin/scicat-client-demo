#!/usr/bin/env bash

# create credentials.json
echo '{"username":"ingestor", "password":"fCwe5gF8x^nGZBX"}' > credentials.json

# login first
export SC_TOKEN=`cat credentials.json | curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' \
 -d @- 'http://public-data.desy.de/api/v3/Users/login' | jq -r .access_token`

# or copy the token from the WebUI and export it as $SC_TOKEN alternatively.

# get all public datasets
curl -H "Accept: application/json" https://public-data.desy.de/api/v3/Datasets

# get all datasets available for ingestor
curl -H "Accept: application/json" -H "Authorization: Bearer $SC_TOKEN" "https://public-data.desy.de/api/v3/Datasets/?access_token=$SC_TOKEN"

# create dataset
cat metadata.json | curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H "Authorization: Bearer $SC_TOKEN" \
 -d @- http://public-data.desy.de/api/v3/Datasets?access_token=$SC_TOKEN

# delete dataset by PID
curl -X DELETE -H "Authorization: Bearer $SC_TOKEN" https://public-data.desy.de/api/v3/Datasets/PID?access_token=$SC_TOKEN

