#!/bin/sh

DATETIME=`date "+%Y%m%d-%H%M%S"`

PSQL_REMOTE_HOST=$(cat ${PSQL_REMOTE_HOST_FILE})

PSQL_USERNAME=$(cat ${PSQL_USERNAME_FILE})

PSQL_DBNAME=$(cat ${PSQL_DBNAME_FILE})

PGPASSWORD=$(cat ${PGPASSWORD_FILE})

PSQL_REMOTE_HOST_PORT=$(cat ${PSQL_REMOTE_HOST_PORT_FILE})

PSQL_SCHEMA=$(cat ${PSQL_SCHEMA_FILE})

echo $PSQL_REMOTE_HOST:$PSQL_REMOTE_HOST_PORT:$PSQL_DBNAME:$PSQL_USERNAME:$PGPASSWORD > ~/.pgpass

chmod 0600 ~/.pgpass

FILE=backup-$DATETIME

pg_dump -U $PSQL_USERNAME -h $PSQL_REMOTE_HOST -p $PSQL_REMOTE_HOST_PORT -d $PSQL_DBNAME -n $PSQL_SCHEMA -Ft > $FILE.tar


# --- gsutil to send the tar file to Google Cloud Storage 

gcloud auth activate-service-account io1-storage-dev-6179-sa@io1-storage-dev.iam.gserviceaccount.com --key-file=$GOOGLE_APPLICATION_CREDENTIALS

gcloud auth list
echo GOOGLE_APPLICATION_CREDENTIALS: $GOOGLE_APPLICATION_CREDENTIALS
gsutil ls $GCS_BUCKET_NAME




