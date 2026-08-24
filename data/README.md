# Datos

Dataset de ejemplo usado como hilo conductor en las dos sesiones del curso: registros climáticos mensuales (2020-2024) para 6 localidades de la provincia de Santa Fe.

> **Importante — dataset sintético.** No son datos observados: se generan con `00_generar_dataset.R` con una estructura y magnitudes realistas (gradiente térmico norte-sur, estacionalidad, variabilidad aleatoria), pero **con fines exclusivamente pedagógicos**. Se optó por esto para que el taller no dependa de la conexión a internet del aula ni de una API externa. Cuando el laboratorio tenga su propio dataset ambiental, el flujo de los scripts es el mismo: solo cambia el `read.csv()` inicial.

## Archivos

```
data/
├── 00_generar_dataset.R          <- script generador (se corre UNA VEZ, antes del curso)
├── datos_climaticos_santafe.csv  <- serie mensual: sitio, fecha, temperatura, precipitación
├── estaciones.csv                <- localidades con lat/lon (para el bloque de sf)
└── raster/
    └── temp_referencia.tif       <- raster sintético de temperatura media anual (para terra)
```

## `datos_climaticos_santafe.csv`

| Columna | Descripción |
|---|---|
| `sitio` | Localidad (Reconquista, Rafaela, Santa Fe, Casilda, Rosario, Venado Tuerto) |
| `fecha` | Primer día de cada mes, 2020-01 a 2024-12 |
| `anio` / `mes` | Año y mes como enteros, para agrupar |
| `temperatura_media_c` | Temperatura media mensual (°C) |
| `precipitacion_mm` | Precipitación mensual acumulada (mm) |

360 filas (6 sitios × 60 meses). Pensado para: estadística descriptiva y comparación entre sitios (Sesión 1), y para vincular con `estaciones.csv` en el mapa temático (Sesión 2).

## `estaciones.csv`

Una fila por localidad, con `sitio`, `lat`, `lon` y `region` (Norte/Centro/Sur). Se usa para convertir las localidades en un objeto espacial (`sf::st_as_sf()`) en el Bloque 1 de la Sesión 2.

## `raster/temp_referencia.tif`

Raster sintético (grilla de 0.05° sobre la provincia de Santa Fe) que simula un producto climático tipo WorldClim. Se usa únicamente en el bloque guiado de introducción a `terra` — los participantes lo ejecutan y observan, no lo generan en vivo.

## Regenerar el dataset

Solo necesario si se quiere modificar el diseño (más localidades, otro rango de fechas, etc.). Requiere los paquetes `dplyr`, `tidyr` y `terra`:

```r
source("data/00_generar_dataset.R")
```
