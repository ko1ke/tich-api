#!/bin/bash
docker-compose run web rails new . --api --force --no-deps --database=postgresql --skip-bundle
