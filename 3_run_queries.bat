@echo off
if not exist whr2024.db (
  echo ERROR: whr2024.db not found. Run 01_create_db_from_csv.bat first.
  pause
  exit /b 1
)

if not exist output (
  mkdir output
)

echo Running SQL scripts and exporting outputs...

rem create view and then export
sqlite3 whr2024.db ".read above_median_per_continent.sql"
sqlite3 -header -csv whr2024.db "SELECT * FROM above_median_per_continent;" > output/above_median_per_continent.csv

rem run happiness index query (this file itself contains a SELECT)
sqlite3 -header -csv whr2024.db ".read happiness_index.sql" > output/happiness_index.csv

echo Exports saved to output\*.csv
dir output
pause
