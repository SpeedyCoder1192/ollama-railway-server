# Use Ubuntu as base image
FROM ubuntu:22.04

# Avoid interactive prompts during apt install
ENV DEBIAN_FRONTEND=noninteractive

# Update and install curl
RUN apt-get update && apt-get install -y curl

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | sh

# Expose Ollama
EXPOSE 11434
ENV OLLAMA_HOST=0.0.0.0

# Allow requests from any origin (important!)
ENV OLLAMA_ORIGINS="*"

# Pull cloud models
RUN ollama pull qwen3-coder:480b-cloud
RUN ollama pull gpt-oss:120b-cloud
RUN ollama pull gpt-oss:20b-cloud
RUN ollama pull deepseek-v3.1:671b-cloud

# Start Ollama server
CMD ["ollama", "serve"]
