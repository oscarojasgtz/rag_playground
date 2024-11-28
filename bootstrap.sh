#!/bin/bash

set -e

message() {
  local message_text=$1
  echo "boostrap  | $message_text"
}

start_service(){
  local service=$1
  message "Starting $service"
  docker-compose up -d "$service"
}

# PREPARE
message "Removing orphans"
docker-compose down --remove-orphans
docker-compose build

# START SOME CONTAINERS
services=("ollama" "qdrant" "postgres" "langfuse")
for item in "${services[@]}"; do
  start_service "$item"
done

# DOWNLOAD OLLAMA MODEL
docker exec ollama bash -c "sh mnt/model-downloader.sh"

# SET THE LANGFUSE KEYS
if ! grep -q "LANGFUSE_SECRET_KEY" .env; then
  echo "boostrap  | Insert the LangFuse secret key:"
  read -r LANGFUSE_SECRET_KEY
  echo "LANGFUSE_SECRET_KEY=${LANGFUSE_SECRET_KEY}" >> .env
else
  echo "boostrap  | LANGFUSE_SECRET_KEY already exists in .env, skipping input."
fi

if ! grep -q "LANGFUSE_PUBLIC_KEY" .env; then
  echo "boostrap  | Insert the LangFuse public key:"
  read -r LANGFUSE_PUBLIC_KEY
  echo "LANGFUSE_PUBLIC_KEY=${LANGFUSE_PUBLIC_KEY}" >> .env
else
  echo "boostrap  | LANGFUSE_PUBLIC_KEY already exists in .env, skipping input."
fi

# START JUPYTER
start_service "jupyter"
message "The services are up and ready to use."
message "Wait 50 seconds for the Jupyter token."
sleep 50
message "Jupyter URL: $(docker logs jupyter 2>&1 | grep 'http://127.0.0.1:8888/lab?token=')"
