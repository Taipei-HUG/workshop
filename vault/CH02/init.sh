#!/bin/bash
set -x

# Load .env variables
export $(egrep -v '^#' .env | xargs)

vault secrets enable database

vault write database/config/my-database \
    plugin_name=mysql-database-plugin \
    connection_url="{{username}}:{{password}}@tcp(mysql:3306)/" \
    allowed_roles=my-role username=${MYSQL_ROOT_USERNAME} password=${MYSQL_ROOT_PASSWORD}

vault write database/roles/my-role \
    db_name=my-database \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="2h"
