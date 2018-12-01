# ff-lisberg-monitor
Dieses Repository enthält eine Dokumentation über Einsatz Monitor bei FF Lisberg und aller von uns gebauten Scripts.

Der Einsatz Monitor für unsere Feuerwehr zeigt in der Gerätehalle den aktuellen Einsatz an, sodass jeder Kamerad weiß wo er hin muss und was ihm am Einsatzort erwartet. Im folgenden ist zu lesen, wie wir das umgesetzt haben.

## Übersicht Einsatzablauf
Unsere Leitstelle Bamberg verschickt ein Einsatzfax, in dem alle relevanten und bekannten Daten für den Einsatz enthalten sind, zu jedem Einsatz an eine Telefonnummer. Eine Fritzbox verwaltet die Telefonnummer und empfängt auch das Fax. Das Fax werten wir maschinell aus und verwenden die Informationen für die Anzeige in der Gerätehalle. Zusätzlich wird das Fax automatisch gedruckt, sodass der Kommandant oder der Gruppenführer die Informationen gleich mit zum Einsatz nehmen kann.

![Deployment-Diagramm](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.github.com/sladaloose/ff-lisberg-monitor/master/pictures/deployment-overview.iuml)

![Ablaufdiagramm](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.github.com/sladaloose/ff-lisberg-monitor/master/pictures/sequence-diagram.iuml)

### Beschreibung der Knoten

#### Fritz.Box

#### Mini PC

#### Bildschirm

#### Drucker

#### E-Mail-Server

### Konfiguration der Programme

#### Fritz.Box

#### Mail-Server

#### Thunderbird

#### EM_OCR

#### Einsatz Monitor

### Beschreibung der Schritte

#### 1 - Fax von Leitstelle

#### 2 - Mail mit PDF

#### 3 - Prüfung auf validem Absender

#### 4 - Lösche Mail bei fehlgeschlagener Prüfung

#### 5/6 - Prüfe auf neue Mails

#### 7 - Extrahiere PDF

#### 8/9 - Prüfe auf neue PDF

#### 10 - Konvertiere PDF in Textdatei

#### 11 - Werte Textdatei aus

#### 12 - Erstelle Datei für Einsatz Monitor

#### 13 - Kopiere Datei für Einsatz Monitor

#### 14 - Drucke Einsatz PDF

#### 15 - Verschiebe PDF in Archiv

#### 16/17 - Prüfe auf neue Datei

#### 18 - Auswertung Textdatei

#### 19 - Anzeige Einsatz

#### 20 - Drucke Einsatzbericht Vorlage

#### 21 - Setze Anzeige zurück

## Neustart um 4 Uhr
- Vorbeugung Memory Leak
- Updates Einsatz Monitor
- Startreihenfolge
- Thunderbird minimieren

## Schaltung für Monitor
- Wenn Einsatz fährt Tor automatisch hoch
- Monitor bekommt Strom (aktuell noch über manuellem Kippschalter)