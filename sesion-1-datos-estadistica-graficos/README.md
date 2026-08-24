# Sesión 1 — De datos crudos a gráficos y estadística (4 hs)

| Bloque | Duración | Contenido | Script |
|---|---|---|---|
| 1 | 45 min | Entorno de trabajo: RStudio, proyectos (`.Rproj`), importación de datos propios (CSV/Excel) | `01_entorno_y_proyecto.R` |
| 2 | 45 min | Tidyverse esencial: `dplyr` (filter, mutate, group_by, summarize) y el operador pipe (`|>`) | `02_tidyverse_basico.R` |
| 3 | 60 min | Estadística descriptiva aplicada: tendencia central, dispersión, outliers, correlación y una prueba de comparación (t-test o ANOVA) | `03_estadistica_descriptiva.R` |
| 4 | 15 min | Descanso | — |
| 5 | 75 min | Gramática de gráficos con `ggplot2`: serie temporal o boxplot comparativo con datos propios | `04_graficos_ggplot2.R` |

**Cierre de la sesión:** cada participante sale con un script propio (`04_graficos_ggplot2.R` como punto de llegada) que limpia sus datos, calcula 2-3 estadísticos descriptivos y produce 1 gráfico con sus propios datos ambientales.

## Cómo recorrer los scripts

Ejecutar en orden, dentro de un mismo proyecto de RStudio (`.Rproj` creado en el Bloque 1). Cada script está comentado y pensado para correrse línea por línea, no de una sola vez.

- [x] `01_entorno_y_proyecto.R`
- [x] `02_tidyverse_basico.R`
- [x] `03_estadistica_descriptiva.R`
- [x] `04_graficos_ggplot2.R`

Los cuatro scripts de la Sesión 1 están probados y corren de punta a punta desde la raíz del proyecto (`Rscript sesion-1-datos-estadistica-graficos/0X_....R`).

## Dataset

Usa `data/datos_climaticos_santafe.csv` (ver [`data/README.md`](../data/README.md) para el detalle completo).
