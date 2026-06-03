# Encoding and train-test split

prepare_model_data <- function(df_data, target = "y", train_ratio = 0.7) {
  if (!target %in% names(df_data)) {
    stop(paste("Target column not found:", target))
  }
  
  df_data[[target]] <- as.factor(df_data[[target]])
  
  # Remove rows with remaining missing values after cleaning
  df_data <- na.omit(df_data)
  
  # One-hot encoding
  formula_text <- paste(target, "~ .")
  encoded_predictors <- model.matrix(as.formula(formula_text), data = df_data)[, -1, drop = FALSE]
  encoded_data <- as.data.frame(encoded_predictors)
  encoded_data[[target]] <- df_data[[target]]
  
  # Remove zero-variance predictors
  near_zero <- nearZeroVar(encoded_data %>% select(-all_of(target)))
  if (length(near_zero) > 0) {
    encoded_data <- encoded_data[, -near_zero, drop = FALSE]
  }
  
  set.seed(123)
  train_index <- createDataPartition(encoded_data[[target]], p = train_ratio, list = FALSE)
  
  train_data <- encoded_data[train_index, ]
  test_data <- encoded_data[-train_index, ]
  
  return(list(
    train = train_data,
    test = test_data,
    full_data = encoded_data
  ))
}
