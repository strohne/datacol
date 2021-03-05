#
# Klassisches Webscraping mit Rvest
#

#
# Libraries 
#

# Installieren 
#install.packages("rvest")
#install.packages("httr")
#install.packages("tidyverse")
#install.packages("xml2)


# Laden
library(tidyverse)
library(httr)
library(rvest)
library(xml2)
library(writexl)


#
# Seite herunterladen
#

# Seite herunterladen und parsen
url <- "https://www.zeit.de/suche/index?q=corona"
url <- "https://www.zeit.de/gesellschaft/2021-02/corona-massnahmen-lockerungen-lockdown-ausgangsbeschraenkung-sport-gastronomie-ueberblick?page=3#comments"
html <- read_html(url)
html

# Das geparste Dokument kann bei Bedarf abgespeichert werden
write_xml(html, file="article_n.html")

# Alternative:
# - Webseite  mit GET-Funktion aus dem httr packager herunterladen
# - Inhalt in HTML-Datei abspeichern
# - Datei mit rvest einlesen
httr::set_config(httr::user_agent("MyAcademicSuperInsightsApp/0.1 by CaptainX"))
httr::set_config(httr::user_agent("MyAcademicSuperInsightsApp/0.1 by CaptainX"))

response <- GET(url)
response

cat(content(response, "text"), file="article_n.html")
html <- read_html("article_n.html")


# Mithilfe von CSS die Artikel herausholen
# mit der ID "a-z-liste" und darin alle li-Elemente finden
html_articles <- html %>% html_nodes("article")
html_articles


# Leerer Vektor zum Sammeln der Daten
articles <- c()


# Alle Elemente abarbeiten
for (item in html_articles) {
  
  # Extrahieren
  teaser <- html_node(item,"span.zon-teaser-standard__kicker") %>% html_text(trim=T)
  title <- html_node(item,"span.zon-teaser-standard__title") %>% html_text(trim=T)
  text <- html_node(item,"p.zon-teaser-standard__text") %>% html_text(trim=T)
  datum <- html_node(item,"time.zon-teaser-standard__datetime") %>% html_attr("datetime")
  xmlurl <- html_attr(item,"data-unique-id")
  
  # In tibble ablegen
  newdata <- tibble(
    'teaser'=teaser,
    'title'=title,
    'text'=text,
    'datum'=datum,
    'xmlurl'=xmlurl
  )
  
  # Tibble zum Vektor hinzufügen
  articles <-  c(articles,list(newdata))
  
}

rm(item,newdata, datum,teaser,text,title,url)


# Die Liste mit allen Tibbles zu einem 
# einzigen Tibble verbinden
articles <- bind_rows(articles)


# Ergebnis als Excel-Datei abspeichern
write_xlsx(articles,"articles_n.xlsx")
