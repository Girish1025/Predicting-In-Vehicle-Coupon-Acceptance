# LDA and QDA training and evaluation

train_lda_model <- function(train_data, target = "y") {
  formula_text <- paste(target, "~ .")
  lda_model <- lda(as.formula(formula_text), data = train_data)
  return(lda_model)
}

evaluate_lda_model <- function(model, test_data, target = "y") {
  predictions <- predict(model, newdata = test_data)
  pred_class <- factor(predictions$class, levels = levels(test_data[[target]]))
  actual <- factor(test_data[[target]], levels = levels(test_data[[target]]))
  
  confusion <- confusionMatrix(pred_class, actual)
  print(confusion)
  
  return(list(
    model_name = "Linear Discriminant Analysis",
    predictions = pred_class,
    probabilities = predictions$posterior[, 2],
    confusion_matrix = confusion
  ))
}

train_qda_model <- function(train_data, target = "y") {
  formula_text <- paste(target, "~ .")
  qda_model <- qda(as.formula(formula_text), data = train_data)
  return(qda_model)
}

evaluate_qda_model <- function(model, test_data, target = "y") {
  predictions <- predict(model, newdata = test_data)
  pred_class <- factor(predictions$class, levels = levels(test_data[[target]]))
  actual <- factor(test_data[[target]], levels = levels(test_data[[target]]))
  
  confusion <- confusionMatrix(pred_class, actual)
  print(confusion)
  
  return(list(
    model_name = "Quadratic Discriminant Analysis",
    predictions = pred_class,
    probabilities = predictions$posterior[, 2],
    confusion_matrix = confusion
  ))
}
