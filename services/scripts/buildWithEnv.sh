#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
#    export "$(grep -v '^#' .env | xargs)"
    env $(cat .env | xargs) ./gradlew "$@"
else
    echo ".env file not found!"
    exit 1
fi