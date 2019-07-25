#!/bin/sh

docker secret rm PSQL_REMOTE_HOST
echo $PSQL_REMOTE_HOST | docker secret create PSQL_REMOTE_HOST -

docker secret rm PSQL_USERNAME
echo $PSQL_USERNAME | docker secret create PSQL_USERNAME -

docker secret rm PSQL_DBNAME
echo $PSQL_DBNAME | docker secret create PSQL_DBNAME -

docker secret rm PGPASSWORD
echo $PGPASSWORD | docker secret create PGPASSWORD -

docker secret rm PSQL_REMOTE_HOST_PORT
echo $PSQL_REMOTE_HOST_PORT | docker secret create PSQL_REMOTE_HOST_PORT -

docker secret rm PSQL_SCHEMA
echo $PSQL_SCHEMA | docker secret create PSQL_SCHEMA -

docker secret rm GCS_BUCKET_NAME
echo $GCS_BUCKET_NAME | docker secret create GCS_BUCKET_NAME -

docker secret rm GCLOUD_SCV_ACCOUNT_CREDENTIALS_FILE.json
docker secret create GCLOUD_SCV_ACCOUNT_CREDENTIALS_FILE.json $PATH_TO_GCLOUD_SCV_ACCOUNT_CREDENTIALS_FILE