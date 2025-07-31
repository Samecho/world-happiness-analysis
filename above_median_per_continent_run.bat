@echo off
sqlite3 whr2024.db ".read above_median_per_continent.sql"
sqlite3 -header -column whr2024.db "SELECT * FROM above_median_per_continent;"
pause
