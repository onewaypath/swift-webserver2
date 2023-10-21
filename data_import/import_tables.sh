#!/bin/bash

DATABASE_NAME="vapor_database"
DATABASE_USER="vapor_username"
DATABASE_PASSWORD="vapor_password"
DATABASE_HOST="localhost"
DATABASE_PORT="5432"
CSV_FOLDER="csv_tables"

# Use PGPASSWORD variable to pass the password to psql without prompting the user
export PGPASSWORD=$DATABASE_PASSWORD

# Prompt the user for processing type
echo "Do you want to process a single file or all files in the $CSV_FOLDER folder? (Enter 'single' or 'all'):"
read PROCESS_TYPE

process_csv() {
  CSV_FILE="$1"
  TABLE_NAME=$(basename "$CSV_FILE" .csv)
  
  # Get headers from CSV and replace ',' with ', '
  HEADERS=$(head -n 1 "$CSV_FILE" | sed 's/,/, /g')
  
  # Inform user of the file being processed
  echo "Processing $CSV_FILE..."
  
  # Use the COPY command with explicitly mapped columns to load the data from the preprocessed CSV file into the database table
  psql -h $DATABASE_HOST -p $DATABASE_PORT -U $DATABASE_USER -d $DATABASE_NAME -c "\COPY $TABLE_NAME($HEADERS) FROM '$CSV_FILE' WITH DELIMITER ',' CSV HEADER"
}

# Process 'projects' and 'teams' tables first
process_csv "$CSV_FOLDER/projects.csv"
process_csv "$CSV_FOLDER/teams.csv"

# Process other tables
for FILE in $CSV_FOLDER/*.csv; do
  TABLE_NAME=$(basename "$FILE" .csv)
  if [ "$TABLE_NAME" != "projects" ] && [ "$TABLE_NAME" != "teams" ]; then
    process_csv "$FILE"
  fi
done

# Unset the PGPASSWORD variable
unset PGPASSWORD
