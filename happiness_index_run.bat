@echo off
REM Run the query in happiness_index.sql
sqlite3 -header -column whr2024.db ".read happiness_index.sql"

REM Keep the console open
pause
