# Load required libraries

required_packages <- c(
  "caret",
  "MASS",
  "glmnet",
  "janitor",
  "ggplot2",
  "corrplot",
  "tidyr",
  "reshape2",
  "dplyr",
  "car",
  "gridExtra",
  "pROC"
)

missing_packages <- required_packages[!required_packages %in% rownames(installed.packages())]

if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}

invisible(lapply(required_packages, library, character.only = TRUE))

options(max.print = 10000000)
