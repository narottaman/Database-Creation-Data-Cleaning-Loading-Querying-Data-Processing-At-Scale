#!/bin/bash

set -e

DB_NAME="postgres"
DB_USER="postgres"
DB_PASS="postgres"
DB_HOST="127.0.0.1"
DB_PORT="5432"

CSV_DIR="C:\\Users\\Narottaman\\Videos\\DPS\\dps_files\\dps_cleaned"
START_TIME=$(date +%s)  
export PGPASSWORD="$DB_PASS"

echo "Creating tables..."
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" <<EOF
\timing
\i create_tables.sql
EOF

echo "Loading data into PostgreSQL using COPY..."
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" <<EOF
\timing
\copy subreddits FROM '$CSV_DIR\\\\subreddits.csv' WITH CSV HEADER DELIMITER ','; 
\copy authors FROM '$CSV_DIR\\\\authors.csv' WITH CSV HEADER DELIMITER ','; 
\copy submissions FROM '$CSV_DIR\\\\submissions.csv' WITH CSV HEADER DELIMITER ','; 
\copy comments FROM '$CSV_DIR\\\\comments.csv' WITH CSV HEADER DELIMITER ',';
EOF

echo "Defining relationships..."
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" <<EOF
\timing
\i create_relations.sql
EOF

echo "Executing queries..."
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" <<EOF
\timing
\i queries.sql
EOF

END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))
echo " Total execution time: $TOTAL_TIME seconds."
