# renv::init()
# snapshot() -> renv::snapshot()
# install.packages("DT")
library(shiny)
library(DT) # Necesaria para las tablas interactivas

# Define la Interfaz de Usuario para la aplicación
fluidPage(
  
  # Título de la aplicación
  titlePanel("LDAN Data Analysis Tool"),
  
  # Diseño con un panel lateral y un panel principal
  sidebarLayout(
    
    
    # --- Panel Lateral con los Controles ---
    sidebarPanel(
      # --- LÍNEA NUEVA PARA EL LOGO ---
      # La imagen se carga desde la carpeta www
      img(src = "ldan_logo.png", height = "100px", width = "100px"),
      
      # --- El resto del panel lateral ---
      h4("1. Load Your Data"), # Un pequeño título
      # Botón para que el usuario suba su archivo
      fileInput("file_input", 
                "Choose a file (.csv, .tsv)",
                accept = c(".csv", ".tsv")),
    # # --- Panel Lateral con los Controles ---
    # sidebarPanel(
    #   h4("1. Load Your Data"), # Un pequeño título
    #   # Botón para que el usuario suba su archivo
    #   fileInput("file_input", 
    #             "Choose a file (.csv, .tsv)",
    #             accept = c(".csv", ".tsv")),
      
      hr(), # Una línea horizontal para separar
      
      h4("2. Choose an Analysis"),
      # Menú para seleccionar el tipo de análisis
      selectInput("analysis_type", 
                  "Type of analysis:",
                  choices = c("Descriptive Analysis", 
                              "Regression Analysis", 
                              "Inference & Hypothesis Testing")),
      
      hr(), # Otra línea separadora
      
      # Opciones que aparecerán solo si se elige "Regression Analysis"
      conditionalPanel(
        condition = "input.analysis_type == 'Regression Analysis'",
        h5("Regression Settings"),
        # Aquí pondremos menús para elegir las variables más adelante
      ),
      
      hr(),
      
      # Botón principal para ejecutar el análisis
      actionButton("run_button", "Run Analysis", icon = icon("play"))
      
    ),
    
    # --- Panel Principal con los Resultados ---
    mainPanel(
      # Sistema de pestañas para organizar la salida
      tabsetPanel(
        id = "main_tabs",
        tabPanel("Welcome", h3("Welcome to the Data Analysis Tool!"), p("Upload a file and select an analysis to get started.")),
        tabPanel("Data Preview", DT::dataTableOutput("data_table")),
        tabPanel("Analysis Results", verbatimTextOutput("results_summary")),
        tabPanel("Plots", plotOutput("results_plot")),
        tabPanel("Interpretation", uiOutput("results_interpretation")),
        tabPanel("R Code", verbatimTextOutput("results_code"))
      )
    )
  )
)