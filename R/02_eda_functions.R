# Reusable EDA functions

percent_value_counts <- function(df, feature, target) {
  df_summary <- df %>%
    group_by_at(vars(feature)) %>%
    summarise(
      Total_Count = n(),
      Accepted = sum(as.numeric(as.character(get(target))) == 1, na.rm = TRUE),
      Rejected = sum(as.numeric(as.character(get(target))) == 0, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    mutate(
      Total_Percent = round((Total_Count / sum(Total_Count)) * 100, 3),
      Percent_Accepted = round((Accepted / Total_Count) * 100, 3),
      Percent_Rejected = round((Rejected / Total_Count) * 100, 3)
    )
  
  return(df_summary)
}

bivariate_analysis <- function(df, feature, target) {
  df_eda <- percent_value_counts(df, feature, target)
  
  df_eda <- df_eda %>%
    mutate(
      Total_Label = paste0("(", Total_Percent, "%)"),
      Accepted_Label = paste0("(", Percent_Accepted, "%)")
    )
  
  plot <- ggplot(data = df_eda) +
    geom_bar(
      aes_string(x = feature, y = "Total_Count"),
      stat = "identity",
      fill = "grey",
      alpha = 0.7
    ) +
    geom_bar(
      aes_string(x = feature, y = "Accepted"),
      stat = "identity",
      fill = "steelblue",
      alpha = 0.7
    ) +
    geom_text(
      aes_string(x = feature, y = "Total_Count", label = "Total_Label"),
      vjust = -0.5,
      size = 3
    ) +
    geom_text(
      aes_string(x = feature, y = "Accepted", label = "Accepted_Label"),
      vjust = -0.5,
      size = 3
    ) +
    labs(
      title = paste("Accepted Coupons with respect to", feature),
      x = feature,
      y = "Coupon Counts"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  print(plot)
  return(df_eda)
}

plot_target_distribution <- function(df, target) {
  y_table <- table(df[[target]])
  y_percentage <- prop.table(y_table) * 100
  
  barplot_heights <- barplot(
    y_percentage,
    main = paste("Percentage Distribution of", target),
    col = c("skyblue", "lightcoral"),
    ylim = c(0, 100),
    ylab = "Percentage",
    xlab = "Class"
  )
  
  text(
    barplot_heights,
    y = y_percentage + 3,
    labels = paste0(round(y_percentage, 1), "%"),
    col = "black",
    cex = 1
  )
}

plot_correlation_matrix <- function(encoded_data, target = "y") {
  numeric_data <- encoded_data %>% select(where(is.numeric))
  correlation_matrix <- cor(numeric_data, use = "complete.obs")
  corrplot(correlation_matrix, method = "color", tl.cex = 0.6)
}
