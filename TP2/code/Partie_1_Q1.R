library(ggplot2) 
library(gridExtra)
library(dplyr)
library(caret)
library(MASS)
library(class)
library(e1071)
library(klaR)

# ======================
# Import des données
# ======================
data <- read.csv("Donnees_qualite_vin.csv",header=TRUE,sep=";",dec=".")
data$quality <- as.factor(data$quality)

# Résumé
summary(data)
