#!/bin/sh

DATETIME=`date "+%Y%m%d-%H%M%S"`
PSQL_REMOTE_HOST=$(cat ${PSQL_REMOTE_HOST_FILE})
PSQL_USERNAME=$(cat ${PSQL_USERNAME_FILE})
PSQL_DBNAME=$(cat ${PSQL_DBNAME_FILE})
PGPASSWORD=$(cat ${PGPASSWORD_FILE})
PSQL_REMOTE_HOST_PORT=$(cat ${PSQL_REMOTE_HOST_PORT_FILE})
PSQL_SCHEMA=$(cat ${PSQL_SCHEMA_FILE})
GCS_BUCKET_NAME=$(cat ${GCS_BUCKET_NAME_FILE})

echo $PSQL_REMOTE_HOST:$PSQL_REMOTE_HOST_PORT:$PSQL_DBNAME:$PSQL_USERNAME:$PGPASSWORD > ~/.pgpass

chmod 0600 ~/.pgpass

FILE_NAME=backup-$DATETIME
FILE=$FILE_NAME.tar

echo starting backup process for $PSQL_REMOTE_HOST:$PSQL_REMOTE_HOST_PORT:$PSQL_DBNAME:$PSQL_USERNAME

#> pg_dump to download a tar database backup.  
pg_dump -U $PSQL_USERNAME -h $PSQL_REMOTE_HOST -p $PSQL_REMOTE_HOST_PORT -d $PSQL_DBNAME -n $PSQL_SCHEMA -Ft > $FILE

if [ -f "$FILE" ]; then
    echo "$FILE exists"
    if tar -tvf $FILE | grep toc.dat; then
        echo database backup file exists and contains toc.dat file. 
    else
        echo database backup file $FILE exists but does not contain backup data, exiting
        exit 1
    fi
else 
 echo database backup file $FILE does not exist, exiting
 exit 1
fi

#> gsutil to send the tar file to Google Cloud Storage 

SERVICE_ACCOUNT_CLIENT_EMAIL=$(cat $GOOGLE_APPLICATION_CREDENTIALS | jq -r  '.client_email') 

echo checking to ensure that gcloud authentication has been enabled.
gcloud auth list | grep $SERVICE_ACCOUNT_CLIENT_EMAIL
if [[ $? != 0 ]]; then
    echo gcloud auth was not enabled.
    echo gcloud auth activate-service-account started.

    gcloud auth activate-service-account $SERVICE_ACCOUNT_CLIENT_EMAIL --key-file=$GOOGLE_APPLICATION_CREDENTIALS

    if [[ $? != 0 ]]; then 
        echo gcloud auth activate-service-account failed. Exiting. 
        rm $FILE
        exit $?; 
    fi
else 
    echo gcloud authentication is enabled.
fi


echo starting gsutil cp $FILE ${GCS_BUCKET_NAME}/PSQL_${PSQL_DBNAME}/

gsutil cp $FILE ${GCS_BUCKET_NAME}/PSQL_${PSQL_DBNAME}/

if [[ $? != 0 ]]; then 
    echo gsutil cp $FILE ${GCS_BUCKET_NAME}/PSQL_${PSQL_DBNAME}/ failed. Exiting.
    rm $FILE
    exit $?; 
fi

echo Checking the contents of the bucket to ensure that the backup was uploaded.

gsutil ls  ${GCS_BUCKET_NAME}/PSQL_${PSQL_DBNAME}/ | grep $FILE

if [[ $? != 0 ]]; then 
    echo The backup was not found in the bucket. Exiting. 
    exit $?; 
fi

echo Success! The backup file was uploaded. Cleaning up and exiting.  

rm $FILE

exit 0