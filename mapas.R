

library(sparklyr)
library(httr)
library(tidyverse)
library(leaflet)
library(janitor)

options(max.print = 100000)
pacman::p_load(httr,tidyverse,leaflet,janitor,readr,sparklyr)
url<-"https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
res_<-httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
xml2::read_xml(res_$content)

f_raw<-jsonlite::fromJSON(url_)
df_source<-f_raw$ListaEESSPrecio %>% glimpse()
janitor::clean_names(df_source)%>% glimpse()  
locale() #comprobar parametros 
dataset<-df_source %>% janitor::clean_names()%>% type_convert(locale = locale(decimal_mark = ","))

#Gasoleo A. Top 10 mas caras
dataset %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(10, precio_gasoleo_a) %>% 
  leaflet() %>% addTiles() %>%
  addClircleMarkers(lng=~longitud_wgs84,lat=~latitud,popup=~rotulo,label= ~precio_gasoleo_a)
#Gasoleo A. Top 20 m?s baratas
dataset %% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(-20, precio_gasoleo_a) %>%
  leaflet0 %% addTiles0 %>%
  addCircleMarkers(lng=~longitud_wgs84, lat = ~latitud, popup = ~rotulo, label = ~precio_gasoleo_a)