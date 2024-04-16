#!/bin/bash
#
if [ $# -ne 1 ] ; then
   echo "Usage : pd_register <meta_data>" >&2
   exit 4
fi
jsonfile=$1
if [ ! -f ${jsonfile} ] ; then
   echo "Metadata file ${jsonfile} not found!" >&2
   exit 5
fi
cat ${jsonfile} | 
   curl  --silent -L -X POST  \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        -H "Authorization: Bearer $SC_TOKEN"  -d @- \
        "https://public-data.desy.de/api/v3/Datasets?access_token=$SC_TOKEN" |
        jq .id 
exit $?
