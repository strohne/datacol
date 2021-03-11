#
# Skript, um den Export aus Facepager einzulesen und 
# Hierarchie aufzulösen (Alle Daten zu einem Knoten auf eine Zeile holen)
#

#
# Libraries ----
#

library(tidyverse)
library(writexl)


#
# Daten einlesen ----
# 

export <- read_csv2("data/export.express.csv",na = "None")


#
# Daten aufbereiten ----
# Dafür zunächst die einzelnen Ebenen 
# herausfiltern: Facebook-Seite, Facebook-Posts, Reaktionen 
# und anschließend zu einem Datensatz (wide-Format) zusammenfügen
#

# Facebook-Seite herausfiltern
page <- export %>%  
  filter(level==0) %>% # Nur Startknoten/Facebook-Seite behalten (level 0) 
  mutate(page=object_id) %>% # Neue Spalte "page" hinzufügen, mit Namen der Facebook-Seite
  select(page_id=id, page) 
  
# Posts herausfiltern
posts <- export %>%  
  filter(object_type=="data") %>% # Daten-Typ "Offcut" entfernen
  filter(level==1) %>% # Nur Posts behalten (level 1)
  select(parent_id, post_id=id, post=message, created_time, contains("count")) 

# Reaktionen herausfiltern
comments <- export %>% 
  filter(object_type=="data") %>% 
  filter(level==2) %>% 
  select(parent_id, comment_id=id, comment=message, created_time, comment_count, contains("summary.total_count"))

# Seite, Posts und Reaktionen auf eine Ebene holen
data <- page %>% 
  left_join(posts, by=c("page_id"="parent_id")) %>% 
  left_join(comments, by=c("post_id"="parent_id"))
  
# nicht mehr benötigte Dateien entfernen 
rm(page, posts, reactions)


# Filtern: Spalten für die weitere Analyse auswählen. 
# Einzelne Spalten auswählen über select(Spalte), 
# einzelne Spalten entfernen über select(-Spalte).
data <- data %>%  
  select(-object_type, -query_status, -query_time, -query_type, -level)

# Spalten umbenennen: "summary.total_" enternen, sodass
# z.B. like.summary.tital_count nur noch like.count ist
colnames(data)<-gsub("summary.total_","",colnames(data))


#
# Datensatz abspeichern ----
#

# Als CSV-Datei:
write_csv2(data, "express.csv")

# Und/oder als Excel-Datei: 
write_xlsx(data, "express.xlsx")
