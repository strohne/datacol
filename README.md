# Workshop Data Collection

Dieses Repositorium enthält Übungsmaterialen zum Workshop. Zur Vorbereitung laden Sie sich bitte erstens das Repositorium herunter, indem Sie auf Code -> Download ZIP klicken. Und installieren Sie bitte folgende Software:

*Grundlagen*
- Die Browser Firefox und/oder Chrome
- Facepager: https://github.com/strohne/Facepager
- Einen Texteditor mit Syntaxhervorhebung, zum Beispiel Notepad++, Atom oder Textmate

*R*
- R: https://cran.r-project.org/
- RStudio Desktop: https://rstudio.com/products/rstudio/download/
- Installieren Sie in R / RStudio folgende Packages\
  tidyverse, writexl
  
 *RSelenium*
- Installieren Sie in R / RStudio das Package RSelenium
- Richten Sie mit folgenden R-Befehlen RSelenium ein: 
  ```
  library(Rselenium)
  selenium <- rsDriver(browser="chrome",port=4566L)
  selenium$server$stop()
  ```
Zum Nachvollziehen der Übungen benötigen Sie Accounts auf folgenden Plattformen:
- Facebook
- TikTok als App auf dem Smartphone (optional)

## Teil 1 - Grundlagen
- Überblick über Verfahren automatisierter Datenerhebung
- Grundlagen zu URLs

## Teil 2 - APIs
- Einführung in Application Programming Interfaces (APIs) und JSON
- Datenerhebung mit Facepager
- Exportieren der erhobenen Daten und Aufbereitung in R

## Teil 3 - Webscraping
- Einführung in HTML und CSS
- Klassisches Webscraping
- Browserautomatisierung mit Selenium
