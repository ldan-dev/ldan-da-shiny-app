# Introducción a la biblioteca Shiny

Shiny es una biblioteca de R que permite crear aplicaciones web interactivas de manera sencilla. Con Shiny, puedes transformar análisis de datos en aplicaciones web que pueden ser compartidas con otros.

## ¿Cómo funcionan las aplicaciones Shiny?

Las aplicaciones Shiny funcionan en un modelo de cliente-servidor. Cuando un usuario interactúa con la interfaz de usuario (UI), Shiny envía solicitudes al servidor, que ejecuta el código R necesario y devuelve los resultados a la UI. Este flujo permite una experiencia interactiva y dinámica.

## Componentes de Shiny

### 1. Interfaz de Usuario (UI)

La interfaz de usuario es la parte de la aplicación que los usuarios ven y con la que interactúan. Se puede construir usando funciones como `fluidPage()`, `sidebarLayout()`, `mainPanel()`, entre otras. La UI define cómo se presentan los elementos (como gráficos, tablas y controles) al usuario.

Ejemplo de un componente UI básico:

```r
library(shiny)

ui <- fluidPage(
    titlePanel("Ejemplo de Aplicación Shiny"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("num", "Número:", 1, 100, 50)
        ),
        mainPanel(
            textOutput("result")
        )
    )
)
```

### 2. Servidor

El servidor es donde ocurre la lógica de la aplicación. Aquí es donde se procesan los datos, se generan resultados y se envían de vuelta a la UI. Las funciones del servidor responden a las interacciones del usuario y actualizan la UI en consecuencia.

Ejemplo de una función de servidor simple:

```r
server <- function(input, output) {
    output$result <- renderText({
        paste("El número elegido es:", input$num)
    })
}
```

## Ejecución de la Aplicación

Para ejecutar una aplicación Shiny, se utiliza la función `shinyApp()` que toma la UI y el servidor como argumentos:

```r
shinyApp(ui = ui, server = server)
```

## Conclusión

La biblioteca Shiny facilita la creación de aplicaciones web interactivas en R, permitiendo a los usuarios explorar datos de manera dinámica. Con un entendimiento básico de los componentes de UI y servidor, puedes comenzar a desarrollar tus propias aplicaciones Shiny.
