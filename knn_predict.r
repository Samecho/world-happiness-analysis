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

whr_k_plot <- ggplot(whr_results, aes(x = neighbors, y = mean)) +
  geom_line() +
  geom_point() +
  labs(title = "RMSE vs Number of Neighbors (k)",
    x = "Number of Neighbors (k)",
    y = "Cross-validated RMSE")


ggsave("output/rmse_vs_k.png", whr_k_plot, width = 6, height = 4)

whr_min <- whr_results |>
  filter(mean == min(mean))

kmin <- whr_min |> pull(neighbors)

whr_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = kmin) |>
  set_engine("kknn") |>
  set_mode("regression")

whr_fit <- workflow() |>
  add_recipe(whr_recipe) |>
  add_model(whr_spec) |>
  fit(data = whr_train)

whr_summary <- whr_fit |>
  predict(whr_test) |>
  bind_cols(whr_test) |>
  metrics(truth = Ladder.score, estimate = .pred) |>
  filter(.metric == 'rmse')

whr_summary

# This country stats could be changed!
new_country <- tibble(
  Explained.by..Log.GDP.per.capita = 1.0,    
  Explained.by..Social.support = 1.0,        
  Explained.by..Healthy.life.expectancy = 0.5,
  Explained.by..Freedom.to.make.life.choices = 0.5, 
  Explained.by..Generosity = 0.25,           
  Explained.by..Perceptions.of.corruption = 0.5)

predict(whr_fit, new_country)
