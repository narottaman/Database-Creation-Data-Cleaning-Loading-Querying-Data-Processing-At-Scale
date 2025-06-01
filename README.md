# Assignment-1-ngangada

# Assignment 1: Database Creation, Data Cleaning, Loading & Querying

## **Overview**
This repository contains the implementation for **CSE 511: Data Processing at Scale - Assignment 1**, which involves:
- Cleaning and preparing large-scale CSV data for ingestion.
- Creating and defining database tables for a subset of the **Pushshift Reddit Dataset**.
- Establishing relationships between tables using primary and foreign keys.
- Loading data efficiently into PostgreSQL using the `COPY` command.
- Executing SQL queries to extract meaningful insights.

## **Files in the Repository**
- `assignment1.sh` - A shell script to automate table creation, data loading, relation definition, and query execution.
- `create_tables.sql` - SQL script to create tables (`authors`, `subreddits`, `submissions`, `comments`).
- `create_relations.sql` - SQL script to define foreign key constraints and relationships between tables.
- `queries.sql` - SQL script containing five queries based on the assignment requirements.
- `data_cleaning.py` - Python script to clean raw CSV files before ingestion.
- `dps_cleaned/` - Folder containing cleaned CSV files (after running `data_cleaning.py`).

## **Database Schema**
The database consists of the following tables:
1. **authors** - Contains details about Reddit users, including their karma and profile information.
2. **subreddits** - Stores metadata about different subreddits.
3. **submissions** - Contains posts submitted to subreddits.
4. **comments** - Stores user comments linked to specific posts and subreddits.

## **SQL Queries**
The `queries.sql` script includes:
1. **Total number of comments by user `xymemez`.**
2. **Count of subreddits for each subreddit type.**
3. **Top 10 subreddits by comment count and their average score.**
4. **Users with average karma > 1,000,000, with a label indicating higher link karma.**
5. **Number of comments in subreddit types where `[deleted_user]` has commented.**

## **Execution Instructions**
### **1. Prerequisites**
Ensure that the following are installed:
- **PostgreSQL v14**
- **pg_bulkload** (for optimized data loading)
- **Python 3** (for data cleaning)
- **psycopg2** (`pip install psycopg2`)

### **2. Running the Scripts**
1. Clone this repository:
   ```sh
   git clone https://github.com/your-repo/CSE511-Assignment1.git
   cd CSE511-Assignment1
   ```

2. Run the Python cleaning script to clean raw CSV files before ingestion:
   ```sh
   python data_cleaning.py
   ```

3. Run the shell script to create tables, load data, and execute queries:
   ```sh
   bash assignment1.sh
   ```

## **3. Shell Script Explanation (`assignment1.sh`)**
The shell script automates the following tasks:
- **Creating tables** using SQL scripts.
- **Loading cleaned data** from CSV files into PostgreSQL.
- **Defining relationships** using foreign keys.
- **Executing queries** for analysis.

### **Shell Script Commands Explained**
```bash
#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

DB_NAME="postgres"
DB_USER="postgres"
DB_PASS="postgres"
DB_HOST="127.0.0.1"
DB_PORT="5432"

CSV_DIR="C:\\Users\\Narottaman\\Videos\\DPS\\dps_files\\dps_cleaned"  # Path to cleaned CSV files

START_TIME=$(date +%s)  # Start timer for execution time measurement

export PGPASSWORD="$DB_PASS"  # Set PostgreSQL password for authentication

# Step 1: Creating tables
echo "Creating tables..."
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" <<EOF
\timing
\i create_tables.sql
EOF

# Step 2: Loading cleaned data using COPY
echo "Loading data into PostgreSQL..."
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" <<EOF
\timing
\copy subreddits FROM '$CSV_DIR\\subreddits.csv' WITH CSV HEADER DELIMITER ',';
\copy authors FROM '$CSV_DIR\\authors.csv' WITH CSV HEADER DELIMITER ',';
\copy submissions FROM '$CSV_DIR\\submissions.csv' WITH CSV HEADER DELIMITER ',';
\copy comments FROM '$CSV_DIR\\comments.csv' WITH CSV HEADER DELIMITER ',';
EOF

# Step 3: Defining relationships
echo "Defining relationships..."
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" <<EOF
\timing
\i create_relations.sql
EOF

# Step 4: Executing queries
echo "Executing queries..."
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" <<EOF
\timing
\i queries.sql
EOF

END_TIME=$(date +%s)  # End timer
TOTAL_TIME=$((END_TIME - START_TIME))
echo "Total execution time: $TOTAL_TIME seconds."
```

## **4. Optimized Data Loading (`COPY` Command)**
Instead of inserting rows one-by-one, the script uses:
```sql
\copy table_name FROM 'file_path.csv' WITH CSV HEADER DELIMITER ',';
```
### **Advantages of `COPY` over `INSERT`**
 Faster than inserting rows individually.  
 Handles large datasets efficiently.  
 Works directly with CSV files.  

## **5. Cleaning Data Before Uploading (`data_cleaning.py`)**
Before loading data, we clean CSV files to remove special characters and encoding issues.

### **Installation of Required Libraries**
To ensure compatibility with PostgreSQL, install `psycopg2`:
```sh
pip install psycopg2
```

### **Data Cleaning Process**
```python
import csv
import os

input_dir = "C:/Users/Narottaman/Downloads/dps_files"
output_dir = "C:/Users/Narottaman/Downloads/dps_files/dps_cleaned"

os.makedirs(output_dir, exist_ok=True)
files = ["comments.csv", "submissions.csv", "authors.csv", "subreddits.csv"]

def clean_text(text):
    if text is None:
        return ''
    return text.encode("utf-8", "ignore").decode("utf-8").strip('"')

def clean_csv(input_file, output_file):
    with open(input_file, 'r', encoding='windows-1252', errors='ignore') as infile, \
         open(output_file, 'w', encoding='utf-8') as outfile:
        reader = csv.reader(infile)
        writer = csv.writer(outfile)
        for row in reader:
            writer.writerow([clean_text(field) if not field.isdigit() else field for field in row])
    print(f"✅ CSV cleaned and saved: {output_file}")

for file in files:
    clean_csv(os.path.join(input_dir, file), os.path.join(output_dir, file))
```

## **6. Notes**
- Ensure PostgreSQL is running at `127.0.0.1:5432`.
- Do **not** modify table or column names.
- The CSV files must be stored in the correct directory (`dps_cleaned/`).

## **Author**
**Narottaman Gangadaran**

