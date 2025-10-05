@echo off
echo === RUNNING FULL PIPELINE ===
call 0_check_environment.bat
call 1_create_db_from_csv.bat
call 2_init_sql_tables.bat
call 3_run_queries.bat
call 4_install_R_packages.bat
call 5_run_R_analysis.bat

echo All steps finished. Opening output folder...
start "" output
pause
