# Expected Loss Calculation
# Motor Insurance Risk Analysis


# ==============================
# Predict Severity for all policies
# ==============================

# Severity model was trained only on policies with claims.
# Here it is applied to the whole portfolio.

data$predicted_severity <- exp(
  predict(
    lognormal_model,
    newdata = data
  )
)



# ==============================
# Expected Loss Calculation
# ==============================

# Expected Loss = Predicted Frequency × Predicted Severity

data$expected_loss <-
  data$predicted_claims *
  data$predicted_severity



# Preview results

head(
  data[, c(
    "IDpol",
    "predicted_claims",
    "predicted_severity",
    "expected_loss"
  )]
)
