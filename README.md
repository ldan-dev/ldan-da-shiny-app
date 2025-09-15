# LDAN-DA: Herramienta de Análisis de Datos Interactivo

[![Shiny App](https://img.shields.io/badge/shiny-app-blue.svg)](https://github.com/ldan-dev/ldan-da-shiny-app)

Una aplicación web interactiva desarrollada en **R** con el framework **Shiny** para el análisis de datos exploratorio. El proyecto demuestra la implementación de principios de **Programación Orientada a Objetos (POO)** con R6 y el uso del patrón de diseño "Template Method".



## 📝 Descripción

Esta herramienta permite a los usuarios cargar su propio conjunto de datos en formato CSV. Una vez cargado, la aplicación ofrece dos funcionalidades principales:

1.  **Análisis Descriptivo:** Ejecuta un análisis estadístico completo que resume las características principales del dataset.
2.  **Visualización Dinámica:** Ofrece una pestaña interactiva donde se pueden generar y personalizar una gran variedad de gráficos para explorar las variables de forma intuitiva, con sugerencias inteligentes sobre el tipo de gráfico más adecuado.

## ✨ Características Principales

* **Carga de Datos:** Soporte para archivos `.csv`.
* **Análisis Descriptivo Automatizado:** Resumen global, análisis univariado y bivariado.
* **Visualización Dinámica:** Generación de gráficos al instante seleccionando variables de menús desplegables.
* **Sugerencia Inteligente de Gráficos:** La app recomienda el mejor tipo de gráfico basado en el tipo de dato (continuo, categórico, binario).
* **Personalización de Gráficos:** Permite modificar títulos y etiquetas de los ejes en tiempo real.
* **Backend Orientado a Objetos:** La lógica del análisis está encapsulada en clases de R6, promoviendo un código limpio y modular.
* **Entorno Reproducible:** Utiliza el paquete `renv` para gestionar las dependencias y garantizar que la aplicación funcione en cualquier máquina.

## 🛠️ Tecnologías Utilizadas

* **Lenguaje:** R
* **Framework Web:** Shiny
* **POO:** Paquete R6
* **Visualización:** ggplot2, corrplot
* **Manipulación de Datos:** dplyr
* **Gestión de Entorno:** renv

## 🚀 Instalación y Uso

Para ejecutar esta aplicación en tu máquina local, sigue estos pasos:

1.  **Clona el repositorio:**
    ```bash
    git clone https://github.com/ldan-dev/ldan-da-shiny-app.git
    ```
2.  **Abre el proyecto en RStudio.**
3.  **Restaura el entorno:** `renv` debería activarse automáticamente. Ejecuta el siguiente comando en la consola de R para instalar todos los paquetes necesarios con sus versiones exactas:
    ```R
    renv::restore()
    ```
4.  **Ejecuta la aplicación:** Haz clic en el botón "Run App" en RStudio.

## 📁 Estructura del Proyecto

````
/
├── R/
│   ├── LdanDA_Analyzer.R             # Clase Padre
│   └── LdanDA_DescriptiveAnalyzer.R  # Clase Hija
├── www/
│   └── ldan_logo.png                 # Recursos estáticos
├── tests/
│   └── test_with_iris.R              # Scripts para pruebas
├── ui.R                              # Lógica de la Interfaz de Usuario
├── server.R                          # Lógica del Servidor
├── renv.lock                         # Archivo de dependencias
└── .Rprofile                         # Activa el entorno renv
````
## 👨‍💻 Autor

* **Leonardo Daniel Aviña Neri** - [ld.avinaneri@ugto.mx](mailto:ld.avinaneri@ugto.mx)
