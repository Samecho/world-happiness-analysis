# World Hapiness Analysis Using SQL and R 

This is a lightweight guide for running the WHR2024 project on Windows.

---

## **Prerequisites**
- Windows 10+  
- SQLite CLI (`sqlite3`) in PATH: https://www.sqlite.org/download.html  
- R (`Rscript` available in PATH): https://cran.r-project.org/bin/windows/  

---

## **Quick Start**
The simplest way to run everything:  

**Write `.\9_run_all.bat`  in Powershell to run `9_run_all.bat`** in the project root.

---

## **BAT Scripts Overview**
| File | Purpose |
|------|---------|
| `0_check_environment.bat` | Check `sqlite3` and `Rscript` availability |
| `01_create_db_from_csv.bat` | Import CSV to SQLite if DB is missing |
| `02_init_sql_tables.bat` | Create `continents` table, add `continent_id`, update values |
| `03_run_queries.bat` | Run SQL queries, export CSV outputs |
| `04_install_R_packages.bat` | Install required R packages (tidyverse, tidymodels) |
| `05_run_R_analysis.bat` | Run R scripts, generate plots |

---

## **Important Notes**
1. **SQLite vs MySQL:**  
   - `knn_predict.sql` uses MySQL-style procedures (`DELIMITER`, `CREATE PROCEDURE`, `CALL`).  
   - SQLite **does not support stored procedures**.  
   - Use `knn_predict.r` instead for kNN predictions.

2. **Outputs:**  
   - CSV: `output/above_median_per_continent.csv`, `output/happiness_index.csv`  
   - R plots: `elbow_plot.png`, `rmse_vs_k.png`

3. **Troubleshooting:**  
   - `sqlite3 not found` → add `sqlite3.exe` to PATH  
   - `Rscript not found` → install R and restart terminal  
   - R packages fail → run `install.packages()` manually
