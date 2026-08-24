# Datos

Esta carpeta contiene el dataset ambiental usado como hilo conductor a lo largo de las dos sesiones.

**Pendiente de definir.** Candidatos típicos para un laboratorio de Geografía Física y Ambiental:

- Serie de caudal de un río o cuenca (con componente temporal y espacial si hay varias estaciones de aforo).
- Serie de temperatura/precipitación de estaciones meteorológicas (SMN, NASA POWER).
- Puntos de muestreo propios del laboratorio con alguna variable ambiental (calidad de suelo, cobertura vegetal, NDVI puntual, etc.).

### Requisitos del dataset para que funcione en las dos sesiones

- Debe tener **al menos una variable numérica continua** (para estadística descriptiva, correlación y gráficos).
- Debe tener **una variable de agrupamiento** (sitio, estación, año) para poder aplicar `group_by`/`summarize` y comparaciones (t-test/ANOVA).
- Debe tener **coordenadas geográficas** (lat/long) o ser vinculable a un shapefile de puntos/polígonos, para la Sesión 2 (`sf`).
- Idealmente, un archivo raster asociado (DEM, NDVI, variable climática grillada) para el bloque de introducción a `terra` — no imprescindible, puede quedar como script de referencia con datos públicos (WorldClim, Copernicus) si el laboratorio no tiene uno propio a mano.

### Formato esperado una vez definido

```
data/
├── datos_ambientales.csv        <- tabla principal (una fila por observación)
└── puntos_muestreo.shp (+ .dbf, .shx, .prj)   <- si el dataset es espacial vectorial nativo
```

Se actualizará este archivo en cuanto el laboratorio confirme el dataset a utilizar.
