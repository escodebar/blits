#!/usr/bin/env bash

set -euo pipefail

docker run \
  --name $DB_CONTAINER \
  --rm \
  -p $DB_PORT:5432 \
  --env POSTGRES_PASSWORD=$DB_PASSWORD \
  --env POSTGRES_USER=$DB_USER \
  --env POSTGRES_DB=$DB_NAME \
  -dit \
  postgres

