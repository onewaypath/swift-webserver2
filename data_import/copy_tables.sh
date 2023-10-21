#!/bin/bash

# Define parameters
CONTAINER_NAME=onewaypathcom-db-1
DB_USER=vapor_username
DB_NAME=vapor_database
OUTPUT_DIR_IN_CONTAINER=/csv_tables
OUTPUT_DIR_ON_HOST=./csv_tables

# Create directory inside the container
docker exec -it $CONTAINER_NAME mkdir -p $OUTPUT_DIR_IN_CONTAINER

# Get a list of tables in the database
TABLES=$(docker exec -it $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME -t -c "SELECT tablename FROM pg_tables WHERE schemaname='public';" | awk -F'|' 'NF{print $1}' | tr -d '[:space:]')

# Export each table to a CSV inside the container
for TABLE in $TABLES; do
    # Check if the table has rows
    ROW_COUNT=$(docker exec -it $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME -t -c "SELECT COUNT(*) FROM \"$TABLE\";" | tr -d '[:space:]')

    if [ "$ROW_COUNT" -gt "0" ]; then
        echo "Exporting $TABLE..."
        docker exec -it $CONTAINER_NAME psql -U $DB_USER -d $DB_NAME -c "\COPY \"$TABLE\" TO '$OUTPUT_DIR_IN_CONTAINER/$TABLE.csv' WITH CSV HEADER;"
    else
        echo "Skipping $TABLE since it's empty..."
    fi
done

# Copy the CSVs from the container to the host
docker cp $CONTAINER_NAME:$OUTPUT_DIR_IN_CONTAINER $OUTPUT_DIR_ON_HOST

echo "Export complete."
