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
url <- "https://www.zeit.de/zett/politik/2021-02/twitch-alexandra-orcasio-cortez-streaming-politiker-bundestagswahl"

# Webseite  mit GET-Funktion aus dem httr package herunterladen
response <- GET(url)
html <- content(response,"parsed")

# Bei Bedarf für später abspeichern
# cat(content(response,"text"),file="html/comments.html")

#
# 2. Liste der Kommentare rausholen ----
#

# ÜBUNG
# Ergänzen Sie den Namen der Elemente, die
# Kommentare enthalten!


# Mithilfe von CSS die Elemente herausholen, die Kommentare enthalten
html_articles <- html %>% html_nodes("WASKOMMTHIERHIN")
html_articles

# Leere Tabelle anlegen
comments <- tibble(no = 1: length(html_articles))

# Aus jedem Kommentar die ID rausholen
comments$ids <- html_articles %>% 
  html_attr("id")

# Aus jedem Kommentar das Datum rausholen
comments$date <- html_articles %>% 
  html_node("a.comment-meta__date") %>% 
  html_text(trim=TRUE)

# Aus jedem Kommentar den Namen rausholen
comments$name <- html_articles %>% 
  html_node("h4.comment-meta__name") %>% 
  html_text(trim=TRUE)

# Aus jedem Kommentar den Link rausholen
comments$url <- html_articles %>% 
  html_node("a.comment-meta__date") %>% 
  html_attr("href")

# ÜBUNG
# Ergänzen Sie die Tabelle um folgende Spalten:
# - Text des Kommentars
# - Anzahl der Leseempfehlungen (Sternchen)

#
# 3. Aufbereiten ----
#

# Leere ausfiltern
comments <- filter(comments,!is.na(date))

# Ebene und Datum trennen
comments <- comments %>% 
  separate(date,into=c("level","date"),sep="—")

#
# 4. Abspeichern ----
#


# Ergebnis als Excel-Datei abspeichern
write_xlsx(comments,"data/comments.xlsx")
