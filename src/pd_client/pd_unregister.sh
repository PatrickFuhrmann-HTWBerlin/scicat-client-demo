#!/bin/bash
#
if [ $# -ne 1 ] ; then
   echo "Usage : pd_unregister <pid>" >&2
   exit 4
fi
#
PID=`echo $1 | awk -F/ '{ printf "%s%s%s",$1,"%2F",$2 }'`
curl --silent -X DELETE -H "Authorization: Bearer $SC_TOKEN" "https://public-data.desy.de/api/v3/Datasets/${PID}?access_token=$SC_TOKEN" | jq .id
exit $?
