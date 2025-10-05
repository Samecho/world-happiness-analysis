@echo off
if not exist whr2024.db (
  echo ERROR: whr2024.db not found. Run 01_create_db_from_csv.bat first.
  pause
  exit /b 1
)

echo Running SQL initializations...
sqlite3 whr2024.db ".read init_continents_table.sql"
sqlite3 whr2024.db ".read init_continent_column.sql"
sqlite3 whr2024.db ".read update_continent_id.sql"

echo Done.
pause
