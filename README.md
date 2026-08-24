# Curso de R — Laboratorio de Geografía Física y Ambiental

**Introducción a R para el Análisis Estadístico, Gráfico y Espacial**
*Del dato ambiental al paper reproducible*

Repositorio del curso dictado para el Laboratorio de Geografía Física y Ambiental. Contiene el programa académico, los scripts de cada sesión y la plantilla de RMarkdown usada como producto final del taller.

---

## Ficha técnica

| | |
|---|---|
| **Destinatarios** | Integrantes del laboratorio sin experiencia previa en R |
| **Carga horaria** | 8 horas totales, en 2 sesiones de 4 horas |
| **Modalidad** | Presencial, taller práctico (bring your own device) |
| **Requisitos previos** | Ninguno |
| **Producto final** | Documento RMarkdown compilado con estructura de paper (introducción, métodos, resultados), con un gráfico, un mapa temático y una tabla estadística propios |

## Estructura del repositorio

```
curso-r-lab-geografia/
├── README.md                              <- este archivo (programa académico)
├── docs/                                  <- versión publicada online (GitHub Pages)
│   └── index.html                         <- presentación de instalación, ya compilada
├── 00-instalacion-r-rstudio/              <- presentación: instalar R/RStudio, R base vs. librerías
├── data/                                  <- dataset ambiental de ejemplo
├── sesion-1-datos-estadistica-graficos/   <- scripts de la Sesión 1
└── sesion-2-espacial-rmarkdown/           <- scripts y plantilla de la Sesión 2
```

Cada carpeta de sesión tiene su propio `README.md` con el detalle de bloques y tiempos, y los scripts numerados en el orden en que se recorren durante el taller.

## Presentación: instalación de R y RStudio

Antes de la Sesión 1, se recomienda repasar la presentación introductoria sobre instalación de R, instalación de RStudio, y la diferencia entre R base y las librerías (paquetes). Está armada en R Markdown (ver [`00-instalacion-r-rstudio/`](00-instalacion-r-rstudio/)) y se puede ver:

- **Online**, una vez publicado el repositorio con GitHub Pages activado (ver sección siguiente): `https://<usuario-o-organizacion>.github.io/curso-r-lab-geografia/`
- **Localmente**, abriendo `docs/index.html` en cualquier navegador, sin necesidad de R

## Publicar la presentación online (GitHub Pages)

El repositorio ya incluye el HTML compilado en `docs/index.html`. Para que se vea en una URL pública, solo hace falta activar GitHub Pages una vez:

1. En GitHub, ir a **Settings > Pages** del repositorio
2. En "Build and deployment" → "Source", elegir **"Deploy from a branch"**
3. En "Branch", elegir **`master`** (o `main`) y la carpeta **`/docs`**
4. Guardar. GitHub tarda uno o dos minutos en publicarla la primera vez

La URL queda como `https://<usuario-o-organizacion>.github.io/curso-r-lab-geografia/`. Cada vez que se actualice `docs/index.html` y se suba con `git push`, la página online se actualiza sola (puede tardar un minuto).

## 1. Fundamentación

El curso responde a la necesidad del laboratorio de incorporar herramientas de análisis cuantitativo y espacial reproducibles como parte del flujo de trabajo habitual de investigación. R integra en un mismo flujo la limpieza de datos, el análisis estadístico, la elaboración de gráficos y mapas, y la redacción del documento final.

Dado que se dispone de 8 horas para esta primera instancia, el diseño prioriza la construcción de un flujo de trabajo completo y replicable por sobre el dominio exhaustivo de cada herramienta. Se busca que cada participante egrese con un script propio, funcional, que pueda seguir ampliando de manera autónoma.

## 2. Objetivos

### 2.1. Objetivo general

Brindar a los integrantes del laboratorio las herramientas básicas de R necesarias para transformar datos ambientales propios en resultados estadísticos, gráficos y mapas, integrados en un documento reproducible con estructura de paper académico.

### 2.2. Objetivos específicos

- Familiarizar a los participantes con el entorno de R y RStudio y con la lógica de trabajo por proyectos.
- Introducir el manejo básico de datos con el paquete `dplyr` para la limpieza y transformación de información ambiental.
- Aplicar estadística descriptiva y pruebas de comparación simples sobre variables ambientales propias.
- Construir gráficos con `ggplot2` orientados a la comunicación de resultados ambientales.
- Introducir el manejo de datos espaciales vectoriales con el paquete `sf` y la elaboración de mapas temáticos.
- Integrar gráficos, mapas y tablas en un documento RMarkdown con estructura de paper académico.

## 3. Estructura general

| Sesión | Eje temático | Cierre parcial |
|---|---|---|
| 1 | Datos, estadística y gráficos | Script propio: datos limpios, estadísticos descriptivos y un gráfico con datos del participante |
| 2 | Análisis espacial y RMarkdown | Documento RMarkdown compilado con estructura de paper: gráfico + mapa + tabla propios |

## 4. Sesión 1 — De datos crudos a gráficos y estadística (4 hs)

| Bloque | Duración | Contenido | Script |
|---|---|---|---|
| 1 | 45 min | Entorno de trabajo: RStudio, proyectos (`.Rproj`), importación de datos propios (CSV/Excel) | `01_entorno_y_proyecto.R` |
| 2 | 45 min | Tidyverse esencial: `dplyr` (filter, mutate, group_by, summarize) y el operador pipe (`\|>`) | `02_tidyverse_basico.R` |
| 3 | 60 min | Estadística descriptiva aplicada: tendencia central, dispersión, outliers, correlación y una prueba de comparación (t-test o ANOVA) | `03_estadistica_descriptiva.R` |
| 4 | 15 min | Descanso | — |
| 5 | 75 min | Gramática de gráficos con `ggplot2`: serie temporal o boxplot comparativo con datos propios | `04_graficos_ggplot2.R` |

