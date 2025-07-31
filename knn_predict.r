source("initialization.r")

set.seed(0)

whr_split <- initial_split(whr, prop = 0.75, strata = Ladder.score)
whr_train <- training(whr_split)
whr_test <- testing(whr_split)

whr_recipe <- recipe(Ladder.score ~ Explained.by..Log.GDP.per.capita +
                                    Explained.by..Social.support + 
                                    Explained.by..Healthy.life.expectancy +
                                    Explained.by..Freedom.to.make.life.choices +
                                    Explained.by..Generosity +
                                    Explained.by..Perceptions.of.corruption, 
                                    data = whr_train) |>
    step_scale(all_predictors()) |>
    step_center(all_predictors())

whr_spec <- nearest_neighbor(weight_func = "rectangular",
                              neighbors = tune()) |>
  set_engine("kknn") |>
  set_mode("regression")

whr_vfold <- vfold_cv(whr_train, v = 5, strata = Ladder.score)

whr_wkflw <- workflow() |>
  add_recipe(whr_recipe) |>
  add_model(whr_spec)

whr_wkflw

gridvals <- tibble(neighbors = seq(from = 1, to = 50, by = 1))

whr_results <- whr_wkflw |>
  tune_grid(resamples = whr_vfold, grid = gridvals) |>
  collect_metrics() |>
  filter(.metric == "rmse")

whr_results
