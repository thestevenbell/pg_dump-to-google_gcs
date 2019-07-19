# pg_dump-to-google_gcs


## Description:
Dockerfile with Alpine Linux postgres-client that used the postgres-client executable pg_dump utility to download a backup of a PostrgreSQL database and then use the Google SDK gsutil to send the back up to Google Cloud Storage.


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

1. create the secrets needed in the container

        manage-secrets.sh
1. start the container using the provided docker-compose.yml file.  

        docker stack deploy -c docker-compose.yml pg_dump2GC
    
-----
## Resources
-  [pg_dump docs](https://www.postgresql.org/docs/9.6/app-pgdump.htm)