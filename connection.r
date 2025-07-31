library(DBI)
library(RSQLite)
library(tidyverse)
library(tidymodels)

conn <- dbConnect(RSQLite::SQLite(), dbname = "whr2024.db")

dbListTables(conn)

df <- dbReadTable(conn, "whr_raw")

glimpse(df)
