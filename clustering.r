source("initialization.r")

set.seed(0)

kmeans_recipe <- recipe(~ Explained.by..Log.GDP.per.capita +
                            Explained.by..Social.support + 
                            Explained.by..Healthy.life.expectancy +
                            Explained.by..Freedom.to.make.life.choices +
                            Explained.by..Generosity +
                            Explained.by..Perceptions.of.corruption,data = whr) |>
    step_scale(all_predictors()) |>
    step_center(all_predictors())

kmeans_spec <- k_means(num_clusters = tune()) |>
    set_engine("stats")

whr_clust_ks <- tibble(num_clusters = 1:9)

kmeans_results <- workflow() |>
    add_recipe(kmeans_recipe) |>
    add_model(kmeans_spec) |>
    tune_cluster(resamples = vfold_cv(whr, v = 5), grid = whr_clust_ks) |>
    collect_metrics()

kmeans_elbow <- kmeans_results |>
    filter(.metric == "sse_within_total") |>
    mutate(total_WSSD = mean) |>
    select(num_clusters, total_WSSD)

elbow_plot <- ggplot(kmeans_elbow, aes(x = num_clusters, y = total_WSSD)) +
    geom_point(size = 2) +
    geom_line() +
    labs(x = "K", y = "Total within-cluster sum of squares") +
    scale_x_continuous(breaks = 1:9)

ggsave("output/elbow_plot.png", elbow_plot, width = 6, height = 4)

final_kmeans_spec <- k_means(num_clusters = 3) |>
    set_engine("stats")

final_kmeans_fit <- workflow() |>
    add_recipe(kmeans_recipe) |>
    add_model(final_kmeans_spec) |>
    fit(data = whr)

final_kmeans_fit
