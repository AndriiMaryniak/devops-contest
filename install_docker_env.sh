#!/bin/bash

sudo apt-get update

sudo apt-get install -y docker.io docker-compose-v2

sudo usermod -aG docker $USER

echo "Docker та Docker Compose success installed "
