# ======================
# Split train / test
# ======================
set.seed(12345)
trainIndex <- createDataPartition(data[["quality"]], p = 0.8, list = FALSE)
training_data <- data[trainIndex, ]
testing_data <- data[-trainIndex, ]
ntest <- nrow(testing_data)

# Vérification de répartition dans les échantillons
table(training_data[["quality"]])
table(testing_data[["quality"]])
