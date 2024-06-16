#!/bin/bash

# Check if the directory path and file extension are provided as arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <directory> <file_extension>"
  exit 1
fi

# $# "No of input arguments"
# $0 "Current script file name"

# -ne stands for "not equal."
# -eq stands for "equal."
# -lt stands for "less than."
# -le stands for "less than or equal to."
# -gt stands for "greater than."
# -ge stands for "greater than or equal to."




directory="$1"
file_extension="$2"

# Use the 'find' command to list files with the specified extension in the specified directory
find "$directory" -type f -name "*.$file_extension" | while read -r file; do
  echo "$file"
done

## ================================================================
## Condition Checking syntax
## ================================================================


Numeric Conditions:
Test if a numeric value is greater than another: [ $a -gt $b ]
Test if a numeric value is less than or equal to another: [ $x -le $y ]


String Comparisons:
Test if two strings are equal: [ "$str1" = "$str2" ]
Test if two strings are not equal: [ "$str1" != "$str2" ]
Check if a string is empty: [ -z "$str" ]
Check if a string is not empty: [ -n "$str" ]


File and Directory Tests:
Check if a file exists: [ -e "$file" ]
Check if a file is a regular file (not a directory or special file): [ -f "$file" ]
Check if a file is a directory: [ -d "$dir" ]
Check if a file is executable: [ -x "$file" ]


Logical Operators:
Combine tests with logical operators:
Logical AND: [ condition1 ] && [ condition2 ]
Logical OR: [ condition1 ] || [ condition2 ]


Pattern Matching:
Use wildcards for pattern matching. For example, to check if a file name ends with ".txt": 
[ "$filename" = *.txt ]


Checking Return Codes:
Check if a command was successful 
(return code 0): 
[ $? -eq 0 ]


Testing Variables:
Test if a variable is set: [ -v my_var ]

if [ -v my_variable ]; then
  echo "my_variable is defined."
else
  echo "my_variable is not defined."
fi


Combining Tests:
Combine multiple conditions using logical operators. For example, checking if a file exists and is a regular file: 
[ -e "$file" ] && [ -f "$file" ]


## ================================================================
## 1. Batch Processing
## ================================================================

# Your ETL processing commands here
echo "Running ETL job..."

# Rest of your ETL logic


# Log the job completion
echo "ETL job completed."



## ================================================================
## 2. Data Extraction e.g. PostgreSQL database
## ================================================================
pg_dump -U username -d dbname -t tablename -f outputfile.sql



## ================================================================
## 3. Data Cleansing
## ================================================================

# Example: Remove duplicate lines from a CSV file
sort inputfile.csv | uniq > outputfile.csv

# Text manipulation commands

# grep: Used for searching and filtering text based on patterns or regular expressions. It's great for extracting lines that match specific criteria.

# awk: A powerful text processing tool for parsing and manipulating structured data. It's particularly useful for working with columns and fields in text files.

# sed: Stream editor for performing basic text transformations on an input stream (a file or input from a pipeline). It's commonly used for search and replace operations.

# cut: Used for removing sections from lines of files. It's often used for extracting specific columns or fields from text files.

# tr: Translates or deletes characters. It's useful for character-level transformations, such as changing case or replacing characters.

# join: Combines lines from two files based on a common field. It's commonly used for database-style operations on text files.

# comm: Compares two sorted files line by line. It can show lines that are common, unique to each file, or exclusive to the first or second file.

# paste: Merges lines from multiple files. It's often used to combine data side by side from different files.

# sort (yes, it's like itself): As you mentioned, it's used to sort lines in lexicographic order.

# uniq (also like itself): Removes consecutive duplicate lines from a sorted file. 


## ================================================================
## 4. File Manipulation: Move processed files to an archive folder
## ================================================================

processed_dir="/path/to/processed"
archive_dir="/path/to/archive"

mv "$processed_dir"/*.csv "$archive_dir"


## ================================================================
## 5. Error Handling:
## ================================================================

# Example: Monitor ETL job and send an email if it fails
if ! ./etl_job.sh; then
    echo "ETL job failed. Sending an email notification."
    # Code to send email
fi

## ================================================================
## 6. Logging:
## ================================================================

# Log file location
log_file="etl_log.txt"

# Redirect stdout and stderr to log file
exec > >(tee -a "$log_file") 2>&1

# save output 
exec > >(tee -a "$log_file")

# save error 
exec 2> >(tee -a "$log_file")

# save output and log separate
exec > >(tee -a "$stdout_log_file") 2> >(tee -a "$stderr_log_file")


# Example: ETL processing steps
echo "ETL process started: $(date)"
echo "Extracting data..."
# ETL logic here
echo "Data loaded to the warehouse."


## ================================================================
## create a new Bash script
## ================================================================
touch my_script.sh
nano my_script.sh

->#!/bin/bash
echo "Hello, World!"

chmod +x my_script.sh #Make the Script Executable:
./my_script.sh #Run the Script:
