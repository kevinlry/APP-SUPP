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

# Analyse discriminante 
LDA_model <- lda(quality ~ ., data = training_data)
QDA_model <- qda(quality ~ ., data = training_data)

# KNN
knn_cross_results <- tune.knn(
  x = training_data[,names_features], # predicteurs
  y = training_data[["quality"]], # réponse
  k = 1:50, # essayer knn avec K variant de 1 à 50
  tunecontrol = tune.control(sampling = "cross"), # utilisation de la cross validation
  cross = 5 # 5 blocs
)

# Choix de k
ggplot(
  data = knn_cross_results$performances,
  mapping = aes(x = k, y = error)
) + 
  geom_line() +
  geom_point() + 
  labs(
    x = "k",
    y = "Erreur de validation",
    title = "Evolution de l'erreur selon k"
  )

ggplot(
  data = knn_cross_results$performances,
  mapping = aes(x = k, y = error)
) + 
  geom_line() +
  geom_point() + 
  geom_errorbar(
    aes(ymin = error - dispersion, ymax = error + dispersion),
    width = 0.2,  # Adjust the width of the error bars as needed
    position = position_dodge(width = 0.2)  # Adjust the dodge width as needed
  ) +
  labs(
    x = "k",
    y = "Erreur de validation",
    title = "Evolution de l'erreur selon k"
  )

k <- 22
