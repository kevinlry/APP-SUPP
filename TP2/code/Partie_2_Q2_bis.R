# ======================
# Train des modèles
# ======================
ctrl <- trainControl(
  method = "cv",                   # Cross-validation method
  number = 10                      # Number of folds (adjust as needed)
)

# Bayesien naif
hyperparameters <- expand.grid(
  usekernel = c(TRUE, FALSE),
  fL = seq(0.6, 1, by = 0.2),
  adjust = seq(0.5, 2, by = 0.5)
)

nb_model <- train(
  quality ~ .,            
  data = training_data,
  method = "nb",
  trControl = ctrl,
  tuneGrid = hyperparameters
)