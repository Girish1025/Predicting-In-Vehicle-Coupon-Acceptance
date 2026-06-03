# Model comparison and ROC plotting

compare_models <- function(logistic_results, lda_results, qda_results = NULL) {
  result_list <- list(logistic_results, lda_results)
  
  if (!is.null(qda_results)) {
    result_list <- append(result_list, list(qda_results))
  }
  
  results <- data.frame(
    Model = sapply(result_list, function(x) x$model_name),
    Accuracy = sapply(result_list, function(x) as.numeric(x$confusion_matrix$overall["Accuracy"]))
  )
  
  print(results)
  
  plot <- ggplot(results, aes(x = Model, y = Accuracy)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    labs(
      title = "Model Accuracy Comparison",
      x = "Model",
      y = "Accuracy"
    ) +
    theme_minimal()
  
  print(plot)
  return(results)
}

plot_roc_curve <- function(actual, probabilities, model_name) {
  roc_curve <- roc(
    as.numeric(as.character(actual)),
    probabilities,
    levels = c(0, 1),
    direction = "<"
  )
  
  plot(
    roc_curve,
    main = paste("ROC Curve -", model_name),
    col = "blue",
    lwd = 2
  )
  
  auc_value <- auc(roc_curve)
  print(auc_value)
  
  return(roc_curve)
}
