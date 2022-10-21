#Case study from 0 to hero -----------------------------------------------------   

#Enrique Marin Sanchez 22076186
browseURL("https://github.com/HenryMarinS/LPE22076186")

#Librerias -----------------------------------------------------  

if(!require("pacman")) install.packages("pacman")
pacman::p_load(pacman,magrittr,productplots,psych,RColorBrewer,tidyverse)

# pacman - load and unload
# magrittr - bidirectional piping
# productplots - graphics and cat bar
# psych - statistics
# RColorBrewer - painting and color palet

#Cargar y preparar datos -----------------------------------------------------

browseURL("http://j.mp/37Wxvv7")
?happy
que_tipo <- happy
df <- happy %>% as_tibble()
levels(df$happy) #Mirar niveles de felicidad

#Reverser levels

df %<>% mutate(happy=fct_rev(happy)) #Magrittr

#Outcome variables: happiness -----------------------------------------------------

df%>%ggplot()+geom_bar(aes(happy,fill=happy))+
  theme(axis.title.x = element_blank(),legend.position = "none") #Graficaso

#Frequencies of happy

df %>% count(happy)
df %<>% select(happy:health) #Bidireccional para guardar directamente
df %<>% filter(!is.na(happy))

#Happiness and gender -----------------------------------------------------

df %>% ggplot(aes(df$sex,fill=happy))+geom_bar(position = "fill")

#Happiness and marital status -----------------------------------------------------

df %>% ggplot(aes(df$marital,fill=happy))+geom_bar(position = "fill")

#Happiness and education level -----------------------------------------------------

df %>% ggplot(aes(df$degree,fill=happy))+geom_bar(position = "fill")

#Dichotomous married/no variable -----------------------------------------------------

df %<>% mutate(married = if_else(marital=="married","yes","no")) %>%
  mutate(married=as_factor(married)) %>% view()
