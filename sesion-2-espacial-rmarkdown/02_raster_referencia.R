# =============================================================================
# Sesión 2 · Bloque 3 (30 min)
# Introducción guiada a datos raster con terra
# =============================================================================
#
# CÓMO SE USA ESTE BLOQUE EN CLASE
# A diferencia de los scripts anteriores, este NO se escribe en vivo. El
# docente lo corre y lo proyecta; los participantes lo observan, hacen
# preguntas, y se lo llevan para explorar por su cuenta después del curso.
# El objetivo es que sepan qué es un raster y para qué sirve terra, no que
# lo dominen en 30 minutos.
#
# El raster usado (data/raster/temp_referencia.tif) es SINTÉTICO: simula un
# producto climático tipo WorldClim (temperatura media anual en una grilla),
# generado localmente para no depender de una descarga de internet durante
# el taller. Ver data/00_generar_dataset.R para el detalle.

library(terra)
library(sf)
library(ggplot2)

# -----------------------------------------------------------------------------
# 1. ¿Qué es un raster? Vector vs. raster en una línea
# -----------------------------------------------------------------------------
# - Vector (lo visto en el bloque anterior con sf): geometrías discretas
#   (puntos, líneas, polígonos), cada una con sus propios atributos.
# - Raster: una grilla regular de celdas, cada una con UN valor. Ideal para
#   variables continuas en el espacio (temperatura, elevación, NDVI).

r <- rast("data/raster/temp_referencia.tif")
r

# Información básica: dimensiones, resolución, CRS, rango de valores
dim(r)          # filas, columnas, capas
res(r)          # tamaño de celda (en grados, porque el CRS es lat/lon)
crs(r, describe = TRUE)$name
minmax(r)

# -----------------------------------------------------------------------------
# 2. Visualización rápida (plot base de terra)
# -----------------------------------------------------------------------------
plot(r, main = "Temperatura media anual (raster de referencia)")

# -----------------------------------------------------------------------------
# 3. Extraer el valor raster en un punto (lo más usado en la práctica)
# -----------------------------------------------------------------------------
# Ejemplo: ¿qué valor de temperatura tiene el raster exactamente en la
# ubicación de cada una de nuestras estaciones?
estaciones <- read.csv("data/estaciones.csv")

valores_extraidos <- extract(r, estaciones[, c("lon", "lat")])
estaciones$temp_raster <- valores_extraidos$temp_media_anual_c

estaciones[, c("sitio", "temp_raster")]

# Comparación pedagógica: esto NO tiene por qué coincidir con el promedio
# observado en datos_climaticos_santafe.csv, porque son dos fuentes
# independientes (una es serie temporal simulada, la otra es una superficie
# raster simulada por separado). En un caso real, esta comparación sí
# tendría sentido para validar un producto satelital contra estaciones
# terrestres.

# -----------------------------------------------------------------------------
# 4. Recortar el raster a un área de interés (crop)
# -----------------------------------------------------------------------------
# Si solo nos interesa la mitad norte de la provincia:
extension_norte <- ext(-63, -59, -31, -28.5)
r_norte <- crop(r, extension_norte)
plot(r_norte, main = "Recorte: mitad norte")

# -----------------------------------------------------------------------------
# 5. Combinar raster + vector en un mismo mapa (ggplot2)
# -----------------------------------------------------------------------------
# tidyterra simplifica esto, pero para no sumar una dependencia más al curso,
# lo hacemos convirtiendo el raster a data frame.
r_df <- as.data.frame(r, xy = TRUE)
estaciones_sf <- st_as_sf(estaciones, coords = c("lon", "lat"), crs = 4326)

mapa_raster_vector <- ggplot() +
  geom_raster(data = r_df, aes(x = x, y = y, fill = temp_media_anual_c)) +
  geom_sf(data = estaciones_sf, color = "white", size = 2) +
  geom_sf_text(data = estaciones_sf, aes(label = sitio),
               color = "white", nudge_y = 0.15, size = 3) +
  scale_fill_viridis_c(option = "plasma") +
  labs(
    title = "Raster de referencia + estaciones",
    subtitle = "Temperatura media anual (superficie sintética)",
    fill = "Temp. (°C)", x = NULL, y = NULL
  ) +
  theme_minimal()

mapa_raster_vector

ggsave("sesion-2-espacial-rmarkdown/mapa_raster_vector.png",
       plot = mapa_raster_vector, width = 7, height = 8, dpi = 150)

# -----------------------------------------------------------------------------
# 6. Para seguir explorando después del curso
# -----------------------------------------------------------------------------
# Fuentes públicas de raster ambiental reales, sin necesidad de cuenta:
#   - WorldClim (https://worldclim.org): clima global, resolución hasta 1km
#   - NASA POWER (https://power.larc.nasa.gov): series climáticas por punto
#   - Copernicus Land Monitoring (https://land.copernicus.eu): cobertura de
#     suelo, NDVI, uso de suelo europeo (y algo de cobertura global)
#   - IGN Argentina (https://www.ign.gob.ar): DEM (modelo de elevación) del
#     territorio argentino
#
# El paquete `geodata` (install.packages("geodata")) permite descargar varios
# de estos productos directamente desde R, por ejemplo:
#   geodata::worldclim_country("Argentina", var = "tavg", res = 10, path = tempdir())




#install.packages("tinytex")
#tinytex::install_tinytex()

#install.packages(c("systemfonts", "textshaping", "ragg", "kableExtra"))
