
# id script ---------------------------------------------------------------

#Lenguajes de programacion estadistica
#Profesor: Christian Sucuzhana Arevalo
#Alumno: Raul Vallverdu Esteban ; exp: 22060707
#Hands on 01


# Ingest function ---------------------------------------------------------

#crtl +  l = clean console
#crtl + shift + r = new section



# Git commands -------------------------------------------------------------

git status
git init
git add
git commit -m "mensaje"
git push -u origin main
git branch Emilia
git merge
git remote add origin https://github.com/sukuzhanay/LPE21535220.git
git clone https://github.com/sukuzhanay/LPE21535220.git
git pull
git fetch


# Terminal commands -------------------------------------------------------

ls
cd
pwd
cd ..
mkdir   crear directorio
touch   
nano   
less   pequeña informacion del archivo
cat   parecido al less pero puedes moverte por el archivo
where   saber donde esta el archivo
which   lo mismo que where



# loading libs ------------------------------------------------------------

install.packages("tidyverse")
install.packages (c("tidyverse","httr","janitor"))
library(tidyvere)
library(httr)
#readr::
#dplyr::
#selectr::

  
 

install.packages("pacman") 

  

# Basic Operators ---------------------------------------------------------


cristina <- 20    #asignacion de valores
clase_lep <- c("Marta","Emilia","Pablo")   #guarda estos datos en forma de array / caracter
httr::  #sirve para traer datos desde internet

#control + shift + m      %>% 

df <- httr::GET("https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/")

glimps(preciosEESS_es)



# Reading and Writing files -----------------------------------------------------

  
  
  
  

