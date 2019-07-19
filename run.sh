#!/bin/sh

# PGPASSWORD=`cat /run/secrets/PGPASSWORD` pg_dump -U postgres -h localhost mydb > mydb.pgsql
# ~/.pgpass with localhost:5432:mydbname:postgres:mypass Then chmod 600 ~/.pgpass
# echo "$DB_HOST:5432:$DATABASE:$DB_USER:$PASSWORD" | ssh "$SSH_HOST" "cat > ~/.pgpass; chmod 0600 ~/.pgpass"
DATETIME=`date "+%Y%m%d-%H%M%S"`

PGPASS=$(cat /run/secrets/PGPASSWORD)

echo PGPASS $PGPASS

echo ls /run/secrets/PGPASSWORD: 

ls /run/secrets/PGPASSWORD

PGPASSWORD=$(cat /run/secrets/PGPASSWORD) pg_dump  -h $PSQL_REMOTE_ADDRESS -U $PSQL_USERNAME -D $PSQL_DBNAME -Ft > /data/backup-$DATETIME.tar

ls 

exit 0


