# CIPHER Project - Draft Analysis Code
# Cardiovascular inequalities in English primary care

# Load libraries
library(tidyverse)
library(survival)
library(MASS)

# 1. Load data (placeholder)
# based on cohort definition (within OS environment)

#data <- read_csv("data/patient_data.csv")



# Expected variables (example):
# id, age, sex, ethnicity, deprivation_index, region
# bp_measured, cholesterol_test, health_check
# antihypertensive_rx, statin_rx
# bp_controlled, cholesterol_controlled
# year




# 2. Data preparation

data_clean <- data %>%
  filter(age >= 18) %>%
  mutate(
    deprivation_quintile = ntile(deprivation_index, 5),
    bp_detected = ifelse(bp_measured == 1, 1, 0),
    chol_detected = ifelse(cholesterol_test == 1, 1, 0)
  )




# 3. Descriptive summaries

# Detection rates by deprivation
detection_summary <- data_clean %>%
  group_by(deprivation_quintile) %>%
  summarise(
    bp_detection_rate = mean(bp_detected, na.rm = TRUE),
    chol_detection_rate = mean(chol_detected, na.rm = TRUE)
  )

print(detection_summary)

# Trends over time
trend_summary <- data_clean %>%
  group_by(year) %>%
  summarise(
    health_check_uptake = mean(health_check, na.rm = TRUE)
  )

# 4. Logistic regression
# Example: factors associated with NHS Health Check uptake
model_logistic <- glm(
  health_check ~ age + sex + ethnicity + deprivation_quintile,
  data = data_clean,
  family = binomial()
)

summary(model_logistic)


# 5. Count model (Poisson)
# Example: number of prescriptions (placeholder variable)
model_poisson <- glm(
  antihypertensive_rx ~ age + sex + deprivation_quintile,
  data = data_clean,
  family = poisson()
)

summary(model_poisson)



# 6. Simple inequality plot
ggplot(detection_summary, aes(x = deprivation_quintile, y = bp_detection_rate)) +
  geom_col() +
  labs(
    title = "Blood Pressure Detection by Deprivation",
    x = "Deprivation Quintile",
    y = "Detection Rate"
  )
