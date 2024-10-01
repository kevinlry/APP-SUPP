# ======================
# Analyse exploratoire
# ======================
# Visualisations
plot_list <- list()
for (col in names(data)) {
  if (is.numeric(data[[col]])) {
    p <- ggplot(data, aes(x = .data[[col]])) +
      geom_histogram(fill = "blue", color = "black") +
      labs(title = col, x = col, y = "Frequency")
  } else {
    p <- ggplot(data, aes(x = .data[[col]])) +
      geom_bar(fill = "blue", color = "black") +
      labs(title = col, x = col, y = "Frequency")
  }
  plot_list[[col]] <- p
}
grid_plots <- do.call(grid.arrange, plot_list)

# Verification du déséquilibre des classes
table(data[["quality"]])

# Influence potentielle des variables
names_features <- names(subset(data, select=-quality))
plot_list_importance <- list()
for (feature in names_features) {
  # On enlève les outliers potentiels pour la visualisation
  boxplot_data <- boxplot.stats(data[[feature]])
  lower_whisker <- boxplot_data$stats[1]
  upper_whisker <- boxplot_data$stats[length(boxplot_data$stats)]
  data_no_outliers <- data %>%
    filter(data[[feature]] >= lower_whisker & data[[feature]] <= upper_whisker)
  
  p <- ggplot(data_no_outliers, aes(x = .data[[feature]], y = .data[["quality"]], fill=.data[["quality"]])) +
    geom_boxplot(color = "black") +
    labs(title = "", x = feature, y = "")
  
  plot_list_importance[[feature]] <- p
}
grid_plots_importance <- do.call(grid.arrange, plot_list_importance)

plot_list_importance <- list()
for (feature in names_features) {
  # On enlève les outliers potentiels pour la visualisation
  boxplot_data <- boxplot.stats(data[[feature]])
  lower_whisker <- boxplot_data$stats[1]
  upper_whisker <- boxplot_data$stats[length(boxplot_data$stats)]
  data_no_outliers <- data %>%
    filter(data[[feature]] >= lower_whisker & data[[feature]] <= upper_whisker)
  
  p <- ggplot(data_no_outliers, aes(x = .data[[feature]], y = .data[["quality"]], fill=.data[["quality"]])) +
    geom_violin(color = "black") +
    geom_boxplot(width=0.1) +
    labs(title = "", x = feature, y = "")
  
  plot_list_importance[[feature]] <- p
}
grid_plots_importance <- do.call(grid.arrange, plot_list_importance)

# Parmi les influences potentiellement les plus fortes, on a :
# ------------------------------------------------------------
# - volatile.acidity
# - citric.acidity
# - sulphates
# - alcohol