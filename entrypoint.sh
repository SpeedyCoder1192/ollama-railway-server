#!/bin/bash
set -e

export OLLAMA_HOST="0.0.0.0"
export OLLAMA_ORIGINS="*"
export OLLAMA_API_KEY="768e4e73d65a418d8d9c85b74b10a9aa.IwkxumohfDNPKVKb67ZvxfiF"

echo "Starting Ollama server..."
ollama serve &

# Wait until the server is ready
until curl -s http://localhost:11434/api/version > /dev/null; do
  echo "Waiting for Ollama to start..."
  sleep 2
done

echo "Logging in..."
ollama login

echo "Pulling models..."
for model in qwen3-coder:480b-cloud gpt-oss:120b-cloud gpt-oss:20b-cloud deepseek-v3.1:671b-cloud; do
  ollama pull "$model"
done

echo "All models pulled. Keeping server running."
wait
