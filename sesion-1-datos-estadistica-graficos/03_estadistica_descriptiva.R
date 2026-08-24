# =============================================================================
# Sesión 1 · Bloque 3 (60 min)
# Estadística descriptiva aplicada: tendencia central, dispersión, outliers,
# correlación y una prueba de comparación (t-test / ANOVA)
# =============================================================================
#
# OBJETIVO DE ESTE BLOQUE
# Calcular e INTERPRETAR estadísticos descriptivos y una prueba de
# comparación simple. El foco está en la lectura del resultado, no en la
# demostración matemática de cada fórmula.

library(dplyr)

datos <- read.csv("data/datos_climaticos_santafe.csv")

# -----------------------------------------------------------------------------
# 1. Medidas de tendencia central y dispersión
# -----------------------------------------------------------------------------
# Sobre la temperatura media mensual, en todo el dataset:
media_temp   <- mean(datos$temperatura_media_c)
mediana_temp <- median(datos$temperatura_media_c)
sd_temp      <- sd(datos$temperatura_media_c)     # desvío estándar
rango_temp   <- range(datos$temperatura_media_c)  # mínimo y máximo

cat("Media:", round(media_temp, 2), "°C\n")
cat("Mediana:", round(mediana_temp, 2), "°C\n")
cat("Desvío estándar:", round(sd_temp, 2), "°C\n")
cat("Rango:", rango_temp[1], "a", rango_temp[2], "°C\n")

# summary() da varios de estos estadísticos de una sola vez
summary(datos$temperatura_media_c)

# ¿Cómo se interpreta un desvío estándar alto vs. bajo?
# Un sd bajo indica que los valores están concentrados cerca de la media
# (poca variabilidad estacional o entre sitios); un sd alto indica lo
# contrario. Comparemos temperatura (con fuerte estacionalidad) contra
# precipitación (más errática):
sd(datos$temperatura_media_c)
sd(datos$precipitacion_mm)

# -----------------------------------------------------------------------------
# 2. Detección de outliers (valores atípicos)
# -----------------------------------------------------------------------------
# Método del rango intercuartílico (IQR): un valor es outlier si está por
# fuera de [Q1 - 1.5*IQR, Q3 + 1.5*IQR]
q <- quantile(datos$precipitacion_mm, probs = c(0.25, 0.75))
iqr <- IQR(datos$precipitacion_mm)
limite_inferior <- q[1] - 1.5 * iqr
limite_superior <- q[2] + 1.5 * iqr

outliers <- datos |> filter(precipitacion_mm < limite_inferior | precipitacion_mm > limite_superior)
cat("Límite superior de precipitación 'normal':", round(limite_superior, 1), "mm\n")
cat("Cantidad de meses considerados outliers:", nrow(outliers), "\n")
outliers

# Un boxplot es la forma visual más directa de detectar esto (se retoma en
# el Bloque 5, gráficos)
boxplot(datos$precipitacion_mm, main = "Precipitacion mensual - deteccion de outliers",
        ylab = "mm")

# -----------------------------------------------------------------------------
# 3. Correlación entre variables
# -----------------------------------------------------------------------------
# ¿Existe relación entre temperatura y precipitación?
correlacion <- cor(datos$temperatura_media_c, datos$precipitacion_mm)
cat("Correlación temperatura-precipitación:", round(correlacion, 2), "\n")

# Interpretación de referencia (regla de uso común, no una ley matemática):
#   |r| < 0.3        relación débil o nula
#   0.3 <= |r| < 0.6  relación moderada
#   |r| >= 0.6        relación fuerte
# El signo indica la dirección: positivo = ambas suben juntas;
# negativo = cuando una sube, la otra baja.

# cor.test() además da un test de significancia (p-valor)
cor.test(datos$temperatura_media_c, datos$precipitacion_mm)

# -----------------------------------------------------------------------------
# 4. Comparación entre grupos: ¿difiere la precipitación según el sitio?
# -----------------------------------------------------------------------------
# Con más de dos grupos (6 sitios), la prueba adecuada es ANOVA, no t-test.
# H0 (hipótesis nula): la precipitación media es igual en los 6 sitios.

anova_precip <- aov(precipitacion_mm ~ sitio, data = datos)
summary(anova_precip)

# ¿Cómo leer la tabla de ANOVA?
# - Buscar la fila "sitio" y su columna Pr(>F): es el p-valor.
# - Si p-valor < 0.05 (umbral convencional): se rechaza H0, es decir, HAY
#   evidencia de que al menos un sitio difiere de los demás en precipitación.
# - Si p-valor >= 0.05: no hay evidencia suficiente de diferencia entre sitios.

# -----------------------------------------------------------------------------
# 5. Comparación entre DOS grupos puntuales: t-test
# -----------------------------------------------------------------------------
# Ejemplo: ¿difiere la temperatura entre Reconquista (norte) y Venado Tuerto
# (sur), las localidades más extremas del gradiente?
datos_dos_sitios <- datos |> filter(sitio %in% c("Reconquista", "Venado Tuerto"))

t_test_resultado <- t.test(temperatura_media_c ~ sitio, data = datos_dos_sitios)
t_test_resultado

# Misma lógica de lectura: revisar el p-value. Un p-value muy bajo (por
# ejemplo < 0.001) indica una diferencia estadísticamente muy poco probable
# de deberse al azar.

# -----------------------------------------------------------------------------
# 6. Armar una tabla resumen con los resultados (para usar en el paper)
# -----------------------------------------------------------------------------
tabla_resultados <- tibble::tibble(
  analisis = c("Correlación temp-precip", "ANOVA precipitación~sitio",
               "t-test temperatura Reconquista vs. Venado Tuerto"),
  estadistico = c(
    round(correlacion, 2),
    round(summary(anova_precip)[[1]][["F value"]][1], 2),
    round(t_test_resultado$statistic, 2)
  ),
  p_valor = c(
    round(cor.test(datos$temperatura_media_c, datos$precipitacion_mm)$p.value, 4),
    round(summary(anova_precip)[[1]][["Pr(>F)"]][1], 4),
    round(t_test_resultado$p.value, 4)
  )
)

tabla_resultados

write.csv(tabla_resultados, "sesion-1-datos-estadistica-graficos/tabla_resultados_estadisticos.csv",
          row.names = FALSE)

# -----------------------------------------------------------------------------
# 7. Ejercicio con datos propios
# -----------------------------------------------------------------------------
# a) Calculá media, mediana y desvío estándar de tu variable numérica principal.
# b) Identificá si hay outliers con el método del IQR.
# c) Elegí dos variables numéricas y calculá su correlación.
# d) Si tenés un factor de agrupamiento con 2 niveles, corré un t.test();
#    si tiene 3 o más, corré un aov().
