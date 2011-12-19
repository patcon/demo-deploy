#!/bin/sh
set -e

mysql -u root -p${SERVER_ROOT_PASSWORD} ${PROJECT} < ${PROJECT}.sql
rm ${PROJECT}.sql
