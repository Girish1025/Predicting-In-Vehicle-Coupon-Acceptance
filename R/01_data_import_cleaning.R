# Data import, cleaning, missing-value handling, and basic preprocessing

get_mode <- function(x) {
  x <- na.omit(x)
  uniq_x <- unique(x)
  uniq_x[which.max(tabulate(match(x, uniq_x)))]
}

load_and_clean_data <- function(file_path) {
  if (!file.exists(file_path)) {
    stop(paste("File not found:", file_path))
  }
  
  df_data <- read.csv(file_path, stringsAsFactors = FALSE)
  
  # Rename original misspelled column if present
  if ("passanger" %in% names(df_data)) {
    df_data <- df_data %>% rename(passenger = passanger)
  }
  
  # Clean column names: lowercase and snake_case
  df_data <- df_data %>% clean_names()
  
  # Replace empty strings with NA
  df_data[df_data == ""] <- NA
  
  # Remove duplicates
  df_data <- df_data %>% distinct()
  
  # Drop car column because it has high missingness in the original dataset
  if ("car" %in% names(df_data)) {
    df_data <- df_data %>% select(-car)
  }
  
  # Drop direction_opp because it is redundant with direction_same
  if ("direction_opp" %in% names(df_data)) {
    df_data <- df_data %>% select(-direction_opp)
  }
  
  # Mode imputation for selected categorical columns
  impute_columns <- c(
    "bar",
    "coffee_house",
    "carry_away",
    "restaurant_less_than20",
    "restaurant20to50"
  )
  
  for (col in impute_columns) {
    if (col %in% names(df_data)) {
      df_data[[col]][is.na(df_data[[col]])] <- get_mode(df_data[[col]])
    }
  }
  
  # Convert character columns to factors for modeling
  character_columns <- names(df_data)[sapply(df_data, is.character)]
  df_data[character_columns] <- lapply(df_data[character_columns], as.factor)
  
  if ("y" %in% names(df_data)) {
    df_data$y <- as.factor(df_data$y)
  }
  
  return(df_data)
}
