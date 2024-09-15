#!/bin/sh

KEY=`jq -r .awskey /data/options.json`
SECRET=`jq -r .awssecret /data/options.json`
BUCKET=`jq -r .bucketname /data/options.json`
STORAGE_CLASS=`jq -r .storageclass /data/options.json`

MOST_RECENT_FILE=$(ls -lt /backup | awk 'NR==2{print $9}')

mkdir -p ~/.aws

aws configure set aws_access_key_id $KEY
aws configure set aws_secret_access_key $SECRET

echo "Moving backup $MOST_RECENT_FILE" 

aws s3 cp /backup/$MOST_RECENT_FILE s3://$BUCKET --storage-class $STORAGE_CLASS

echo "Done"