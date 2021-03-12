#
# Skript, um den Export aus Facepager 
# aufzubereiten und auszuwerten
#

#
# Libraries ----
#

library(tidyverse)
library(writexl)
library(ggplot2)


#
# Daten einlesen ----
# 

export <- read_csv2("../1_erhebung/export.express.csv",na = "None")


#
# Daten aufbereiten ----
# 
# Ziel: Liste der Kommentare mit 
# Informationen zu Posts
#


# Posts herausfiltern
posts <- export %>%  
  filter(object_type=="data") %>% # Daten-Typ "Offcut" entfernen
  filter(level==1) %>% # Nur Posts behalten (level 1)
  select(parent_id, id, post_id=object_id, post=message, created_time, 
         comment_count, reactions, like, love, wow, haha, sad, angry) 

# Kommentare herausfiltern
comments <- export %>% 
  filter(object_type=="data") %>% 
  filter(level==2) %>% 
  select(parent_id, comment_id=object_id, comment=message, created_time, 
         comment_count, reactions, like, love, wow, haha, sad, angry)

# Posts an die Kommentare heranholen
comments <- comments %>% 
  left_join(select(posts, post, id, post_id), by=c("parent_id"="id")) %>% 
  select(-parent_id)


#
# Datensatz abspeichern ----
#

# Als CSV-Datei:
write_csv2(comments, "express.comments.csv")

# Und/oder als Excel-Datei: 
write_xlsx(comments, "express.comments.xlsx")


#
# Daten auswerten ----
# Ziel: Posts mit den meisten Likes finden, 
# Verteilung der Reaktionen visualisieren
#

# Post mit den meisten Likes
top.posts <- posts %>%  
  slice_max(like, n=3)


# Grafik: Visualisierung Reaktions-Typen je Posts
posts %>% 
  
  # Aufbereitung des Datensatzes 
  slice_max(reactions, n=20) %>% 
  pivot_longer(cols=c(like, love, wow, haha, sad, angry), names_to="type") %>% 
  mutate(post_id=fct_reorder(as.character(post_id), reactions, .desc=T)) %>% 
  mutate(type=factor(type, levels=c("angry", "sad", "haha", "wow", "love", "like"))) %>% 
  
  # Grafik erstellen: x- und y-Werte festlegen, Typ: gestapeltes Balkendiagramm
  ggplot(aes(x=post_id, y=value, fill=type))+
  geom_col(position="stack") + 
  
  # Grafik formatieren: Beschriftungen Titel und Achsen
  ggtitle("Reaktionen je Post") +
  labs(y="Anzahl", x="Post ID", fill="Typ Reaktion") +
  scale_x_discrete(label= function(x) str_trunc(str_extract(x, "_.*"), width=10), guide = guide_axis(angle = 90)) +
 
  # Grafik formatieren: Farben
  theme_bw() + 
  scale_fill_manual(
    values=c("goldenrod2", "darkolivegreen3", "lightblue", "coral", "brown3", "deepskyblue4"), 
    breaks=c("angry", "sad", "haha", "wow", "love", "like")
    )
  

# Grafik: Verteilung der Reaktionen
posts %>%  
  
  # Aufbereitung des Datensatzes 
  slice_max(reactions, n=20) %>% 
  pivot_longer(cols=c(like, love, wow, haha, sad, angry), names_to="type") %>% 
  mutate(type=factor(type, levels=c("angry", "sad", "haha", "wow", "love", "like"))) %>% 
  
  # Grafik erstellen: x- und y-Werte festlegen, Typ: Boxplot, Logarithmierte Y-Achse
  ggplot(aes(x=type, y=(value+1), color=type)) +
  geom_boxplot(lwd=1, show.legend=FALSE) + # lwd für Dicke der Linien, Legende nicht anzeigen lassen
  scale_y_log10() +
  
  # Grafik formatieren: Beschriftungen Titel und Achsen
  ggtitle("Verteilung der Reaktionen") +
  labs(y="Wert +1", x="Typ Reaktion") +
  
  # Grafik formatieren: Farben
  theme_bw() + 
  scale_color_manual(
    values=c("goldenrod2", "darkolivegreen3", "lightblue", "coral", "brown3", "deepskyblue4"), 
    breaks=c("angry", "sad", "haha", "wow", "love", "like")
  )   
