# pg_dump-to-google_gcs


## Description:
Dockerfile with Alpine Linux postgres-client that used the postgres-client executable pg_dump utility to download a backup of a PostrgreSQL database and then use the Google SDK gsutil to send the back up to Google Cloud Storage.

The docker container is meant to be executed and then terminate after processing is complete.  It does not have a long running process to keep the container alive.  
-------
## Directions:
1. join or init a docker swarm
1. set the required environment variables.  These are passed as flags to the pg_dump command

        export $PSQL_REMOTE_HOST=<psql>
        export $PSQL_USERNAME=<username>
        export $PSQL_DBNAME=<dbname>
        export $PGPASSWORD=<userpassword>
        export PSQL_REMOTE_HOST_PORT=<port>
        export PSQL_SCHEMA=<schema>
        export GCS_BUCKET_NAME=<googleCloudStorageBucketName>
        export PATH_TO_GCLOUD_SCV_ACCOUNT_CREDENTIALS_FILE=<pathToBucket.json>

1. create the secrets needed in the container

        ./manage-secrets.sh
1. start the container using the provided docker-compose.yml file.  

        docker stack deploy -c docker-compose.yml pg_dump2GC
1. checkout the logs for the container with
        `docker service logs pg_dump2GC_pg_dump-to-google_gcs -f`
    
-----
## Resources
-  [pg_dump docs](https://www.postgresql.org/docs/9.6/app-pgdump.htm)