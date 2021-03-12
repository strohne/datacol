# Datenerhebung mit Facepager

*Posts und Kommentare einer Facebook-Seite erheben.* 

1. Facepager öffnen 

2. Datenbank anlegen (```New Database```)

3. Modul auswählen (```Facebook```)

4. Knoten hinzufügen: Über ```Add Nodes``` Handle einer oder mehrerer Facebook-Seite hinzufügen (Der Teil hinter dem Basispfad http://www.facbeook.com/)

5. Preset laden: "2. Get Facebook posts" (unter ```Presets```-> **Facebook**)

6. Authentifizieren: Über ```Login to Facebook``` einloggen und durch Dialog gehen 

7. Einstellungen anpassen 
- Welche Einstellungen für eine Ressource möglich sind, kann man über die Dokumentation sehen. Die Dokumentation einer Ressource lässt sich über das ```?```neben der Zeile der Ressource öffnen (zunächst im API Viewer und von dort auch über die Verlinkung der Website). 
- Als Field ergänzen: Wie oft wurde ein Beitrag geteilt? 
- Als Field ergänzen: Welche Reaktionen hat ein Beitrag (siehe Beschreibung im Preset für die Werte)?
- Knoten auswählen und auf ```Fetch Data```klicken 

7. Daten inspizieren: Knoten ausklappen, Daten im Nodes View (links) und  Data View (rechts) durchsehen

8. Spalten anpassen (Über ```Add Column```oder ```Add All Columns```)

10. Daten Exportieren: 
- Alle Knoten auswählen
- ```Export Data```anklicken, Namen für die Datei eingeben und abspeichern

