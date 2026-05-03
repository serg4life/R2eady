FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Evita prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Actualiza sistema e instala herramientas básicas
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    sudo \
    unzip \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
