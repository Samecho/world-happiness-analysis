required_pkgs <- c(
  "DBI", "RSQLite", "tidyverse", "tidymodels", "tidyclust", "ggplot2", "readr"
)

installed <- rownames(installed.packages())
to_install <- setdiff(required_pkgs, installed)

if(length(to_install) > 0){
  message("Installing: ", paste(to_install, collapse = ", "))
  install.packages(to_install, repos = "https://cloud.r-project.org")
} else {
  message("All required packages already installed.")
}

message("Done.")
