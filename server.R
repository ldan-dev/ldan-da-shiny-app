# server.R
library(shiny)
library(DT) # Necesaria para renderizar las tablas

# Define la lógica del servidor
function(input, output, session) {
  
  # --- 1. Lógica Reactiva para Cargar Datos ---
  # Esta sección se encarga de leer el archivo cuando el usuario lo sube.
  # Usamos una expresión "reactive" para que el código solo se ejecute
  # cuando input$file_input cambie (es decir, cuando se suba un nuevo archivo).
  
  datos <- reactive({
    # "req(input$file_input)" asegura que no se ejecute nada
    # hasta que el usuario haya subido un archivo. Evita errores.
    req(input$file_input)
    
    # Leemos el archivo CSV. Shiny nos da una ruta temporal al archivo
    # a través de "input$file_input$datapath".
    read.csv(input$file_input$datapath)
  })
  
  # --- 2. Renderizado de la Tabla de Datos ---
  # Esta sección se encarga de mostrar el dataframe en la UI.
  # El nombre "output$data_table" debe coincidir exactamente con el
  # id que le dimos en el ui.R (DT::dataTableOutput("data_table")).
  
  output$data_table <- DT::renderDataTable({
    # Para acceder al valor de una expresión reactiva (como "datos"),
    # debemos llamarla como si fuera una función, con paréntesis: datos().
    datos()
  })
  
}