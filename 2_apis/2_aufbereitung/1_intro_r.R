#
# Intro R ----
#

library(tidyverse)

#
# Arbeiten mit Tibbles / Dataframes ----
#

alterdf <- tibble(
  id=c(1,2,3),
  likes=c(102,56,235),
  shares=c(35,76,3)
)


# Ohne Pipe
neuerdf <- filter (alterdf,likes > 100)

# Mit Pipe
neuerdf <- alterdf %>%
  filter (likes > 100)

#
# Arbeiten mit Listen ----
#

# Liste anlegen
suchergebnisse=list("102 Ergebnisse","56 Suchergebnisse","235 Suchergebnisse")

# Ein Element der Liste ausgeben
suchergebnisse[[1]] 

# Zahl aus erstem Listenelement rausholen mit regulärem Ausdruck
str_extract(suchergebnisse[[1]],"[0-9]+")

# Variante 1: Zahl aus allen Listenelementen rausholen
str_extract(suchergebnisse,"[0-9]+")

# Variante 2: Zahl aus allen Listenelementen rausholen mit map
map(suchergebnisse,str_extract,"[0-9]+")


