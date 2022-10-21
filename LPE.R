
# id script ---------------------------------------------------------------

#Lenguajes de programacion estadistica
#Profesor: Christian Sucuzhanay Arevalo
#Alumno: Enrique Marin Sanchez, exp: 22076186
#Hands on 01


# Ingest function ---------------------------------------------------------

#crtl +  l = clean console
#crtl + shift + r = new section



# Git commands -------------------------------------------------------------

#git status
#git init
#git add
#git commit -m "mensaje"
#git push -u origin main
#git branch Emilia
#git merge
#git remote add origin https://github.com/sukuzhanay/LPE21535220.git
#git clone https://github.com/sukuzhanay/LPE21535220.git
#git pull
#git fetch


# Terminal commands -------------------------------------------------------

#ls
#cd
#pwd
#cd ..
#mkdir   crear directorio
#touch   
#nano   
#less   pequeña informacion del archivo
#cat   parecido al less pero puedes moverte por el archivo
#where   saber donde esta el archivo
#which   lo mismo que where



# loading libs ------------------------------------------------------------

install.packages(c("tidyverse","httr","janitor"))
install.packages("janitor")
install.packages("pacman")
library(tidyverse, httr)
  

# Basic Operators ---------------------------------------------------------


df<-httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")

# Getting data from the Internet -----------------------------------------------------

url_<-"https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
res_<-httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")
xml2::read_xml(res_$content)

f_raw<-jsonlite::fromJSON(url_)
df_source<-f_raw$ListaEESSPrecio %>% glimpse()
janitor::clean_names(df_source)%>% glimpse()  
locale() #comprobar parametros 
df<-df_source %>% janitor::clean_names()%>% type_convert(locale = locale(decimal_mark = ","))

#Creating new variables -----------------------------------------------------

#Clasificamos las gasolineras en baratas y no baratas

df_low<-df %>% mutate(expensive = !rotulo %in% c("CEPSA","REPSOL","BP","SHELL"))

##Cual es el precio medio en los CCAA

ds22076186_33<-df_low %>% select(precio_gasoleo_a,idccaa,rotulo,expensive) %>% drop_na() %>% group_by(idccaa,expensive) %>% summarise(mean(precio_gasoleo_a)) %>% view()
 
ds22076186_34<-df_low%>%select(precio_gasoleo_a,idccaa,rotulo,expensive)%>%drop_na()%>%group_by(idccaa,expensive)%>%summarise(mean(precio_gasoleo_a))%>%data.frame("Comunidades"= c("Andalucia","Aragón","Principado de Asturias","Islas Baleares","Canarias","Cantabria","CastillaLeon","CastillaLaMancha","Cataluña","ComunidadValenciana","Extremadura","Galicia","Madrid","Murcia","Navarra","Paisvasco","Rioja","Ceuta","Melilla"))%>%view()

write.csv(df_low,"ds22076186_33.csv")

write.csv(ds22076186_34,"ds22076186_34.csv")



# A -----------------------------------------------------


options(max.print = 100000)
pacman::p_load(httr,tidyverse,leaflet,janitor,readr,sparklyr)
url<-"https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/"
httr::GET(url)
library(sparklyr)
library(httr)
library(tidyverse)
library(leaflet)
library(janitor)


#Gasoleo A. Top 10 mas caras
df %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(10, precio_gasoleo_a) %>% 
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84,lat=~latitud,popup=~rotulo,label= ~precio_gasoleo_a)
#Gasoleo A. Top 20 m?s baratas
df %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(-20, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longituD_wgs84,lat=~latitud,popup=~rotulo,label= ~precio_gasoleo_a)
# Top 10 mas baratas vALLADOLID
df %>% filter(provincia=="VALLADOLID") %>% select(rotulo, latitud, longitud_wgs84, precio_gasoleo_a, localidad, direccion) %>%
  top_n(-10, precio_gasoleo_a) %>%
  leaflet() %>% addTiles() %>%
  addCircleMarkers(lng=~longitud_wgs84,lat=~latitud,popup=~rotulo,label= ~precio_gasoleo_a)
  
  

