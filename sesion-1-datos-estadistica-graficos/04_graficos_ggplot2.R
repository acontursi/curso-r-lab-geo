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
# Sesión 1: Bloque 4 (75 min)
# Gramática de gráficos con ggplot2
# =============================================================================
#
# OBJETIVO DE ESTE BLOQUE
# Aprender la lógica de ggplot2 (datos + estética + geometría) y producir,
# como cierre de la Sesión 1, un gráfico propio a partir de los propios datos.

library(dplyr)
library(ggplot2)

datos <- read.csv("data/datos_climaticos_santafe.csv")
datos$fecha <- as.Date(datos$fecha)  # convertir texto a fecha real

# -----------------------------------------------------------------------------
# 1. La lógica de ggplot2: datos + aes() + geom_*()
# -----------------------------------------------------------------------------
# Toda llamada a ggplot sigue esta estructura:
#   ggplot(datos, aes(x = ..., y = ...)) + geom_algo()
#
# - ggplot(datos, aes(...)) define QUÉ datos y QUÉ variables van en cada eje
# - + geom_algo() define CÓMO se dibuja (puntos, líneas, barras, cajas...)

# Ejemplo mínimo: temperatura a lo largo del tiempo, para un sitio
datos |>
  filter(sitio == "Santa Fe") |>
  ggplot(aes(x = fecha, y = temperatura_media_c)) +
  geom_line()

# -----------------------------------------------------------------------------
# 2. Serie temporal comparando varios sitios
# -----------------------------------------------------------------------------
# aes(color = sitio) asigna un color distinto por categoría automáticamente
grafico_serie <- datos |>
  ggplot(aes(x = fecha, y = temperatura_media_c, color = sitio)) +
  geom_line(linewidth = 0.6) +
  labs(
    title = "Temperatura media mensual por localidad (2020-2024)",
    subtitle = "Provincia de Santa Fe — datos de ejemplo",
    x = NULL,
    y = "Temperatura media (°C)",
    color = "Localidad"
  ) +
  theme_minimal()

grafico_serie

ggsave("sesion-1-datos-estadistica-graficos/grafico_serie_temporal.png",
       plot = grafico_serie, width = 8, height = 5, dpi = 150)

# -----------------------------------------------------------------------------
# 3. Boxplot comparativo entre sitios
# -----------------------------------------------------------------------------
# El boxplot es la forma visual del análisis de outliers del bloque anterior,
# ahora comparando los 6 sitios a la vez.
grafico_boxplot <- datos |>
  ggplot(aes(x = reorder(sitio, precipitacion_mm, FUN = median), y = precipitacion_mm)) +
  geom_boxplot(fill = "#4C78A8", alpha = 0.7) +
  labs(
    title = "Distribución de precipitación mensual por localidad",
    subtitle = "Ordenado de menor a mayor mediana",
    x = NULL,
    y = "Precipitación mensual (mm)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))

grafico_boxplot

ggsave("sesion-1-datos-estadistica-graficos/grafico_boxplot_precipitacion.png",
       plot = grafico_boxplot, width = 7, height = 5, dpi = 150)

# -----------------------------------------------------------------------------
# 4. Facets: un panel por sitio (alternativa a superponer colores)
# -----------------------------------------------------------------------------
# Útil cuando hay muchas categorías y superponerlas satura el gráfico.
grafico_facets <- datos |>
  ggplot(aes(x = fecha, y = temperatura_media_c)) +
  geom_line(color = "#B03A2E") +
  facet_wrap(~ sitio, ncol = 3) +
  labs(title = "Temperatura media mensual — panel por localidad",
       x = NULL, y = "Temperatura media (°C)") +
  theme_minimal()

grafico_facets

# -----------------------------------------------------------------------------
# 5. Gráfico de dispersión: relación temperatura-precipitación
# -----------------------------------------------------------------------------
# Retoma la correlación calculada en el bloque anterior, ahora en forma visual.
grafico_dispersion <- datos |>
  ggplot(aes(x = temperatura_media_c, y = precipitacion_mm)) +
  geom_point(alpha = 0.5, color = "#2E7D32") +
  geom_smooth(method = "lm", se = TRUE, color = "black") +
  labs(
    title = "Relación entre temperatura y precipitación mensual",
    x = "Temperatura media (°C)",
    y = "Precipitación (mm)"
  ) +
  theme_minimal()

grafico_dispersion

# -----------------------------------------------------------------------------
# 6. Ejercicio con datos propios (CIERRE DE LA SESIÓN 1)
# -----------------------------------------------------------------------------
# Con tu propio dataset (o siguiendo con el de ejemplo si todavía no tenés uno
# propio cargado), producí UNO de estos dos gráficos:
#   a) Una serie temporal de tu variable principal, coloreada por tu variable
#      de agrupamiento (como el grafico_serie de arriba).
#   b) Un boxplot comparativo de tu variable principal según tu variable de
#      agrupamiento (como el grafico_boxplot de arriba).
#
# Guardalo con ggsave() en esta misma carpeta. Este gráfico es el que vamos a
# insertar en el documento RMarkdown final en la Sesión 2 — no lo pierdan.
