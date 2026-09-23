# Frequency Modeling - Poisson GLM
# Motor Insurance Risk Analysis


# ==============================
# 1. Load packages and data
# ==============================

library(readxl)

# Import prepared insurance dataset
# Update the path according to your local directory
data <- read_excel(
  "data/insurance_data.xlsx",
  sheet = "attached data"
)

# Remove empty rows
data <- data[!is.na(data$IDpol), ]


# ==============================
# 2. Data preparation
# ==============================

# Convert categorical variables into factors

data$VehBrand <- as.factor(data$VehBrand)
data$VehGas   <- as.factor(data$VehGas)
data$Area     <- as.factor(data$Area)
data$Region   <- as.factor(data$Region)


# ==============================
# 3. Poisson Frequency Model
# ==============================

# Claim frequency is modeled using Poisson GLM.
# Exposure is included as an offset because policies have different exposure periods.

poisson_model <- glm(
  ClaimNb ~ VehPower + VehAge + DrivAge + BonusMalus +
    VehBrand + VehGas + Area + Density +
    Region + offset(log(Exposure)),
  family = poisson(link = "log"),
  data = data
)

summary(poisson_model)


# ==============================
# 4. Frequency prediction
# ==============================

# Predicted claim frequency for each policy

data$predicted_claims <- predict(
  poisson_model,
  type = "response"
)


# ==============================
# 5. Model assumptions check
# ==============================

# Compare mean and variance of claim counts

mean(data$ClaimNb)
var(data$ClaimNb)

# Dispersion check
deviance(poisson_model) / df.residual(poisson_model)


# ==============================
# 6. Train-Test Validation
# ==============================

set.seed(123)

n <- nrow(data)

train_index <- sample(
  1:n,
  size = 0.8 * n
)

train_data <- data[train_index, ]
test_data  <- data[-train_index, ]


# Train model on training data

poisson_train <- glm(
  ClaimNb ~ VehPower + VehAge + DrivAge + BonusMalus +
    VehBrand + VehGas + Area + Density +
    Region + offset(log(Exposure)),
  family = poisson(link = "log"),
  data = train_data
)


# Prediction on unseen test data

test_data$predicted_claims <- predict(
  poisson_train,
  newdata = test_data,
  type = "response"
)


# ==============================
# 7. Performance metrics
# ==============================

# Mean Absolute Error

mae <- mean(
  abs(test_data$ClaimNb - test_data$predicted_claims)
)

mae


# Root Mean Squared Error

rmse <- sqrt(
  mean(
    (test_data$ClaimNb - test_data$predicted_claims)^2
  )
)

rmse


# Mean Poisson Deviance

y <- test_data$ClaimNb
mu <- test_data$predicted_claims

poisson_deviance <- 2 * sum(
  ifelse(
    y == 0,
    mu,
    y * log(y / mu) - (y - mu)
  )
)

mean_poisson_deviance <- poisson_deviance / nrow(test_data)

mean_poisson_deviance
