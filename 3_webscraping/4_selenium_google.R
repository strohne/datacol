#
# Webscraping mit Selenium
#


#
# Packages laden ----
#

library(tidyverse)
library(RSelenium)


#
# Selenium starten ----
#


# Startet einen Selenium-Server und einen verbundenen Browser
# Beim ersten Aufruf werden alle benötigten Komponenten installiert (Geduld!)
# Fall der Port belegt ist, einen anderen Port verwenden (hochzählen)
# Der Port sollte am Ende mit server$stop() wieder freigegeben werden

#selenium <- rsDriver(browser="firefox",port=4567L)
selenium <- rsDriver(browser="chrome",port=4568L)

# Browser-API
browser <- selenium$client

# Befehle in der Hilfe nachschlagen:
?remoteDriver  # siehe Abschnitt "Methods"
?webElement    # siehe Abschnitt "Methods"


#
# Navigieren ----
#



browser$navigate("http://www.google.com")


# Suchbegriff eingeben
suchschlitz <-  browser$findElement(using = 'name', 'q')
suchschlitz$sendKeysToElement(list("Wie viele Nutzer hat "))

suchschlitz$sendKeysToElement(list(key='down_arrow'))

suchschlitz$submitElement()


# Anzahl der Suchergebnisse aus HTML-Element auslesen

# ÜBUNG:
# Wie funktioniert der RSelenium-Befehl, um ein Element per CSS-Selektor auszuwählen?
# (siehe die Hilfe von remoteDriver, Abschnitt Methods, Funktion findElement)
# Ergänzen Sie den CSS-Selektor, mit dem die Anzahl der Suchergebnisse ausgelesen wird!

ergebnisse <-  browser$findElement(using='WASMUSSHIERHIN','WASMUSSHIERHIN')
ergebnisse <- ergebnisse$getElementText()
ergebnisse

#
# Selenium beenden ----
#


# Browser wieder schließen
browser$close()

# Kann wieder geöffnet werden mit:
# browser$open()

# Selenium Server stoppen und Status ausgeben

selenium$server$stop()
selenium$server$process
