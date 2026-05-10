# Instalar paquetes necesarios (solo primera vez)
# install.packages("tidyverse")
# install.packages("ggplot2")
# install.packages("readr")
# install.packages("scales")

# Cargar librerías
library(tidyverse)
library(ggplot2)
library(readr)
library(scales)

# Ruta base
ruta <- "C:/Users/diazr/Dropbox/PC/Desktop/DANI/PROYECTO/PORTFOLIO DANIEL/03 - PROYECTO SEGMENTACION SQL/01_Datos/Processed/"

# Cargar datasets exportados de SQL
ventas_estilo <- read_csv(paste0(ruta, "ventas_por_estilo.csv"))
calidad_estilo <- read_csv(paste0(ruta, "calidad_por_estilo.csv"))
perdidas_estilo <- read_csv(paste0(ruta, "perdidas_por_estilo.csv"))
ventas_mensuales <- read_csv(paste0(ruta, "ventas_mensuales.csv"))
top10 <- read_csv(paste0(ruta, "top10_rentabilidad.csv"))

print("Datos cargados correctamente ✓")

# Gráfico 1 - Ventas totales por estilo de cerveza
ggplot(ventas_estilo, aes(x = reorder(Beer_Style, Ventas_Totales), 
                          y = Ventas_Totales, 
                          fill = Beer_Style)) +
  geom_col() +
  coord_flip() +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Ventas Totales por Estilo de Cerveza",
       x = "Estilo",
       y = "Ventas Totales (€)") +
  theme_minimal() +
  theme(legend.position = "none")

# Guardar gráfico 1
ruta_imagenes <- "C:/Users/diazr/Dropbox/PC/Desktop/DANI/PROYECTO/PORTFOLIO DANIEL/03 - PROYECTO SEGMENTACION SQL/04_Documentacion/Imagenes/"

ggsave(paste0(ruta_imagenes, "ventas_por_estilo.png"), 
       width = 10, height = 6, dpi = 150)

# Gráfico 2 - Calidad media por estilo de cerveza
ggplot(calidad_estilo, aes(x = reorder(Beer_Style, Calidad_Media), 
                           y = Calidad_Media,
                           fill = Beer_Style)) +
  geom_col() +
  coord_flip() +
  labs(title = "Calidad Media por Estilo de Cerveza",
       x = "Estilo",
       y = "Puntuación de Calidad") +
  theme_minimal() +
  theme(legend.position = "none") +
  ylim(0, 10)

ggsave(paste0(ruta_imagenes, "calidad_por_estilo.png"), 
       width = 10, height = 6, dpi = 150)

# Gráfico 3 - Pérdidas por estilo de cerveza
perdidas_long <- perdidas_estilo %>%
  select(Beer_Style, Perdida_Elaboracion, 
         Perdida_Fermentacion, Perdida_Embotellado) %>%
  pivot_longer(cols = -Beer_Style, 
               names_to = "Fase", 
               values_to = "Perdida")

ggplot(perdidas_long, aes(x = Beer_Style, 
                          y = Perdida, 
                          fill = Fase)) +
  geom_col(position = "dodge") +
  labs(title = "Pérdidas por Fase de Producción y Estilo",
       x = "Estilo",
       y = "Pérdida Media (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(paste0(ruta_imagenes, "perdidas_por_estilo.png"), 
       width = 10, height = 6, dpi = 150)

# Gráfico 4 - Evolución mensual de ventas
ventas_mensuales$Mes <- as.integer(ventas_mensuales$Mes)

ggplot(ventas_mensuales, aes(x = Mes, 
                             y = Ventas_Totales)) +
  geom_line(color = "#1a9e3f", linewidth = 1.5) +
  geom_point(color = "#1a9e3f", size = 3) +
  scale_x_continuous(breaks = 1:12,
                     labels = c("Ene","Feb","Mar","Abr",
                                "May","Jun","Jul","Ago",
                                "Sep","Oct","Nov","Dic")) +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Evolución Mensual de Ventas 2020",
       x = "Mes",
       y = "Ventas Totales (€)") +
  theme_minimal()

ggsave(paste0(ruta_imagenes, "ventas_mensuales.png"), 
       width = 10, height = 6, dpi = 150)

# Gráfico 5 - Top 10 lotes más rentables
ggplot(top10, aes(x = reorder(Batch_ID, Rentabilidad_Por_Litro),
                  y = Rentabilidad_Por_Litro,
                  fill = Beer_Style)) +
  geom_col() +
  coord_flip() +
  labs(title = "Top 10 Lotes más Rentables por Litro",
       x = "Lote",
       y = "Rentabilidad (€/litro)",
       fill = "Estilo") +
  theme_minimal()

ggsave(paste0(ruta_imagenes, "top10_rentabilidad.png"), 
       width = 10, height = 6, dpi = 150)