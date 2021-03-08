# Datenerhebung mit Facepager

*Posts und Kommentare einer Facebook-Seite erheben.* 

1. Facepager öffnen 

2. Datenbank anlegen (```New Database```)

3. Modul auswählen (```Facebook```)

4. Knoten hinzufügen: Über ```Add Nodes``` Handle einer oder mehrerer Facebook-Seite hinzufügen (Der Teil hinter dem Basispfad http://www.facbeook.com/)

5. Authentifizieren: Über ```Login to Facebook``` einloggen und durch Dialog gehen 

6. Letzte 20 Posts einer Seite erheben:
- Preset "2. Get Facebook posts" laden (Unter ```Presets```-> **Facebook**)
- Knoten auswählen und auf ```Fetch Data```klicken 


7. Daten inspizieren: Knoten ausklappen, Daten im Nodes View (links) und  Data View (rechts) durchsehen

8. Reaktion der Posts erheben und inspizieren: 
- Preset "Get reactions" laden 
- obersten Knoten (unter 4. hinzugefügt) anklicken, in den Einstellungen auswählen: ```Node level```: 2, ```Select all nodes```: [x]
- auf ```Fetch Data```klicken 
- Knoten ausklappen und Daten inspizieren 

9. Gegebenenfalls Spalten anpassen (Über ```Clear Columns```, ```Add Column```oder ```Add All Columns```)

10. Daten Exportieren: 
- Alle Knoten auswählen
- ```Export Data```anklicken, Namen für die Datei eingeben und abspeichern

