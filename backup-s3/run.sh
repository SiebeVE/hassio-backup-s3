#!/bin/sh

KEY=`jq -r .awskey /data/options.json`
SECRET=`jq -r .awssecret /data/options.json`
BUCKET=`jq -r .bucketname /data/options.json`
ENDPOINT=`jq -r .endpoint /data/options.json`
REGION=`jq -r .region /data/options.json`

AWS_IGNORE_CONFIGURED_ENDPOINT_URLS=true
AWS_ENDPOINT_URL=$ENDPOINT

MOST_RECENT_FILE=$(ls -lt /backup | awk 'NR==2{print $9}')

mkdir -p ~/.aws

aws configure set aws_access_key_id $KEY
aws configure set aws_secret_access_key $SECRET

aws s3 cp /backup/$MOST_RECENT_FILE s3://$BUCKET --storage-class GLACIER

echo "Done"
