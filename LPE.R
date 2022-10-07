
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

df_low %>% select(precio_gasoleo_a,idccaa,rotulo,expensive) %>% drop_na() %>% group_by(idccaa,expensive) %>% summarise(mean(precio_gasoleo_a)) %>% view()




# Reading and Writing files -----------------------------------------------------

  
  
  
  

