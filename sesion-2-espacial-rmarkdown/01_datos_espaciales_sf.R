# =============================================================================
# Sesión 2 · Bloque 1 (90 min)
# Datos espaciales vectoriales con sf: CRS y mapa temático con ggplot2 + sf
# =============================================================================
#
# OBJETIVO DE ESTE BLOQUE
# Convertir una tabla con coordenadas en un objeto espacial, entender qué es
# un CRS (sistema de coordenadas de referencia), hacer una operación espacial
# simple y producir un mapa temático.

library(dplyr)
library(sf)
library(ggplot2)

# -----------------------------------------------------------------------------
# 1. De tabla a objeto espacial: st_as_sf()
# -----------------------------------------------------------------------------
# Partimos de una tabla común (lat/lon como columnas numéricas) y la
# convertimos en un objeto sf, que R reconoce como espacial.

estaciones <- read.csv("data/estaciones.csv")
head(estaciones)

estaciones_sf <- st_as_sf(
  estaciones,
  coords = c("lon", "lat"),  # OJO: siempre longitud primero, latitud después
  crs = 4326                 # EPSG:4326 = WGS84, el sistema lat/lon estándar
)

estaciones_sf

# La diferencia clave: ahora hay una columna "geometry" y el objeto "sabe"
# en qué sistema de coordenadas está.
class(estaciones_sf)
st_crs(estaciones_sf)$input  # nombre corto del CRS

# -----------------------------------------------------------------------------
# 2. ¿Qué es un CRS y por qué importa?
# -----------------------------------------------------------------------------
# Un CRS define cómo se traducen coordenadas (esféricas, en grados) a un plano.
# EPSG:4326 (lat/lon, WGS84) es el más común para almacenar datos, pero NO es
# ideal para medir distancias o áreas en metros porque los grados no
# representan una distancia constante en toda la Tierra.
#
# Para cálculos métricos en Argentina se suele reproyectar a un sistema en
# metros, por ejemplo POSGAR 2007 / Faja 5 (EPSG:5346) para la región centro.

estaciones_metros <- st_transform(estaciones_sf, crs = 5346)
st_crs(estaciones_metros)$input

# -----------------------------------------------------------------------------
# 3. Una operación espacial simple: distancias entre estaciones
# -----------------------------------------------------------------------------
# st_distance() requiere un CRS métrico para que el resultado esté en metros.
distancias <- st_distance(estaciones_metros)
distancias_km <- round(as.numeric(distancias) / 1000)
matriz_distancias_km <- matrix(distancias_km, nrow = nrow(estaciones_metros),
                                dimnames = list(estaciones_metros$sitio, estaciones_metros$sitio))
matriz_distancias_km

# ¿Cuáles son las dos localidades más alejadas entre sí?
diag(matriz_distancias_km) <- NA
which(matriz_distancias_km == max(matriz_distancias_km, na.rm = TRUE), arr.ind = TRUE)

# -----------------------------------------------------------------------------
# 4. Buffer: área de influencia alrededor de un punto
# -----------------------------------------------------------------------------
# Ejemplo: un radio de 50 km alrededor de cada estación (útil para pensar en
# área de representatividad de una estación meteorológica).
buffers_50km <- st_buffer(estaciones_metros, dist = 50000)  # distancia en metros

# -----------------------------------------------------------------------------
# 5. Combinar con los datos climáticos: mapa temático
# -----------------------------------------------------------------------------
# Unimos el resumen de temperatura promedio (calculado en la Sesión 1) a la
# capa espacial, para colorear cada punto según su temperatura.
datos <- read.csv("data/datos_climaticos_santafe.csv")

resumen_temp <- datos |>
  group_by(sitio) |>
  summarize(temp_promedio = mean(temperatura_media_c), .groups = "drop")

estaciones_mapa <- estaciones_sf |>
  left_join(resumen_temp, by = "sitio")

estaciones_mapa

# Mapa temático: puntos coloreados según temperatura promedio
# (se amplían los límites del mapa con coord_sf() para que las etiquetas de
# las localidades no queden recortadas en los bordes)
bbox <- st_bbox(estaciones_mapa)
margen <- 0.5  # grados de margen alrededor de los puntos

mapa_temperatura <- ggplot(estaciones_mapa) +
  geom_sf(aes(color = temp_promedio, size = temp_promedio)) +
  geom_sf_text(aes(label = sitio), nudge_y = 0.18, size = 3) +
  coord_sf(
    xlim = c(bbox["xmin"] - margen, bbox["xmax"] + margen),
    ylim = c(bbox["ymin"] - margen, bbox["ymax"] + margen)
  ) +
  scale_color_viridis_c(option = "plasma") +
  labs(
    title = "Temperatura media (2020-2024) por localidad",
    subtitle = "Provincia de Santa Fe — datos de ejemplo",
    color = "Temp. media (°C)",
    size = "Temp. media (°C)"
  ) +
  theme_minimal()

mapa_temperatura

ggsave("sesion-2-espacial-rmarkdown/mapa_temperatura.png",
       plot = mapa_temperatura, width = 7, height = 8, dpi = 150)

# -----------------------------------------------------------------------------
# 6. Guardar la capa espacial para usarla después (formato GeoPackage)
# -----------------------------------------------------------------------------
# GeoPackage (.gpkg) es preferible a Shapefile: un solo archivo, sin límite de
# 10 caracteres en nombres de columna, y sin problemas de encoding.
st_write(estaciones_mapa, "sesion-2-espacial-rmarkdown/estaciones_temperatura.gpkg",
         delete_dsn = TRUE, quiet = TRUE)

# -----------------------------------------------------------------------------
# 7. Ejercicio con datos propios
# -----------------------------------------------------------------------------
# Si tu dataset tiene coordenadas propias:
# a) Convertilo a objeto sf con st_as_sf().
# b) Reproyectalo a un CRS métrico apropiado para tu zona de estudio.
# c) Producí un mapa temático con geom_sf() coloreando por tu variable de
#    interés. Este mapa es el que vamos a insertar en el paper del Bloque 4.
