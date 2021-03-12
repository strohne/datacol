#
# Klassisches Webscraping mit Rvest
#


#
# Packages ----
#

library(tidyverse)
library(httr)
library(rvest)
library(xml2)
library(writexl)


#
# 1. Seite herunterladen ----
#


# URL festlegen
url <- "https://www.zeit.de/suche/index?q=kommunikationswissenschaft&mode=1y&type=article"


# Webseite  mit GET-Funktion aus dem httr package herunterladen
response <- GET(url)

text <- content(response,"text")


# Inhalt für später in HTML-Datei abspeichern
cat(text, file="html/zeit_suche.html")

#
# 2. HTML parsen ---
#

# Datei mit read_html-Funktion aus dem rvest package einlesen und parsen
html <- read_html("html/zeit_suche.html")


#
# 3. Anzahl der Suchergebnisse rausholen ----
#


# Mit CSS-Selektor das Element auswählen
data_hits <- html_nodes(html, "h2.search-counter__hits") 

# Den Text aus dem Element holen und trimmen
data_hits <- html_text(data_hits, trim=TRUE) 

# Die Zahl mit einem regulären Ausdruck rausholen
data_hits <- str_extract(data_hits,"[0-9]+") 

# In eine Zahl umwandeln
data_hits <- as.numeric(data_hits)


# Oder...alles auf einmal
data_hits <- html %>% 
  html_nodes("h2.search-counter__hits") %>% 
  html_text(trim=TRUE) %>% 
  str_extract("[0-9]+") %>% 
  as.numeric()

#
# 4. Mehrere Suchbegriffe ----
#

# Vektor mit URLs erstellen
keywords <- c("kommunikationswissenschaft","politikwissenschaft","soziologie","data+science","germanistik")
urls <- paste0("https://www.zeit.de/suche/index?q=",keywords,"&mode=1y&type=article")


# Auf alle URLs die GET-Funktionen anwenden
responses <- map(urls,GET)

# Alle Responses parsen
text <- map(responses,content,"text")
html <- map(text,read_html)

# Aus allen HTML-Elementen die Anzahl der Suchergebnisse rausholen
data_hits <- html %>% 
  map(html_nodes,"h2.search-counter__hits") %>% 
  map(html_text,trim=TRUE) %>% 
  map(str_extract,"[0-9]+") %>% 
  map(as.numeric)


data_hits


#
# 5. Grafik ----
#

# Ein Tibble (=Tabelle erstellen)
data <- tibble(
  keyword = keywords,
  hits= data_hits
)

# Abspeichern
write_xlsx(data,"data/zeithits.xlsx")

# Balkendiagramm
ggplot(data,aes(y=keyword,x=hits)) +
  geom_col()

