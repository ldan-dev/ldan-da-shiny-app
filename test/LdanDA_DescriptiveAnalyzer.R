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


LdanDA_DescriptiveAnalyzer <- R6Class("LdanDA_DescriptiveAnalyzer",
  inherit = LdanDA_Analyzer, # hereda de LdanDA_Analyzer
  
  private = list(
    
    # analisis central:
    .perform_core_analysis = function() {
      df <- super$.__enclos_env__$private$.data
      
      # Calculamos un resumen básico y lo guardamos
      summary_stats <- summary(df)
      
      # Guardamos el resultado en el campo privado de la clase padre
      super$.__enclos_env__$private$.results <- list(
        summary = summary_stats
      )
    },
    
    # --- Implementación del paso de reporte ---
    .generate_report = function() {
      # Por ahora, el reporte es simplemente el resultado mismo.
      # Más adelante, aquí podríamos formatear el texto.
      invisible(self) # No devuelve nada visible, buena práctica
    }
  )
)