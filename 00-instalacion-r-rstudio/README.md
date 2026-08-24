# 00 — Instalación de R y RStudio

Presentación introductoria, previa a la Sesión 1: instalación de R, instalación de RStudio, y la diferencia conceptual entre R base y las librerías (paquetes).

## Archivos

```
00-instalacion-r-rstudio/
├── presentacion_instalacion.Rmd   <- fuente (R Markdown)
└── estilos.css                     <- hoja de estilos de la presentación
```

La presentación está armada íntegramente en R (R Markdown + formato `slidy_presentation`, incluido en el paquete `rmarkdown` — no requiere instalar nada adicional). El HTML compilado se publica en `docs/index.html`, en la raíz del repositorio, para que se pueda ver online vía GitHub Pages (ver instrucciones en el README principal).

## Contenido

1. **Instalar R** — Windows, macOS y Linux, paso a paso
2. **Instalar RStudio** — instalación y verificación de que detecta a R
3. **R base vs. librerías** — la distinción entre `install.packages()` (una vez) y `library()` (cada sesión), con la analogía del celular y sus apps

## Cómo recompilarla

Si se edita `presentacion_instalacion.Rmd`, hay que volver a generar el HTML publicado en `docs/`:

```r
rmarkdown::render(
  "00-instalacion-r-rstudio/presentacion_instalacion.Rmd",
  output_file = "../docs/index.html"
)
```

Y commitear el `docs/index.html` actualizado (a diferencia de los demás HTML del curso, este si se versiona — es el que GitHub Pages sirve online).

## ¿Por qué `slidy_presentation` y no `xaringan`?

`xaringan` es el framework más popular para slides en R, pero es un paquete externo que hay que instalar de CRAN. `slidy_presentation` (como `ioslides_presentation`) viene incluido directamente en el paquete `rmarkdown` que ya se instala para el resto del curso — mismo resultado (HTML autocontenido armado en R), sin sumar una dependencia más.
