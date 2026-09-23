# Risk Factor Analysis
# Motor Insurance Risk Analysis


# =====================================
# 1. Frequency Risk Factor Importance
# =====================================

# Likelihood Ratio Test:
# Measures the contribution of each variable to claim frequency

freq_importance <- drop1(
  poisson_model,
  test = "Chisq"
)

freq_importance



# =====================================
# 2. Severity Risk Factor Importance
# =====================================

# F-test:
# Measures the contribution of each variable to claim severity

sev_importance <- drop1(
  lognormal_model,
  test = "F"
)

sev_importance



# =====================================
# 3. Expected Loss Analysis
# =====================================

# Average expected loss by risk factor levels


# Vehicle age
aggregate(
  expected_loss ~ VehAge,
  data = data,
  FUN = mean
)


# Driver age
aggregate(
  expected_loss ~ DrivAge,
  data = data,
  FUN = mean
)


# Bonus-Malus
aggregate(
  expected_loss ~ BonusMalus,
  data = data,
  FUN = mean
)


# Vehicle brand
aggregate(
  expected_loss ~ VehBrand,
  data = data,
  FUN = mean
)


# Fuel type
aggregate(
  expected_loss ~ VehGas,
  data = data,
  FUN = mean
)


# Area
aggregate(
  expected_loss ~ Area,
  data = data,
  FUN = mean
)


# Region
aggregate(
  expected_loss ~ Region,
  data = data,
  FUN = mean
)
