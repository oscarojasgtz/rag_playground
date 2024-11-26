#!/bin/bash

set -e

# Step 1: Stop and clean up existing containers
echo "[Cleanup] Stopping and removing any existing containers."
docker-compose down --remove-orphans

wait_for_service() {
  local service_name=$1
  local health_check_command=$2
  local retry_count=30
  local wait_time=5

  echo "[$service_name] Waiting for the service to be ready."

  for i in $(seq 1 $retry_count); do
    if eval "$health_check_command"; then
      echo "[$service_name] The service is ready."
      return 0
    fi
    echo "[$service_name] The service is not ready. Retrying in $wait_time seconds... (Attempt $i/$retry_count)"
    sleep $wait_time
  done

  echo "[$service_name] The service is not ready after $retry_count attempts."
  exit 1
}

# Step 2: Start PostgreSQL
echo "[Postgres] Starting the service."
docker-compose up -d postgres
wait_for_service "postgres" "docker exec postgres pg_isready -U '$POSTGRES_USER' > /dev/null 2>&1"

# Step 3: Start Langfuse
echo "[Langfuse] Starting the service."
docker-compose up -d langfuse
wait_for_service "langfuse" "curl -s -o /dev/null -w '%{http_code}' http://localhost:3000 | grep 200"

echo "[Langfuse] The service is running. Opening URL in the browser..."
if ! xdg-open "http://localhost:3000" 2>/dev/null && ! open "http://localhost:3000" 2>/dev/null; then
  echo "[Langfuse] Open manually: http://localhost:3000"
fi

echo "[Langfuse] Create an account, organization, project, and API key; then update the .env file with those values and press enter to continue..."
read -r

# Step 4: Start Qdrant
echo "[Qdrant] Starting the service."
docker-compose up -d qdrant

# Step 5: Start Ollama
echo "[Ollama] Starting the service."
docker-compose up -d ollama
echo "[Ollama] Enter the model name to download:"
read -r model_name
echo "[Ollama] Downloading the model '$model_name'."
docker exec -it ollama ollama pull "$model_name"

# Step 6: Start Jupyter
echo "[Jupyter] Starting the service."
docker-compose up -d jupyter
sleep 60
echo "[Jupyter] Access the URL: $(docker logs jupyter 2>&1 | grep 'http://127.0.0.1:8888/lab?token=')"

echo "All services are running."
