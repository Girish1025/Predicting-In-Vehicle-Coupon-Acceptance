
# Logistic regression training, evaluation, and feature importance

train_logistic_model <- function(train_data, target = "y") {
  formula_text <- paste(target, "~ .")
  
  logistic_model <- glm(
    as.formula(formula_text),
    data = train_data,
    family = binomial,
    control = list(maxit = 100)
  )
  
  return(logistic_model)
}

evaluate_logistic_model <- function(model, test_data, target = "y", threshold = 0.5) {
  probabilities <- predict(model, newdata = test_data, type = "response")
  predictions <- ifelse(probabilities > threshold, 1, 0)
  predictions <- factor(predictions, levels = levels(test_data[[target]]))
  actual <- factor(test_data[[target]], levels = levels(test_data[[target]]))
  
  confusion <- confusionMatrix(predictions, actual)
  
  roc_curve <- roc(
    as.numeric(as.character(actual)),
    probabilities,
    levels = c(0, 1),
    direction = "<"
  )
  
  auc_value <- auc(roc_curve)
  
  print(confusion)
  print(auc_value)
  
  return(list(
    model_name = "Logistic Regression",
    predictions = predictions,
    probabilities = probabilities,
    confusion_matrix = confusion,
    roc = roc_curve,
    auc = auc_value
  ))
}

plot_logistic_feature_importance <- function(model, top_n = 20) {
  coefficients <- coef(model)
  
  feature_importance <- data.frame(
    Feature = names(coefficients),
    Coefficient = as.numeric(coefficients)
  )
  
  feature_importance <- feature_importance %>%
    filter(Feature != "(Intercept)") %>%
    mutate(Abs_Coefficient = abs(Coefficient)) %>%
    arrange(desc(Abs_Coefficient)) %>%
    head(top_n)
  
  plot <- ggplot(feature_importance, aes(x = reorder(Feature, Abs_Coefficient), y = Abs_Coefficient)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    coord_flip() +
    labs(
      title = "Top Logistic Regression Features",
      x = "Feature",
      y = "Absolute Coefficient"
    ) +
    theme_minimal()
  
  print(plot)
  return(feature_importance)
}
