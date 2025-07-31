# World-Happiness-Analysis

A project using SQL and R to analyze the 2024 World Happiness Report.

---

## 📁 Files Overview

| File | Description |
|------|-------------|
| `WHR2024.csv` / `whr2024.db` | Dataset in CSV and SQLite formats |
| `init_continents_table.sql` | Creates `continents` table |
| `init_continent_column.sql` | Adds `continent_id` column to raw data |
| `update_continent_id.sql` | Populates `continent_id` for each country |
| `above_median_per_continent.sql` | View of countries ranking top 50% in all six happiness factors per continent |
| `happiness_index.sql` | Categorizes countries as `Very Happy`, `Happy`, `Sad`, `Very Sad` based on ladder score |
| `knn_predict.sql` | A MySQL-style stored procedure that simulates KNN using Euclidean distance |
| `knn_predict.r` | Predicts happiness score using KNN regression with tuning and v-fold CV |
| `initialization.r` | Data prep: split, normalize, etc. |
| `.bat` files | Run SQL scripts and print outputs in terminal |
| `README.md` | This file |

---

## ▶️ Quick Start

### 📦 Initialize Database (SQLite)

Run the following in your terminal or Command Prompt:

```bat
sqlite3 whr2024.db ".read init_continents_table.sql"
sqlite3 whr2024.db ".read init_continent_column.sql"
sqlite3 whr2024.db ".read update_continent_id.sql"
```

### 📊 Execute SQL Queries (with output)

```bat
above_median_per_continent_run.bat
happiness_index_run.bat
```

> These scripts run `.sql` files and display results using `sqlite3`.

---

## 📌 Notes

- The `above_median_per_continent` view filters countries that rank in the **top 50%** of their continent in **all** six happiness indicators:
  - GDP, Social support, Healthy life expectancy, Freedom, Generosity, Corruption perception

- `happiness_index.sql` uses nested averages to assign each country a 4-level happiness label.

- `knn_predict.sql` uses Euclidean distance to find the closest 5 countries to a given input vector.

- `knn_predict.r` uses `tidymodels` and `kknn` to fit and tune a regression model.

---

## 🧠 Requirements

- SQLite
- R
- Optional: MySQL (if you want to test `knn_predict.sql`)

---
