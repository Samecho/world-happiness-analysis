@echo off
if not exist "%~dp0install_R_packages.R" (
  echo install_R_packages.R not found in project root.
  pause
  exit /b 1
)

echo Installing required R packages (may take a few minutes)...
Rscript install_R_packages.R
echo R package installation script finished.
pause

