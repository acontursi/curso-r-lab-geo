# Sesión 2 — Análisis espacial e integración en RMarkdown (4 hs)

| Bloque | Duración | Contenido | Script |
|---|---|---|---|
| 1 | 90 min | Datos espaciales vectoriales con `sf`: CRS, mapa temático con `ggplot2` + `sf` | `01_datos_espaciales_sf.R` |
| 2 | 15 min | Descanso | — |
| 3 | 30 min | Introducción guiada a datos raster con `terra` (DEM, NDVI, variables climáticas), a partir de un script ya elaborado | `02_raster_referencia.R` |
| 4 | 90 min | RMarkdown: YAML, chunks, inserción de gráfico y mapa propios, tablas con `kable`, esqueleto de paper | `03_paper_template.Rmd` |
| 5 | 15 min | Compilación del documento a PDF/HTML y cierre | — |

**Cierre de la sesión:** documento RMarkdown compilado (`03_paper_template.Rmd`) con estructura de paper académico (introducción, métodos, resultados), que integra el gráfico de la Sesión 1, el mapa temático de esta sesión y una tabla estadística.

## Cómo recorrer los scripts

- [x] `01_datos_espaciales_sf.R`
- [x] `02_raster_referencia.R` *(script de referencia — se ejecuta guiado, no se escribe en vivo)*
- [x] `03_paper_template.Rmd` *(plantilla final — se completa con lo producido en las sesiones 1 y 2)*

Los tres archivos están probados: los dos scripts corren de punta a punta, y la plantilla RMarkdown compila tanto a HTML como a PDF (requiere una distribución de LaTeX con los paquetes `lmodern`, `ulem` y afines — ver nota de instalación en el README principal).
