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
html <- content(response,"parsed")


#
# 2. Artikelliste rausholen ----
#

# Mithilfe von CSS die Artikel herausholen
html_articles <- html %>% html_nodes("article")
html_articles

# Aus jedem Artikel-Element den Titel rausholen
data_titles <- html_articles %>% 
  html_node("span.zon-teaser-standard__title") %>% 
  html_text(trim=T)

# Aus jedem Artikel-Element den Link rausholen
data_urls <- html_articles %>% 
  html_attr("data-unique-id")

#
# 3. Abspeichern ----
#

# Ein Tibble (=Tabelle) erstellen
articles <- tibble(
  title = data_titles,
  url   = data_urls
)


# Ergebnis als Excel-Datei abspeichern
write_xlsx(articles,"data/articles.xlsx")
