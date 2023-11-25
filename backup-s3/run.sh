#!/bin/sh

KEY=`jq -r .awskey /data/options.json`
SECRET=`jq -r .awssecret /data/options.json`
BUCKET=`jq -r .bucketname /data/options.json`
ENDPOINT=`jq -r .endpoint /data/options.json`
REGION=`jq -r .region /data/options.json`
PROFILE=`jq -r .profile /data/options.json`

MOST_RECENT_FILE=$(ls -lt /backup | awk 'NR==2{print $9}')

ls -lt /backup
ls -lt /backup | awk 'NR==2{print $9}'
echo $MOST_RECENT_FILE

PROFILE_CONTENT="[profile $PROFILE]
region = $REGION
s3 =
  endpoint_url = $ENDPOINT
  signature_version = s3v4
  max_concurrent_requests = 100
  max_queue_size = 1000
  multipart_threshold = 50MB
  multipart_chunksize = 10MB
s3api =
  endpoint_url = $ENDPOINT"

mkdir -p ~/.aws
echo $PROFILE_CONTENT > ~/.aws/config

cat ~/.aws/config

echo "aws s3 cp /backup/$MOST_RECENT_FILE s3://$BUCKET --profile $PROFILE --storage-class GLACIER"

now="$(date +'%d/%m/%Y - %H:%M:%S')"

echo $now

aws configure set aws_access_key_id $KEY --profile $PROFILE
aws configure set aws_secret_access_key $SECRET --profile $PROFILE

aws s3 cp /backup/$MOST_RECENT_FILE s3://$BUCKET --profile $PROFILE --storage-class GLACIER

echo "Done"
