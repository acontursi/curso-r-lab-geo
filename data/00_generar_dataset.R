# =============================================================================
# 00_generar_dataset.R
# -----------------------------------------------------------------------------
# Genera el dataset de ejemplo usado a lo largo de las dos sesiones del curso.
#
# IMPORTANTE: este script NO se corre durante el taller. Se ejecuta UNA VEZ,
# antes del curso, y sus resultados (los archivos en data/) son los que se
# suben al repositorio y los que efectivamente usan los participantes.
#
# ¿Por qué datos sintéticos y no una API pública real (ej. NASA POWER, SMN)?
# Un taller de 4 horas no puede depender de la conexión a internet del aula.
# Por eso se generan datos con estructura y magnitudes realistas (climatología
# mensual por localidad de Santa Fe), pero simulados. Se documenta explícita-
# mente para que quede claro frente a cualquier uso posterior con fines de
# investigación real: ESTE DATASET ES SOLO PEDAGÓGICO.
# =============================================================================

library(dplyr)
library(tidyr)

set.seed(2026)

# -----------------------------------------------------------------------------
# 1. Localidades de la provincia de Santa Fe (coordenadas reales aproximadas)
# -----------------------------------------------------------------------------
estaciones <- tibble::tribble(
  ~sitio,           ~lat,     ~lon,      ~region,
  "Reconquista",    -29.15,   -59.65,    "Norte",
  "Rafaela",        -31.25,   -61.49,    "Centro",
  "Santa Fe",       -31.63,   -60.70,    "Centro",
  "Casilda",        -33.03,   -61.17,    "Sur",
  "Rosario",        -32.94,   -60.65,    "Sur",
  "Venado Tuerto",  -33.75,   -61.97,    "Sur"
)

write.csv(estaciones, "data/estaciones.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# 2. Serie mensual 2020-2024 de temperatura y precipitación por localidad
#    - Gradiente térmico norte-sur (más cálido en el norte)
#    - Estacionalidad marcada (verano/invierno hemisferio sur)
#    - Ruido aleatorio + correlación negativa leve temperatura-precipitación
#      en verano (simplificación pedagógica, no un modelo climático real)
# -----------------------------------------------------------------------------
fechas <- seq(as.Date("2020-01-01"), as.Date("2024-12-01"), by = "month")

generar_serie_sitio <- function(sitio, lat, base_temp_offset) {
  n <- length(fechas)
  mes <- as.numeric(format(fechas, "%m"))
  # Temperatura: sinusoide anual + offset por latitud + ruido
  temp <- 20 + base_temp_offset - 8 * cos((mes - 1) / 12 * 2 * pi) +
    rnorm(n, 0, 1.3)
  # Precipitación: mayor en verano (dic-mar), con ruido gamma-like (no negativa)
  precip_base <- 60 + 50 * sin((mes - 1) / 12 * 2 * pi - pi / 2)
  precip <- pmax(0, precip_base + rnorm(n, 0, 25))
  tibble(
    sitio = sitio,
    fecha = fechas,
    anio = as.numeric(format(fechas, "%Y")),
    mes = mes,
    temperatura_media_c = round(temp, 1),
    precipitacion_mm = round(precip, 1)
  )
}

datos_climaticos <- estaciones |>
  rowwise() |>
  reframe(
    generar_serie_sitio(
      sitio,
      lat,
      base_temp_offset = (lat + 31.6) * 0.6
    )
  )

# Nota sobre el offset: lat es negativa y más cercana a 0 hacia el norte, por
# lo que (lat + 31.6) es positivo para sitios al norte de Santa Fe capital y
# negativo para sitios al sur. Al multiplicarlo por un coeficiente positivo y
# sumarlo a la temperatura base, Reconquista (más al norte) queda como la
# localidad más cálida y Venado Tuerto (más al sur) como la más fría,
# consistente con el gradiente real de la región.

write.csv(datos_climaticos, "data/datos_climaticos_santafe.csv", row.names = FALSE)

# -----------------------------------------------------------------------------
# 3. Raster sintético de referencia (simula un raster climático tipo WorldClim)
#    Se usa solo en el bloque guiado de introducción a terra (Sesión 2).
# -----------------------------------------------------------------------------
library(terra)

r <- rast(
  xmin = -63, xmax = -59, ymin = -34.5, ymax = -28.5,
  resolution = 0.05,
  crs = "EPSG:4326"
)

# Gradiente de temperatura media anual: más cálido al norte (fila superior),
# más frío al sur, con ruido espacial suave para simular variabilidad real.
coords <- crds(r, na.rm = FALSE)
lat_grid <- coords[, 2]
temp_anual <- 20 + 0.55 * (lat_grid + 31.6) + rnorm(length(lat_grid), 0, 0.4)
values(r) <- temp_anual
names(r) <- "temp_media_anual_c"

dir.create("data/raster", showWarnings = FALSE)
writeRaster(r, "data/raster/temp_referencia.tif", overwrite = TRUE)

cat("Dataset generado:\n")
cat(" - data/estaciones.csv (", nrow(estaciones), "localidades )\n")
cat(" - data/datos_climaticos_santafe.csv (", nrow(datos_climaticos), "filas )\n")
cat(" - data/raster/temp_referencia.tif\n")
