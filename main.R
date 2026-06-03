# main.R

source("R/00_libraries.R")
source("R/01_data_import_cleaning.R")
source("R/02_eda_functions.R")
source("R/03_feature_engineering.R")
source("R/04_model_preparation.R")
source("R/05_logistic_regression.R")
source("R/06_lda_qda_models.R")
source("R/07_model_evaluation.R")

# 1. Load and clean data
df_data <- load_and_clean_data(data_path)

# 2. Run selected EDA examples
plot_target_distribution(df_data, "y")
bivariate_analysis(df_data, "coupon", "y")
bivariate_analysis(df_data, "weather", "y")
bivariate_analysis(df_data, "destination", "y")
bivariate_analysis(df_data, "passenger", "y")

# 3. Feature engineering
df_engineered <- engineer_features(df_data)

# 4. Prepare model data
model_data <- prepare_model_data(df_engineered, target = "y", train_ratio = 0.7)
train_data <- model_data$train
test_data <- model_data$test

# 5. Logistic Regression
logistic_model <- train_logistic_model(train_data)
logistic_results <- evaluate_logistic_model(logistic_model, test_data)
plot_logistic_feature_importance(logistic_model)

# 6. Linear Discriminant Analysis
lda_model <- train_lda_model(train_data)
lda_results <- evaluate_lda_model(lda_model, test_data)

# 7. Quadratic Discriminant Analysis
qda_results <- tryCatch({
  qda_model <- train_qda_model(train_data)
  evaluate_qda_model(qda_model, test_data)
}, error = function(e) {
  message("QDA could not be fitted. This can happen when predictors are highly collinear or classes have near-zero variance.")
  message(e$message)
  NULL
})

# 8. Compare models
compare_models(logistic_results, lda_results, qda_results)

# 9. ROC curves
plot_roc_curve(test_data$y, logistic_results$probabilities, "Logistic Regression")
plot_roc_curve(test_data$y, lda_results$probabilities, "Linear Discriminant Analysis")
