#!/bin/bash

MODEL_DIR="/root/.ollama/models/manifests/registry.ollama.ai/library"
MODEL_NAME="${OLLAMA_MODEL}"  # Asumimos que la variable OLLAMA_MODEL contiene el nombre del modelo

# Verificar si el modelo ya existe en la carpeta
if [ -d "${MODEL_DIR}/${MODEL_NAME}" ]; then
  echo "boostrap  | Model '${MODEL_NAME}' already exists, skipping download."
else
  echo "boostrap  | Model '${MODEL_NAME}' not found, downloading..."
  # Comando para descargar el modelo de Ollama, esto depende de cómo se descargue el modelo
  ollama pull "${MODEL_NAME}"
fi
