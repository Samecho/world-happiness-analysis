@echo off
echo CHECK ENVIRONMENT
echo.

rem === Check sqlite3 ===
where sqlite3 >nul 2>&1
if %errorlevel% neq 0 (
  echo [!] sqlite3 NOT found in PATH.
  echo     Download sqlite3 command-line tools manually
  echo     URL ^> https://www.sqlite.org/download.html
) else (
  echo [OK] sqlite3 found at:
  where sqlite3
)
echo.

rem === Check Rscript ===
where Rscript >nul 2>&1
if %errorlevel% neq 0 (
  echo [!] Rscript NOT found in PATH.
  echo     Download R for Windows or Mac/Linux
  echo     URL ^> https://cran.r-project.org/bin/
) else (
  echo [OK] Rscript found at:
  where Rscript
)
echo.

echo If either sqlite3 or Rscript is missing, follow the URLs above to install.
pause
