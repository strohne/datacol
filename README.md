# Workshop Data Collection

Dieses Repositorium enthält Übungsmaterialen zum Workshop. Zur Vorbereitung laden Sie sich bitte erstens das Repositorium herunter, indem Sie auf Code -> Download ZIP klicken.
Installieren Sie bitte folgende Software:

*Grundlagen*
- Die Browser Firefox und/oder Chrome
- Einen Texteditor mit Syntaxhervorhebung, zum Beispiel Notepad++, Atom oder Textmate
- Facepager: https://github.com/strohne/Facepager

*R und RSelenium*
- R: https://cran.r-project.org/
- RStudio Desktop: https://rstudio.com/products/rstudio/download/
- Installieren Sie in R / RStudio folgende Packages\
  tidyverse, rvest, httr, xml2, readxl, writexl
- Installieren Sie in R / RStudio das Package RSelenium
- Richten Sie mit folgenden R-Befehlen RSelenium ein: 
  ```
  library(Rselenium)
  selenium <- rsDriver(browser="chrome",port=4566L)
  selenium$server$stop()
  ```


## Teil 1 - Grundlagen
to be added

## Teil 2 - APIs
to be added

## Teil 3 - Webscraping
to be added

