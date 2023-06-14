#!/bin/sh

echo "hello world"
su - postgres -c "pg_ctl start -D /var/lib/postgresql/data -l /var/lib/postgresql/log.log && psql --command \"ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';\" && psql --command \"CREATE DATABASE db;\" && psql -d db --command \"CREATE EXTENSION citext;
\"" &
./hermes server -config=config.hcl 