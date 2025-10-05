@echo off
setlocal

if exist whr2024.db (
  echo Deleting existing whr2024.db ...
  del /Q whr2024.db
)

if not exist "WHR2024.csv" (
  echo ERROR: WHR2024.csv not found in current folder.
  pause
  goto :end
)

if not exist output (
  mkdir output
)

echo Recreating database and importing WHR2024.csv ...
echo .mode csv > import_tmp.sql
echo .headers on >> import_tmp.sql
echo .import WHR2024.csv whr_raw >> import_tmp.sql

sqlite3 whr2024.db < import_tmp.sql
del import_tmp.sql

echo Done.
sqlite3 -header -csv whr2024.db "SELECT COUNT(*) AS rows_imported FROM whr_raw;" > output/import_count.csv
type output\import_count.csv
pause

:end
endlocal
