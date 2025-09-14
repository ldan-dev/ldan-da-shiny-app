# LdanDA_Analyzer
# LEONARDO DANIEL AVIÑA NERI
# Date: 14/09/2025 (DD/MM/YYYY)
# MAJOR: LIDIA
# Universidad de Guanajuato - Campus Irapuato-Salamanca
# E-mail: ld.avinaneri@ugto.mx
# UDA: Object Oriented Programming 1

# DESCRIPTION:
# CLASE HIJA 1: LdanDA_DescriptiveAnalyzer
# Especializada en análisis descriptivo.

# notas:
# 'super' para acceder a campos de la clase padre

# Cargar paquetes necesarios para el análisis
library(R6)
library(dplyr)
library(moments)
# install.packages("moments") # Si no está instalado

LdanDA_DescriptiveAnalyzer <- R6Class("LdanDA_DescriptiveAnalyzer",
  inherit = LdanDA_Analyzer, # hereda de LdanDA_Analyzer
  
  public = list(
    # --- Constructor ---
    # Permite inicializar el analizador con parámetros específicos.
    initialize = function(target_variable = NULL, exclude_cols = NULL) {
      private$.target_variable <- target_variable
      private$.exclude_cols <- exclude_cols
    }
  ),
  
  private = list(
    # Campos privados específicos para esta clase
    .target_variable = NULL,
    .exclude_cols = NULL,
    
    # --- ANÁLISIS CENTRAL ---
    .perform_core_analysis = function() {
      # Acceder a los datos desde la clase padre
      df <- super$.__enclos_env__$private$.data
      
      # 0. Validaciones y preparación
      # cambia esto para usar el metodo de la clase padre ".validate_data"
      if (!is.data.frame(df)) {
        stop("El objeto de datos debe ser un data.frame.")
      }
      
      # Excluir columnas si se especifica
      if (!is.null(private$.exclude_cols)) {
        df <- df[, !(names(df) %in% private$.exclude_cols)]
      }
      
      # Identificar tipos de columnas
      numeric_cols <- names(df)[sapply(df, is.numeric)]
      categorical_cols <- names(df)[sapply(df, function(x) is.factor(x) || is.character(x))]
      
      # Crear la lista de resultados
      analysis_results <- list()
      
      # --- 1. RESUMEN GLOBAL ---
      analysis_results$global_summary <- list(
        dimensions = dim(df),
        n_rows = nrow(df),
        n_cols = ncol(df),
        memory_usage = object.size(df),
        variable_types = table(sapply(df, class)),
        total_nas = sum(is.na(df)),
        nas_per_column = colSums(is.na(df)),
        duplicated_rows = sum(duplicated(df))
      )
      
      # --- 2. ANÁLISIS UNIVARIADO ---
      
      # Análisis numérico
      numeric_summary <- lapply(df[numeric_cols], function(col) {
        if(sum(!is.na(col)) == 0) return(NULL) # Si toda la columna es NA
        list(
          mean = mean(col, na.rm = TRUE),
          median = median(col, na.rm = TRUE),
          sd = sd(col, na.rm = TRUE),
          min = min(col, na.rm = TRUE),
          max = max(col, na.rm = TRUE),
          quantiles = quantile(col, na.rm = TRUE),
          skewness = moments::skewness(col, na.rm = TRUE),
          kurtosis = moments::kurtosis(col, na.rm = TRUE),
          n_unique = length(unique(col)),
          n_zeros = sum(col == 0, na.rm = TRUE)
        )
      })
      
      # Análisis categórico
      categorical_summary <- lapply(df[categorical_cols], function(col) {
        if(sum(!is.na(col)) == 0) return(NULL)
        freq_table <- as.data.frame(sort(table(col), decreasing = TRUE))
        names(freq_table) <- c("Category", "Frequency")
        freq_table$Percentage <- freq_table$Frequency / sum(freq_table$Frequency)
        
        list(
          cardinality = length(unique(col)),
          mode = freq_table$Category[1],
          frequency_table = freq_table
        )
      })
      
      analysis_results$univariate_analysis <- list(
        numeric = numeric_summary,
        categorical = categorical_summary
      )
      
      # --- 3. ANÁLISIS BIVARIADO ---
      
      # Matriz de Correlación (solo si hay al menos 2 columnas numéricas)
      correlation_matrix <- NULL
      if(length(numeric_cols) >= 2) {
        correlation_matrix <- cor(df[numeric_cols], use = "pairwise.complete.obs")
      }
      
      # Estadísticas agrupadas si se define target_variable
      grouped_stats <- NULL
      if (!is.null(private$.target_variable) && private$.target_variable %in% categorical_cols) {
        grouped_stats <- df %>%
          dplyr::group_by(!!dplyr::sym(private$.target_variable)) %>%
          dplyr::summarise(across(all_of(numeric_cols), list(mean = mean, sd = sd), .names = "{.col}_{.fn}"))
      }
      
      analysis_results$bivariate_analysis <- list(
        correlation_matrix = correlation_matrix,
        grouped_by_target = grouped_stats
      )
      
      # Guardar el resultado final en el campo privado de la clase padre
      super$.__enclos_env__$private$.results <- analysis_results
    },
    
    # --- Implementación del paso de reporte ---
    .generate_report = function() {
      # Por ahora, el reporte es simplemente el resultado mismo.
      # Más adelante, aquí podríamos formatear el texto.
      invisible(self) # No devuelve nada visible, buena práctica
    }
  )
)