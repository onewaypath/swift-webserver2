#!/bin/bash

DATABASE_NAME="vapor_database"
DATABASE_USER="vapor_username"
DATABASE_PASSWORD="vapor_password"
DATABASE_HOST="localhost"
DATABASE_PORT="5432"
CSV_FOLDER="csv_tables"

# Use PGPASSWORD variable to pass the password to psql without prompting the user
export PGPASSWORD=$DATABASE_PASSWORD

# Get a list of CSV files in the csv_tables folder and extract table names
TABLES=()
for FILE in $CSV_FOLDER/*.csv; do
  TABLE_NAME=$(basename "$FILE" .csv)
  TABLES+=("$TABLE_NAME")
done

# Prompt for confirmation before proceeding
echo "The following tables will be cleared of all data:"
for TABLE in "${TABLES[@]}"; do
  echo "- $TABLE"
done
read -p "WARNING: This will delete all data from the listed tables. Do you want to continue? (y/n): " CONFIRM

if [ "$CONFIRM" = "y" ]; then
  # Delete data from each table
  for TABLE in "${TABLES[@]}"; do
    psql -h $DATABASE_HOST -p $DATABASE_PORT -U $DATABASE_USER -d $DATABASE_NAME -c "DELETE FROM $TABLE"
    echo "Data deleted from the '$TABLE' table."
  done
else
  echo "Operation canceled."
fi

# Unset the PGPASSWORD variable
unset PGPASSWORD
