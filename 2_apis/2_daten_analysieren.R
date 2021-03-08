#
# Skript, um aufbereiteten Facepager-Export zu analysieren 
# 

#
# Libraries ----
#

library(tidyverse)


#
# Daten einlesen ----
# 
data <- read_csv2("express.csv",na = "None")


# Mittelwert der Kommentare bestimmen
mean(data$comments.count)

# die drei Post mit den meisten Kommentaren bestimmen 
top.commented <- data %>% 
  arrange(-comments.count) %>% 
  slice_head(n=3)




