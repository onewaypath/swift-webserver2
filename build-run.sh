#!/bin/bash

# Create the configure.swift file or reset it to default values
echo "Initializing configure.swift..."
cp configure.template configure.swift

# Start the database container
echo "Starting the database container..."
docker-compose up -d db

# Prompt to continue
read -p "Press Enter to continue with building..."

# Build the project
echo "Building the project..."
swift build

# Prompt to continue
read -p "Press Enter to continue with running..."

# Run the project
echo "Running the project..."
swift run
