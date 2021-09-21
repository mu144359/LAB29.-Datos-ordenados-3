####################
#                  #
# Copiar todo esto #
#                  #
####################
# Hecho con gusto por Selene Muñoz Ortega (UAEH)

# LABORATORIO - Tidy data -datos ordenados- PARTE 1,2 y 3.

# Objetivo: Introducción práctica a los datos ordenados (o tidy data) y a las herramientas que provee el paquete tidyr.
# --------------------------------------------------------------------------------------------------------------------
# En este ejercicio vamos a:
# 1. Cargar datos (tibbles)
# 2. Convertir nuestros tibbles en dataframes (para su exportación)
# 3. Exportar dataframes originales
# 4. Pivotar tabla 4a
# 5. Exportar resultado (TABLA PIVOTANTE)
# 6. Separar y unir tablas



#############################################
#LABORATORIO: Tidy data (datos ordenados) 1 #
#############################################
#Prerrequisitos
#instalar paquete tidyverse
#install.packages("tidyverse")

#instalar paquete tidyr
#install.packages("tidyr")

##instalar paquete dpdyr
#install.packages("dplyr")


#instalar paquete de datos
#install.packages("remotes")
#install.packages("datos")

#Cargar paquete tidyverse y tidyr
library(tidyverse)
library(tidyr)

#Cargar paquete de datos
library(datos)

#Cargar otras paqueterías para que de la función %>% 
library(dplyr)

#tabla 1 hasta tabla 4b
#ver datos como tibble 
datos::tabla1
datos::tabla2
datos::tabla3
datos::tabla4a
datos::tabla4b

#ver datos como dataframe 
df1 <- data.frame(tabla1)
df2 <- data.frame(tabla2)
df3 <- data.frame(tabla3)
df4a <- data.frame(tabla4a)
df4b <- data.frame(tabla4b)


#exportar los dataframes originales
write.csv(df1,file = "df1.csv")
write.csv(df2,file = "df2.csv")
write.csv(df3,file = "df3.csv")
write.csv(df4a,file = "df4a.csv")
write.csv(df4b,file = "df4b.csv")


vignette("tibble")
#explicación de tibble


# Ordenar datos con la tabla4a (PIVOTAR)
t4a_pivotante = table4a %>% 
  pivot_longer(cols = c (`1999`, `2000`), names_to = "anio", values_to = "casos")


# Exportar resultado: tabla ordenada
write.csv(t4a_pivotante,file = "t4a_pivotante.csv")


######PARTE 2######
####################
#                  #
#     Tidy data    #
#                  #
####################


#EJERCICIO 2: PIVOTAR Y UNIR TABLAS
#PARTE 2
# ver tabla4b

# 1. Pivotar tabla 4b "A LO LARGO"
t4b_pivotante = table4b %>% 
  pivot_longer(cols = c (`1999`, `2000`), names_to = "anio", values_to = "poblacion")


# Unir tablas ordenadas
union_t4 = left_join(t4a_pivotante,t4b_pivotante)



# Exportar resultado: tabla4a + tabla4b (ordenada)
write.csv(union_t4,file = "union_t4.csv")


#EJERCICIO 3: DATOS ANCHOS CON TABLA 2
# 1. Pivotar tabla 2 "A LO ANCHO"

#VER TABLA 2

# Ordenar datos con la tabla 2 (PIVOTAR a lo ANCHO)
t2_ancha = df2 %>% 
  pivot_wider(names_from = tipo , values_from = cuenta)

# Exportar resultado: tabla ordenada
write.csv(t2_ancha,file = "t2_ancha.csv")


######PARTE 3######
####################
#                  #
#     Tidy data    #
#                  #
####################

#La tabla3, que tiene un problema diferente:
#tenemos una columna (tasa) que contiene dos variables (casos y poblacion).

#vER TABLA 3
#Separación 1
# Separar casos y población por default
Separado_1 = df3 %>% 
  separate (tasa, into = c("casos", "poblacion"))


# separación 2
# Separar casos y población por caracter "/" "*" "-"
Separado_2 = df3 %>% 
  separate (tasa, into = c("casos", "poblacion"), sep = "/")


#separación 3
# Separar siglo y año de la columna "anio" 
Separado_3 = df3 %>% 
  separate (anio, into = c("siglo", "anio"), sep = 2)


# AHORA VAMOS A UNIR LA TABLA GENERADA ANTERIORMENTE
# VER TABLA "SEPARADO 3"

#Podemos usar unite() para unir las columnas siglo y anio creadas en el ejemplo anterior
Union_1 = Separado_3 %>% 
  unite(nueva, siglo, anio)

Union_2 = Separado_3 %>% 
  unite(nueva, siglo, anio)



# En este caso también necesitamos el argumento sep. Por defecto,
#pondrá un guión bajo (_) entre los valores de las distintas columnas. Si no queremos ningún separador usamos ""

Union_2 = Separado_3 %>% 
  unite(nueva, siglo, anio, sep = "")

