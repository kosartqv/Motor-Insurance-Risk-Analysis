# Model Validation - Motor Insurance Risk Analysis


# ==============================
# Frequency Model Validation
# ==============================

frequency_metrics <- data.frame(
  Metric = c(
    "MAE",
    "RMSE",
    "Mean Poisson Deviance"
  ),
  Value = c(
    mae,
    rmse,
    mean_poisson_deviance
  )
)

frequency_metrics



# ==============================
# Severity Model Validation
# ==============================

severity_metrics <- data.frame(
  Model = c(
    "Gamma GLM",
    "Lognormal"
  ),
  MAE = c(
    gamma_mae,
    lognormal_mae
  ),
  RMSE = c(
    gamma_rmse,
    lognormal_rmse
  )
)

severity_metrics
