#!/bin/ash

echo "Hi from script in Docker image built by Docker Compose YAML!"
echo "Passed argument: $*"
echo "Passed secret: $(cat /run/secrets/$1)"