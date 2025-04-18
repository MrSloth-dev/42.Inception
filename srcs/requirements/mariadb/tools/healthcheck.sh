#!/bin/bash
set -eo pipefail
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
mysqladmin ping -h localhost -u root -p"$DB_ROOT_PASSWORD" --silent
