# tests/test_with_iris.R

# Cargar todas nuestras clases desde la carpeta R/
source_files <- list.files(path = "../R", pattern = "\\.R$", full.names = TRUE)
sapply(source_files, source)

# Cargar el dataset de iris
data(iris)

# --- INICIO DE LA PRUEBA ---

cat("--- Probando LdanDA_DescriptiveAnalyzer con el dataset iris ---\n")

# 1. Crear una instancia de la clase.
# Pasamos "Species" como la variable objetivo para probar el análisis bivariado.
analyzer <- LdanDA_DescriptiveAnalyzer$new(target_variable = "Species")

# 2. Ejecutar el pipeline de análisis
results <- analyzer$run_analysis_pipeline(df = iris)

# 3. Imprimir y verificar los resultados
cat("\nEstructura de los resultados:\n")
# Usamos str() para ver la estructura de la lista de resultados de forma compacta
str(results, max.level = 2)

cat("\nMatriz de Correlación:\n")
# Accedemos a una parte específica de los resultados
print(results$bivariate_analysis$correlation_matrix)

cat("\n--- Prueba completada exitosamente ---\n")

# analisis de todo (sin target_variable):
analyzer_all <- LdanDA_DescriptiveAnalyzer$new()
results_all <- analyzer_all$run_analysis_pipeline(df = iris)
cat("\nEstructura de los resultados sin variable objetivo:\n")
str(results_all, max.level = 2)
cat("\n--- Prueba completada exitosamente para análisis sin variable objetivo ---\n")
# Nota: En un entorno real, usaríamos un framework de testing como testthat
