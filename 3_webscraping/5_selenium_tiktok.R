#
# Webscraping mit Selenium
#


#
# Packages laden ----
#

library(tidyverse)
library(writexl)
library(RSelenium)


#
# Selenium starten ----
#


#selenium <- rsDriver(browser="firefox",port=4569L)
selenium <- rsDriver(browser="chrome",port=4570L)
browser <- selenium$client

#
# Navigieren ----
#



# 1. TikTok öffnen
# 2. Mit QR-Code auf dem Handy anmelden
browser$navigate("http://www.tiktok.com")


browser$navigate("https://www.tiktok.com/@sarahnewsfx/video/6930590200380820742")

# Engagment Icons finden
el_engagement <-  browser$findElements(
  using = 'css', 
  'div.pc-action-bar div.bar-item-wrapper'
)

# Zweites Icon klicken
el_engagement[[2]]$clickElement()

# ÜBUNG
# Wie lautet der RSelenium-Befehl, um den Quelltext
# einer Seite auszulesen? (siehe die Hilfe von remoteDriver, 
# Abschnitt Methods, Stichwort "Source")


# HTML auslesen
html_source <- browser$WASMUSSHIERHIN()


#
# Comments ----
#


# List of comments
html_parsed <- read_html(html_source[[1]])

html_comments <- html_parsed %>% 
  html_nodes(".comment-content") 

# Tibble anlegen
data <- tibble(no=1:length(html_comments))

# Felder füllen
data$time <- html_comments %>% 
  html_node('span.comment-time') %>%   
  html_text(trim=TRUE)

data$user <- html_comments %>% 
  html_node('span.username') %>%   
  html_text(trim=TRUE)

# ÜBUNG
# Ergänzen Sie eine Spalte mit dem Text 
# des Kommentars!

data$likes <- html_comments %>% 
  html_node('.like-container') %>%   
  html_text(trim=TRUE)
  
data$identity <- html_comments %>% 
  html_node('span.identity') %>%   
  html_text(trim=TRUE)

#
# Abspeichern ----
#

# ÜBUNG
# Speichern Sie das Ergebnis als Exceltabelle ab!

#
# Selenium beenden ----
#


browser$close()
selenium$server$stop()

