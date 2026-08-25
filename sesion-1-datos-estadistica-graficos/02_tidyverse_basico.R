# =============================================================================
# CURSO DE R — LABORATORIO DE GEOGRAFÍA FÍSICA Y AMBIENTAL (FHUC-UNL)
# Introducción a R para el Análisis Estadístico, Gráfico y Espacial
# -----------------------------------------------------------------------------
# Adrián Contursi Reynoso | acontursi@fhuc.unl.edu.ar
# Facultad de Humanidades y Ciencias - Universidad Nacional del Litoral
# Repositorio: https://github.com/acontursi/curso-r-lab-geo
# Actualizado: 2026-08-24
# Licencia:    CC BY-NC-SA 4.0 — se permite compartir y adaptar citando la
#              fuente, sin fines comerciales
# =============================================================================

# =============================================================================
# Sesión 1: Bloque 2 (45 min)
# Tidyverse esencial: dplyr (filter, mutate, group_by, summarize) y el pipe
# =============================================================================
#
# OBJETIVO DE ESTE BLOQUE
# Aprender las cuatro operaciones de dplyr que van a usar en el 90% de sus
# tareas de limpieza y transformación de datos, encadenadas con el pipe.
#
# Punto de partida: seguimos desde donde quedamos en 01_entorno_y_proyecto.R

library(dplyr)

datos <- read.csv("data/datos_climaticos_santafe.csv")

# -----------------------------------------------------------------------------
# 1. El operador pipe: |>
# -----------------------------------------------------------------------------
# `datos |> funcion()` es equivalente a `funcion(datos)`. Sirve para encadenar
# pasos y leerlos de arriba hacia abajo, como una receta.
#
# Sin pipe:
head(datos)
# Con pipe (mismo resultado, pero así se van a encadenar los próximos pasos):
datos |> head()

# -----------------------------------------------------------------------------
# 2. filter(): quedarse con ciertas filas
# -----------------------------------------------------------------------------
# ¿Qué registros corresponden solo a Santa Fe capital?
datos |> filter(sitio == "Santa Fe")

# ¿Y los meses de verano (diciembre, enero, febrero) en cualquier sitio?
datos |> filter(mes %in% c(12, 1, 2))

# Se pueden combinar condiciones con & (y) y | (o)
datos |> filter(sitio == "Rosario" & anio == 2023)

# -----------------------------------------------------------------------------
# 3. mutate(): crear o modificar columnas
# -----------------------------------------------------------------------------
# Ejemplo: convertir temperatura de Celsius a Fahrenheit, y clasificar si el
# mes fue "húmedo" o "seco" según un umbral arbitrario de precipitación.
datos <- datos |>
  mutate(
    temperatura_f = temperatura_media_c * 9 / 5 + 32,
    condicion_humedad = if_else(precipitacion_mm >= 60, "húmedo", "seco")
  )

head(datos)

# -----------------------------------------------------------------------------
# 4. group_by() + summarize(): resumir por grupo
# -----------------------------------------------------------------------------
# Esta es probablemente la combinación más usada en todo el curso: agrupar
# por una variable categórica (sitio, año) y calcular un resumen numérico.

# Temperatura y precipitación PROMEDIO por sitio
resumen_por_sitio <- datos |>
  group_by(sitio) |>
  summarize(
    temp_promedio = mean(temperatura_media_c),
    precip_promedio = mean(precipitacion_mm),
    precip_total = sum(precipitacion_mm),
    n_meses = n()
  )

resumen_por_sitio

# Lo mismo pero por año, para ver si hay tendencia
resumen_por_anio <- datos |>
  group_by(anio) |>
  summarize(
    temp_promedio = mean(temperatura_media_c),
    precip_total = sum(precipitacion_mm)
  )

resumen_por_anio

# Se puede agrupar por más de una variable a la vez
resumen_sitio_anio <- datos |>
  group_by(sitio, anio) |>
  summarize(
    temp_promedio = round(mean(temperatura_media_c), 1),
    precip_total = round(sum(precipitacion_mm), 1),
    .groups = "drop"  # buena práctica: evita que quede agrupado sin querer
  )

resumen_sitio_anio

# -----------------------------------------------------------------------------
# 5. Encadenando todo: un pipeline completo
# -----------------------------------------------------------------------------
# ¿Cuál fue el sitio con mayor precipitación acumulada en 2024?
datos |>
  filter(anio == 2024) |>
  group_by(sitio) |>
  summarize(precip_total = sum(precipitacion_mm)) |>
  arrange(desc(precip_total))

# arrange() ordena filas; desc() invierte el orden (de mayor a menor)

# -----------------------------------------------------------------------------
# 6. Guardar el resumen para usarlo más adelante
# -----------------------------------------------------------------------------
# En la Sesión 2 vamos a insertar una tabla como esta en el paper con kable().
write.csv(resumen_por_sitio, "sesion-1-datos-estadistica-graficos/resumen_por_sitio.csv",
          row.names = FALSE)

# -----------------------------------------------------------------------------
# 7. Ejercicio con datos propios
# -----------------------------------------------------------------------------
# Sobre tu propio dataset (si ya lo importaste en el bloque anterior):
# a) Filtrá las filas de un sitio/categoría particular.
# b) Creá una columna nueva con mutate() (una conversión de unidad, o una
#    clasificación en categorías).
# c) Agrupá por tu variable categórica principal y calculá al menos dos
#    estadísticos resumen con summarize().
