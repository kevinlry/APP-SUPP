# ======================
# Test des modèles
# ======================
# Application sur le jeu de test
LDA_pred <- predict(LDA_model, testing_data)$class
QDA_pred <- predict(QDA_model, testing_data)$class
NaiveBayes_pred <- predict(nb_model, testing_data)
knn_pred <- knn(
  train = training_data[,names_features], # données d'apprentissage
  test = testing_data[,names_features], # données à prédire
  cl = training_data[["quality"]], # vraies valeurs
  k = k # nombre de voisins
)

# Calcul des erreurs
taux_err_LDA <- sum(LDA_pred != testing_data[["quality"]]) / ntest
taux_err_QDA <- sum(QDA_pred != testing_data[["quality"]]) / ntest
taux_err_NaiveBayes <- sum(NaiveBayes_pred != testing_data[["quality"]]) / ntest
taux_err_KNN <- sum(knn_pred != testing_data[["quality"]]) / ntest
taux_erreur <- data.frame(LDA=taux_err_LDA, QDA = taux_err_QDA, 
                          NaiveBayes = taux_err_NaiveBayes, KNN = taux_err_KNN)

print(taux_erreur)

mean(testing_data[["quality"]]==1)
