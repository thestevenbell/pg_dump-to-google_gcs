# postgres-client-pg_dump-google-sdk


## Description:
Dockerfile with Alpine Linux postgres-client that used the postgres-client executable pg_dump utility to download a backup of a PostrgreSQL database and then use the Google SDK gsutil to send the back up to Google Cloud Storage.


-------
## Directions:
1. Set the environment variables 
```
export $PSQL_REMOTE_HOST=<psql:port>
export $PSQL_USERNAME=<username>
export $PSQL_DBNAME=<dbname>
export $PGPASSWORD=<userpassword>
```

1. then start the container using the provided docker-compose.yml file.  

        docker stack deploy -c docker-compose.yml pg_dump2GC
    
-----
## Resources
-  [pg_dump docs](https://www.postgresql.org/docs/9.6/app-pgdump.htm)