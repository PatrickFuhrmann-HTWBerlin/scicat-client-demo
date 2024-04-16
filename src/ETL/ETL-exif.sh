#!/bin/bash
#
if [ $# -eq 0 ] ; then
   echo "Usage: <ETL> <filename>"
   exit 1
fi
filename=$1
printf "{\n"
/usr/local/bin/exiftool ${filename} | 
   awk -F" : "   \
        '/File Modification Date/{ 
               key=$1 ; val=$2 ;
               gsub(/^[\t ]+|[\t ]+$/, "", key) ;
               gsub(/^[\t ]+|[\t ]+$/, "", val) ; 
               sub(/:/, "-", val)
               sub(/:/, "-", val)
               sub(/ /, "T", val)
               printf "\"creationTime\":\"%s\",\n",val
        }
        /Make/{ printf "\"scientificMetadata\":{\n" }
        /Lens Info/{     printf "   \"Lens-Info\":\"%s\",\n",$2 }
        /Lens Model/{    printf "   \"Lens-Model\":\"%s\",\n",$2 }
        /Battery Level/{ printf "   \"Battery-Level\":\"%s\",\n",$2  }
        /Field Of View/{ printf "   \"Field of View\":\"%s\"\n",$2  }
        /Light Value/{ printf "},\n" }'

fp=`realpath ${filename}`
nx=`dirname ${fp}`
DATASET_NAME=`basename  $nx`
SOURCE_FOLDER=`dirname $nx`

printf "\"inputDatasets\":[\n"
printf "  \"%s\",\n" $fp
printf "  \"%s/metadata.json\"\n],\n" $nx

OWNER="Fuhrmann,Patrick"
OWNER_EMAIL="patrick.fuhrmann@desy.de"
#
printf "\"owner\":\"%s\",\n" $OWNER
printf "\"ownerEmail\":\"%s\",\n" $OWNER_EMAIL
printf "\"contactEmail\":\"%s\",\n" $OWNER_EMAIL
printf "\"sourceFolder\":\"%s\",\n" $SOURCE_FOLDER
printf "\"size\":0,\n"
printf "\"packedSize\":0,\n"
printf "\"type\":\"derived\",\n"
printf "\"keywords\":[],\n"
printf "\"description\":\"Pictures from Benasque\",\n"
printf "\"datasetName\":\"%s\",\n" $DATASET_NAME
printf "\"isPublished\":true,\n"
printf "\"ownerGroup\":\"it-ric\",\n"
printf "\"accessGroups\":[],\n"
printf "\"datasetlifecycle\":{\"archivable\":true,\"retrievable\":false,\"publishable\":false},\n"
printf "\"techniques\":[\"Light Photography\"],\n"
printf "\"investigator\":\"%s\",\n" $OWNER_EMAIL
printf "\"usedSoftware\":[\"curl\",\"SciCat\",\"dCache\"]\n}\n"
exit 0
