# Feature engineering functions

engineer_features <- function(df_data) {
  # Interaction-style categorical features
  if (all(c("destination", "passenger") %in% names(df_data))) {
    df_data$destination_passenger <- paste(df_data$destination, df_data$passenger, sep = "_")
  }
  
  if (all(c("weather", "temperature") %in% names(df_data))) {
    df_data$weather_temperature <- paste(df_data$weather, df_data$temperature, sep = "_")
  }
  
  if (all(c("marital_status", "has_children") %in% names(df_data))) {
    df_data$maritalstatus_children <- paste(df_data$marital_status, df_data$has_children, sep = "_")
  }
  
  # Travel time feature
  if (all(c("to_coupon_geq5min", "to_coupon_geq15min", "to_coupon_geq25min") %in% names(df_data))) {
    df_data <- df_data %>%
      mutate(
        to_coupon = case_when(
          to_coupon_geq25min == 1 ~ 2,
          to_coupon_geq15min == 1 ~ 1,
          TRUE ~ 0
        )
      ) %>%
      select(-to_coupon_geq5min, -to_coupon_geq15min, -to_coupon_geq25min)
  }
  
  # Age grouping
  if ("age" %in% names(df_data)) {
    df_data <- df_data %>%
      mutate(
        age_group = case_when(
          age %in% c("below21") ~ "Teenagers",
          age %in% c("21", "26", "31") ~ "Young_Adults",
          age %in% c("36", "41", "46") ~ "Middle_Aged_Adults",
          age %in% c("50plus") ~ "Seniors",
          TRUE ~ "Other"
        )
      )
  }
  
  # Income grouping
  if ("income" %in% names(df_data)) {
    df_data <- df_data %>%
      mutate(
        income_group = case_when(
          income %in% c("Less than $12500", "$12500 - $24999", "$25000 - $37499") ~ "Low_income",
          income %in% c("$37500 - $49999", "$50000 - $62499", "$62500 - $74999") ~ "Medium_income",
          income %in% c("$75000 - $87499", "$87500 - $99999", "$100000 or More") ~ "High_income",
          TRUE ~ "Other"
        )
      )
  }
  
  # Convert engineered character columns to factors
  character_columns <- names(df_data)[sapply(df_data, is.character)]
  df_data[character_columns] <- lapply(df_data[character_columns], as.factor)
  
  return(df_data)
}
