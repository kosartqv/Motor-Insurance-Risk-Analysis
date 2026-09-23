# Severity Modeling - Motor Insurance Risk Analysis


# ==============================
# 1. Prepare Severity Data
# ==============================

# Severity is modeled only for policies with positive claims

severity_data <- subset(
  data,
  ClaimNb > 0 & `total claim amount` > 0
)

# Average claim amount per claim

severity_data$Severity <-
  severity_data$`total claim amount` /
  severity_data$ClaimNb


# Convert categorical variables

severity_data$VehBrand <- as.factor(severity_data$VehBrand)
severity_data$VehGas   <- as.factor(severity_data$VehGas)
severity_data$Area     <- as.factor(severity_data$Area)
severity_data$Region   <- as.factor(severity_data$Region)



# ==============================
# 2. Train-Test Split
# ==============================

set.seed(123)

n <- nrow(severity_data)

train_index <- sample(
  1:n,
  size = 0.8 * n
)

severity_train <- severity_data[train_index, ]
severity_test  <- severity_data[-train_index, ]



# ==============================
# 3. Gamma GLM Model
# ==============================

gamma_model <- glm(
  Severity ~ VehPower + VehAge + DrivAge + BonusMalus +
    VehBrand + VehGas + Area + Density + Region,
  family = Gamma(link = "log"),
  data = severity_train
)

summary(gamma_model)


# Prediction

severity_test$gamma_pred <- predict(
  gamma_model,
  newdata = severity_test,
  type = "response"
)



# ==============================
# 4. Lognormal Model
# ==============================

# Model log(Severity) using linear regression

lognormal_model <- lm(
  log(Severity) ~ VehPower + VehAge + DrivAge + BonusMalus +
    VehBrand + VehGas + Area + Density + Region,
  data = severity_train
)

summary(lognormal_model)


# Transform predictions back to original scale

severity_test$lognormal_pred <- exp(
  predict(
    lognormal_model,
    newdata = severity_test
  )
)



# ==============================
# 5. Model Evaluation
# ==============================

# Mean Absolute Error

gamma_mae <- mean(
  abs(severity_test$Severity - severity_test$gamma_pred)
)

lognormal_mae <- mean(
  abs(severity_test$Severity - severity_test$lognormal_pred)
)


# Root Mean Squared Error

gamma_rmse <- sqrt(
  mean(
    (severity_test$Severity - severity_test$gamma_pred)^2
  )
)

lognormal_rmse <- sqrt(
  mean(
    (severity_test$Severity - severity_test$lognormal_pred)^2
  )
)


# Compare models

gamma_mae
lognormal_mae

gamma_rmse
lognormal_rmse


# Final model selected based on validation performance:
# Lognormal model
