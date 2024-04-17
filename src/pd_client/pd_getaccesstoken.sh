#!/bin/bash
#
if [ -$# -eq 0 ] ; then
   echo "Usages: ... <credential.json" >&2
   exit 1
fi
CRED=$1
if [ ! -f $CRED ] ; then
   echo "'credentials.json' not found : $CRED" >&2
   echo "" >&2
   echo "Format of credentials.json : '{\"username\":\"ingestor\", \"password\":\"<password>\"}'" >&2
   echo "" >&2
fi

CRED_STRING=`cat ${CRED}`

TOKEN=`curl -s -L -X POST \
         -H 'Content-Type: application/json' \
         -H 'Accept: application/json' \
         -d "${CRED_STRING}" \
         'http://public-data.desy.de/api/v3/Users/login'`

if [ \( $? -ne 0 \) -o \( -z "${TOKEN}" \) ] ; then
   echo "Failed to create access token!" >&2
   exit 4
fi

TOKEN=`echo ${TOKEN} | jq -r .access_token`

echo "export SC_TOKEN=${TOKEN}"

exit 0
