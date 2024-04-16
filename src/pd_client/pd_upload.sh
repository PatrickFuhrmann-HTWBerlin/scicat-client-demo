#!/bin/bash
#
if [ $# -ne 1 ] ; then
   echo "Usage : pd_upload <dataset directory>" >&2
   exit 4
fi
ds=$1
if [ ! -d ${ds} ] ; then
   echo "Dataset doesn't exist : ${ds}" >&2
   exit 5
fi

#
for c in ${ds}/*.JPG ; do
   echo "Uploading $c"
   rclone copy -l $c HIFIS:patrick/${ds}/
done
