#!/bin/bash
set -e

echo "Starting Ollama server..."
ollama serve &

# Wait until the server is ready
until curl -s http://localhost:11434/api/version > /dev/null; do
  echo "Waiting for Ollama to start..."
  sleep 2
done

echo "Pulling models..."
for model in qwen3-coder:480b-cloud gpt-oss:120b-cloud gpt-oss:20b-cloud deepseek-v3.1:671b-cloud; do
  ollama pull "$model"
done

echo "All models pulled. Keeping server running."
wait
