# =============================================================================
# Sesión 1 · Bloque 1 (45 min)
# Entorno de trabajo: RStudio, proyectos (.Rproj) e importación de datos
# =============================================================================
#
# OBJETIVO DE ESTE BLOQUE
# Familiarizarse con RStudio como entorno de trabajo y aprender a importar
# datos propios (CSV/Excel) dentro de un proyecto reproducible.
#
# ANTES DE EMPEZAR (ya debería estar hecho, ver guía de instalación en el
# README principal del repositorio):
#   install.packages(c("tidyverse", "sf", "terra", "rmarkdown", "kableExtra"))

# -----------------------------------------------------------------------------
# 1. ¿Por qué trabajar con un proyecto de RStudio (.Rproj)?
# -----------------------------------------------------------------------------
# Un proyecto fija la carpeta de trabajo (working directory) automáticamente.
# Esto evita el problema más común de quien empieza en R: rutas que funcionan
# en la computadora de una persona y no en la de otra.
#
# Si estás abriendo este script desde el archivo curso-r-lab-geografia.Rproj,
# la carpeta de trabajo ya es la raíz del repositorio. Verificalo con:
getwd()

# Deberías ver algo terminado en ".../curso-r-lab-geografia"
# Si no es así: Session > Set Working Directory > To Project Directory

# -----------------------------------------------------------------------------
# 2. Cargar paquetes
# -----------------------------------------------------------------------------
# En este bloque solo necesitamos lectura de datos. dplyr se usa apenas para
# dar un primer vistazo con glimpse().
library(dplyr)

# -----------------------------------------------------------------------------
# 3. Importar datos propios
# -----------------------------------------------------------------------------
# El dataset de ejemplo de este curso: registros mensuales de temperatura y
# precipitación (2020-2024) para 6 localidades de la provincia de Santa Fe.
# Es un dataset SINTÉTICO con fines pedagógicos (ver data/00_generar_dataset.R
# para el detalle y la advertencia correspondiente).

datos <- read.csv("data/datos_climaticos_santafe.csv")

# Cuando en la próxima cursada reemplacen esto por datos propios del
# laboratorio, la lógica es la misma. Para Excel, en lugar de read.csv:
#   library(readxl)
#   datos <- read_excel("data/mi_archivo.xlsx", sheet = "Hoja1")

# -----------------------------------------------------------------------------
# 4. Primer vistazo a los datos
# -----------------------------------------------------------------------------
# ¿Cuántas filas y columnas tiene? ¿Qué tipo de dato es cada columna?
glimpse(datos)

# Las primeras y últimas filas
head(datos)
tail(datos)

# Estructura general (alternativa base R a glimpse)
str(datos)

# ¿Cuántas localidades (sitios) hay, y cuántas observaciones por sitio?
table(datos$sitio)

# -----------------------------------------------------------------------------
# 5. Preguntas para pensar en grupo (2-3 min)
# -----------------------------------------------------------------------------
# - ¿Qué columna es la variable temporal? ¿Está en un formato que R reconozca
#   como fecha, o es texto?
# - ¿Qué columna(s) usarían para AGRUPAR observaciones (por sitio, por año)?
# - ¿Qué columna(s) son las variables numéricas de interés ambiental?
#
# Estas tres preguntas son la base de todo lo que viene en los próximos
# bloques: agrupar (dplyr), resumir (estadística) y graficar (ggplot2).

# -----------------------------------------------------------------------------
# 6. Ejercicio con datos propios
# -----------------------------------------------------------------------------
# Si ya tenés un archivo CSV/Excel propio, probá importarlo ahora en un
# objeto nuevo (ej. `mis_datos <- read.csv("data/mi_archivo.csv")`) y
# corré glimpse() y table() sobre él. Guardalo en tu carpeta `data/` para
# poder seguir usándolo en los próximos bloques.
