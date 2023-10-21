#!/bin/bash

# Stop the database container
docker-compose down

# Remove the associated volume
docker volume rm onewaypathcom_db_data

# Start a new container
docker-compose up -d db
