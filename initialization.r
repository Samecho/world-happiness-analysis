library(DBI)
library(RSQLite)
library(tidyverse)
library(tidymodels)

conn <- dbConnect(RSQLite::SQLite(), dbname = "whr2024.db")

dbListTables(conn)

whr_raw <- dbReadTable(conn, "whr_raw")


whr <- whr_raw |>
  mutate(across(Ladder.score:Explained.by..Perceptions.of.corruption, as.double)) |>
  drop_na(Ladder.score:Explained.by..Perceptions.of.corruption)

whr