Ver detalle en [`sesion-1-datos-estadistica-graficos/README.md`](sesion-1-datos-estadistica-graficos/README.md).

## 5. Sesión 2 — Análisis espacial e integración en RMarkdown (4 hs)

| Bloque | Duración | Contenido | Script |
|---|---|---|---|
| 1 | 90 min | Datos espaciales vectoriales con `sf`: CRS, mapa temático con `ggplot2` + `sf` | `01_datos_espaciales_sf.R` |
| 2 | 15 min | Descanso | — |
| 3 | 30 min | Introducción guiada a datos raster con `terra` (DEM, NDVI, variables climáticas), a partir de un script ya elaborado | `02_raster_referencia.R` |
| 4 | 90 min | RMarkdown: YAML, chunks, inserción de gráfico y mapa propios, tablas con `kable`, esqueleto de paper | `03_paper_template.Rmd` |
| 5 | 15 min | Compilación del documento a PDF/HTML y cierre | — |

Ver detalle en [`sesion-2-espacial-rmarkdown/README.md`](sesion-2-espacial-rmarkdown/README.md).

## 6. Metodología

Taller práctico con un dataset ambiental propio del laboratorio, usado como hilo conductor a lo largo de las dos sesiones. Se trabaja con plantillas ya elaboradas (script raster de referencia y plantilla RMarkdown base) para que los participantes se concentren en la lógica del flujo de trabajo y no en resolver problemas de sintaxis desde cero.

## 7. Materiales y recursos

- Dataset ambiental de ejemplo, único para ambas sesiones: registros climáticos mensuales sintéticos de 6 localidades de Santa Fe (ver [`data/README.md`](data/README.md)).
- Script de referencia sobre datos raster (`terra`), para exploración posterior a la cursada.
- Plantilla RMarkdown base, con YAML y estructura de secciones ya definida.
- Guía de instalación previa (ver más abajo), a distribuir antes de la Sesión 1.

## 8. Acreditación

Entrega del documento RMarkdown compilado producido durante la Sesión 2, con datos propios de cada participante. No se prevé evaluación mediante examen.

## 9. Proyección futura

Quedan como contenidos pendientes para una eventual segunda etapa: análisis raster en profundidad, modelos de regresión múltiple, uso de plantillas de revista (`rticles`) para el paper final, y análisis multivariado.

## Instalación previa

Antes de la Sesión 1, cada participante debe tener instalado:

```r
install.packages(c(
  "tidyverse",   # incluye dplyr, ggplot2, tidyr, etc.
  "sf",
  "terra",
  "rmarkdown",
  "knitr",
  "kableExtra"
))
```

Si ya tenían R instalado de antes (no una instalación nueva), conviene además actualizar todos los paquetes existentes para evitar conflictos de versiones entre dependencias:

```r
update.packages(ask = FALSE)
```

Hacer esto la noche anterior al taller, no el mismo día (puede tardar varios minutos).

Se recomienda además tener instalado [RStudio Desktop](https://posit.co/download/rstudio-desktop/) y, en el caso de RMarkdown a PDF, una distribución de LaTeX.

**Recomendado: TinyTeX** (más liviano y menos propenso a errores de paquetes faltantes que una instalación manual de TeX Live):

```r
install.packages("tinytex")
tinytex::install_tinytex()
```

Si en cambio se usa una distribución de TeX Live del sistema operativo (por ejemplo vía `apt` en Linux), verificar que estén instalados los paquetes `lmodern` y `ulem` (parte de `texlive-latex-recommended` / `texlive-plain-generic`): sin ellos, `03_paper_template.Rmd` falla al compilar a PDF con errores de tipo `File 'lmodern.sty' not found`.

## Cómo usar este repositorio

```bash
git clone https://github.com/<usuario-o-organizacion>/curso-r-lab-geografia.git
cd curso-r-lab-geografia
```

Abrir el proyecto en RStudio y recorrer los scripts en el orden numerado dentro de cada carpeta de sesión.

## Solución de problemas

### `No LaTeX installation detected` al compilar el PDF

Error esperable si nunca se instaló LaTeX en la máquina. Se soluciona instalando TinyTeX desde R (no requiere permisos de administrador ni instalar nada por fuera de R):

```r
install.packages("tinytex")
tinytex::install_tinytex()
```

Cerrar y reabrir RStudio después de que termine, y volver a compilar. Si por algún motivo la instalación de TinyTeX falla o no se quiere instalar LaTeX ese día, se puede compilar a HTML en su lugar: en RStudio, desplegar la flecha junto al botón **Knit** y elegir **Knit to HTML**.

### `namespace 'systemfonts' ... is being loaded, but >= X.X.X is required` al cargar `kableExtra`

Conflicto de versiones entre paquetes instalados en momentos distintos. Se soluciona actualizando y reiniciando R (no alcanza con solo instalar, hay que reiniciar la sesión):

```r
install.packages(c("systemfonts", "textshaping", "ragg", "kableExtra"))
```

Luego `Session > Restart R` en RStudio (o `Ctrl+Shift+F10`) antes de volver a compilar.

**Recomendación para el día del taller:** para evitar este tipo de conflictos de versión en vivo, pedir a los participantes que corran `update.packages(ask = FALSE)` la noche anterior, no el mismo día del curso.
