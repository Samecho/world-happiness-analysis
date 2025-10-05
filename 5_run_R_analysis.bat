@echo off
if not exist whr2024.db (
  echo ERROR: whr2024.db not found. Run 01_create_db_from_csv.bat first.
  pause
  exit /b 1
)

if not exist output (
  mkdir output
)

echo Running R scripts (clustering.r, knn_predict.r)...
Rscript clustering.r
Rscript knn_predict.r

echo R scripts finished. Check the output folder for generated images and CSVs.
pause
