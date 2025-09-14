# server.R
library(shiny)
library(DT)
library(corrplot) # Para el gráfico de matriz de correlación

# Carga automáticamente todos los archivos .R de la carpeta R/
source_files <- list.files(path = "R", pattern = "\\.R$", full.names = TRUE)
sapply(source_files, source)

# Define la lógica del servidor
function(input, output, session) {
  
  # --- 1. Almacenamiento Reactivo ---
  # 'datos' guarda el dataframe cargado.
  datos <- reactive({
    req(input$file_input)
    read.csv(input$file_input$datapath)
  })
  
  # 'rv' (reactive values) guarda los resultados del análisis.
  # Usamos esto para que los resultados persistan después de que el análisis se ejecute.
  rv <- reactiveValues(results = NULL)
  
  # --- 2. Renderizado de la Tabla de Datos ---
  output$data_table <- DT::renderDataTable({
    datos()
  })
  
  # --- 3. Lógica del Botón "Run Analysis" ---
  # observeEvent escucha cuando el botón 'run_button' es presionado.
  observeEvent(input$run_button, {
    
    # Mostrar una notificación al usuario de que el análisis ha comenzado
    showNotification("Running analysis...", type = "message")
    
    # Seleccionar y ejecutar el análisis basado en la elección del usuario
    if (input$analysis_type == "Descriptive Analysis") {
      
      # a. Crear una instancia del analizador
      analyzer <- LdanDA_DescriptiveAnalyzer$new()
      
      # b. Ejecutar el pipeline pasándole los datos cargados
      analysis_results <- analyzer$run_analysis_pipeline(df = datos())
      
      # c. Guardar los resultados en nuestro reactiveValues
      rv$results <- analysis_results
      
      showNotification("Analysis complete!", type = "default")
    }
    # (Aquí podrías añadir 'else if' para otros tipos de análisis en el futuro)
    
  })
  
  # --- 4. Renderizado de los Resultados del Análisis ---
  
  # Muestra los resúmenes en la pestaña "Analysis Results"
  output$results_summary <- renderPrint({
    # req() asegura que no se muestre nada hasta que haya resultados
    req(rv$results)
    
    cat("### Global Summary ###\n")
    print(rv$results$global_summary)
    
    cat("\n\n### Univariate Analysis (Numeric) ###\n")
    print(rv$results$univariate_analysis$numeric)
    
    cat("\n\n### Univariate Analysis (Categorical) ###\n")
    # Imprimir tablas de frecuencia para variables categóricas
    lapply(names(rv$results$univariate_analysis$categorical), function(x) {
      cat(paste("\n---", x, "---\n"))
      print(rv$results$univariate_analysis$categorical[[x]]$frequency_table)
    })
  })
  
  # Muestra los gráficos en la pestaña "Plots"
  output$results_plot <- renderPlot({
    req(rv$results)
    
    # Si hay una matriz de correlación en los resultados, la graficamos
    if (!is.null(rv$results$bivariate_analysis$correlation_matrix)) {
      corrplot(rv$results$bivariate_analysis$correlation_matrix, method = "circle")
    }
  })
  
}