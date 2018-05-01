#!/usr/bin/env bash
set -e
echo "*-------------------------------------------------*"
echo "|       RESTORING BACKUP OLD DATABASE             |"
echo "*-------------------------------------------------*"

BACKUP_PATH=./backups

BK_FILENAME="$BACKUP_PATH/training_old.sql"

echo "setting up docker postgrese container"
docker-compose  up -d postgres
docker-compose  exec postgres dropdb --if-exists -U postgres training_prod_old
docker-compose  exec postgres createdb -U postgres training_prod_old


cat  $BK_FILENAME | docker  exec -i postgres psql -U postgres training_prod_old

echo "Production Database copied  successfully to local server ($BK_FILENAME). "


echo "*-------------------------------------------------*"
echo "|    COPING OLD DATABASE DATA TO NEW DATABASE     |"
echo "*-------------------------------------------------*"


rake db:migrate
rake old_db_import:execute


