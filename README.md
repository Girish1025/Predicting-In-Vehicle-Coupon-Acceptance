# Predicting In-Vehicle Coupon Acceptance

## Project Overview
This project predicts whether a driver will accept an in-vehicle coupon based on contextual, demographic and behavioral factors. The analysis uses the In-Vehicle Coupon Recommendation dataset and applies exploratory data analysis, feature engineering, logistic regression, Linear Discriminant Analysis and Quadratic Discriminant Analysis to classify coupon acceptance.

The target variable is `Y`, where:

- `1` = Coupon accepted
- `0` = Coupon rejected

## Objective
The main objective of this project is to understand the key factors that influence coupon acceptance and build classification models to predict whether a user is likely to accept a coupon while driving.

Key questions explored in this project include:

- What percentage of users accept or reject coupons?
- Which coupon types are accepted more often?
- How do weather, destination, passenger type, time, education, and income influence coupon acceptance?
- Can machine learning models accurately predict coupon acceptance?
- Which features are most important in predicting coupon acceptance?

## Project Structure

```text
Predicting-In-Vehicle-Coupon-Acceptance/
│
├── data/
│   └── in-vehicle-coupon-recommendation.csv
│
├── R/
│   ├── 00_libraries.R
│   ├── 01_data_import_cleaning.R
│   ├── 02_eda_functions.R
│   ├── 03_feature_engineering.R
│   ├── 04_model_preparation.R
│   ├── 05_logistic_regression.R
│   ├── 06_lda_qda_models.R
│   └── 07_model_evaluation.R
│
├── main.R
└── README.md
```

```r
source("main.R")
```

## Modules

| File | Purpose |
|---|---|
| `main.R` | Runs the full project workflow |
| `00_libraries.R` | Loads required R packages |
| `01_data_import_cleaning.R` | Imports data, cleans columns, handles missing values, and removes duplicates |
| `02_eda_functions.R` | Contains reusable EDA and visualization functions |
| `03_feature_engineering.R` | Creates interaction features, age groups, income groups, and travel-time features |
| `04_model_preparation.R` | Performs one-hot encoding and train-test split |
| `05_logistic_regression.R` | Trains and evaluates Logistic Regression |
| `06_lda_qda_models.R` | Trains and evaluates LDA and QDA models |
| `07_model_evaluation.R` | Compares model accuracy and plots ROC curves |

## Author

Girish S Chandrappa
