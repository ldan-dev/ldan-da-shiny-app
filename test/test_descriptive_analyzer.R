# tests/test_descriptive_analyzer.R

# 1. Cargar las clases necesarias
source("../R/LdanDA_Analyzer.R")
source("../R/LdanDA_DescriptiveAnalyzer.R")

# 2. Crear datos de prueba
datos_de_prueba <- data.frame(
  a = 1:10,
  b = letters[1:10]
)

# 3. Probar la clase
# Crear una instancia del analizador
mi_analizador <- LdanDA_DescriptiveAnalyzer$new()

# Ejecutar el pipeline de análisis
resultados <- mi_analizador$run_analysis_pipeline(datos_de_prueba)

# 4. Imprimir y verificar los resultados
print("Resultados del análisis:")
print(resultados)

# Aquí podrías añadir verificaciones más formales
stopifnot(names(resultados) == "summary")