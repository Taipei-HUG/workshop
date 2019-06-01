#!/bin/bash

unset VAULT_ADDR

docker-compose up -d

docker exec -it ch03-vault sh
