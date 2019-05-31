#!/bin/bash

docker-compose down
docker-compose up -d
docker exec -it ch03-vault sh
