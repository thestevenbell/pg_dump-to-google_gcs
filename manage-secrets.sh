#!/bin/sh

docker secret rm PSQL_REMOTE_HOST
docker secret rm PSQL_USERNAME
docker secret rm PSQL_DBNAME
docker secret rm PGPASSWORD

echo -n $PSQL_REMOTE_HOST | docker secret create PSQL_REMOTE_HOST -
echo -n $PSQL_USERNAME | docker secret create PSQL_USERNAME -
echo -n $PSQL_DBNAME | docker secret create PSQL_DBNAME -
echo -n $PGPASSWORD | docker secret create PGPASSWORD -
