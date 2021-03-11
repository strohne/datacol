## Auflösungen der Übungen zur Datenerhebung mit Facepager


# 1. Über welchen Parameter werden Kommentare chronologisch sortiert?
filter = stream
--> Der Parameter "filter" mit dem Wert "stream". 
(Siehe: https://developers.facebook.com/docs/graph-api/reference/v3.2/object/comments)

# 2. Welche Felder (fields, unter Parameters) müssen angepasst werden, damit wir Reaktionen bekommen?
(Tipp: Sind im Preset "Get Reactions" aufgelistet)
 
comments.limit(0).summary(1),
shares, reactions.limit(0).summary(1),
reactions.type(LIKE).limit(0).summary(1).as(like),
reactions.type(LOVE).limit(0).summary(1).as(love),
reactions.type(HAHA).limit(0).summary(1).as(haha),
reactions.type(WOW).limit(0).summary(1).as(wow),
reactions.type(SAD).limit(0).summary(1).as(sad),
reactions.type(ANGRY).limit(0).summary(1).as(angry)


# 3. Wie lauten die Spalten, über die wir die Reaktionen angezeigt bekommen (ergänzen im Column-Setup und "Apply Column Setup" klicken)?
(Tipp: aus dem Column-Setup mit den Key-Value-Paaren auslesen oder 
sind im Preset "Get Reactions" aufgelistet) 

reactions.summary.total_count
like.summary.total_count
love.summary.total_count
wow.summary.total_count
haha.summary.total_count
sad.summary.total_count
angry.summary.total_count