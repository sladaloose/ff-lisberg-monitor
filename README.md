# ff-lisberg-monitor
Dieses Repository enthält eine Dokumentation über Einsatz Monitor bei FF Lisberg und aller von uns gebauten Scripts.

Der Einsatz Monitor für unsere Feuerwehr zeigt in der Gerätehalle den aktuellen Einsatz an, sodass jeder Kamerad weiß wo er hin muss und was ihm am Einsatzort erwartet. Im folgenden ist zu lesen, wie wir das umgesetzt haben.

## Übersicht Einsatzablauf
Unsere Leitstelle Bamberg verschickt ein Einsatzfax, in dem alle relevanten und bekannten Daten für den Einsatz enthalten sind, zu jedem Einsatz an eine Telefonnummer. Eine Fritzbox verwaltet die Telefonnummer und empfängt auch das Fax. Das Fax werten wir maschinell aus und verwenden die Informationen für die Anzeige in der Gerätehalle. Zusätzlich wird das Fax automatisch gedruckt, sodass der Kommandant oder der Gruppenführer die Informationen gleich mit zum Einsatz nehmen kann.

![Deployment-Diagramm](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.github.com/sladaloose/ff-lisberg-monitor/master/pictures/deployment-overview.iuml)

![Ablaufdiagramm](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.github.com/sladaloose/ff-lisberg-monitor/master/pictures/sequence-diagram.iuml)

### Beschreibung der Knoten

In diesem Kapitel befinden sich ein paar kurze Beschreibungen zur Hardwareausstattung.

#### Fritz.Box

Der aktuelle Internet-Router ist eine **Fritz.Box 7390**. Diese stellt via VDSL einen Zugang zum Internet her, spannt ein WLAN-Netzwerk für das Feuerwehrhaus auf und kümmert sich um den Faxempfang von der Leitstelle.

#### Mini PC

Der "Mini PC" ist ein handelsüblicher PC mit einem Windows 10. Windows haben wir deshalb gewählt, weil das für die Software "Einsatz Monitor" erforderlich ist. Der "Mini PC" ist deshalb "Mini", weil er wirklich sehr kompakt ist und auch entsprechend stromsparend arbeiten kann - immerhin läuft dieser Rechner 24/7.

Die Hardware-Eigenschaften des Rechners sind:
- Intel Atom CPU D2550 @ 1,86 GHz
- 4 GB RAM
- 465 GB HDD
- Grafikkarte AMD Radeon HD 6430M
- WLAN via USB-Adapter

#### Bildschirm

Als Bildschirm verwenden wir einen handelsüblichen Flachbildfernseher mit HDMI-Eingang. Dieser ist mit einer Wandhalterung auf etwa 3 Metern Höhe befestigt.

Damit der Bildschirm nicht 24/7 laufen muss, haben sich unsere findigen Kameraden eine Schaltung einfallen lassen, sodass der Monitor nur bei einem Einsatz oder nach manueller Schaltung aktiv ist. Siehe auch Kapitel [Schaltung für Monitor](#schaltung-für-monitor).

#### Drucker

Der Drucker ist ein **HP Laserjet 1022**. Ein Laserdrucker deshalb, weil diese Art von Drucker im Vergleich zu Tintendruckern sehr langlebig sind und es keine Gefahr gibt, dass Tintenpatronen eintrocknen. Zudem ist der Ausdruck wasserfest - da wir den Einsatzbefehl drucken und mitnehmen, ist das natürlich ein Vorteil.

#### E-Mail-Server

Der E-Mail-Server ist angemietet über den Provider der Domain **ff-lisberg.de**. Ein E-Mail-Server ist überhaupt erst notwendig, da wir das Fax von der Leitstelle via der Fritz-Box an eine E-Mail-Adresse schicken und von dort die Verteilung des Einsatzberichts an den Einsatz Monitor vornehmen, sowie eine Weiterleitung an den 1. und 2. Kommandanten (als Backup).

Damit das sicher ist, verwenden wir hier nur E-Mail-Adressen der **ff-lisberg.de** Domain, verwenden hinreichend sichere Passwörter und übertragen Daten nur verschlüsselt.

### Konfiguration der Programme

In diesem Kapitel ist beschrieben, wie die einzelnen Knoten bzw. Programme konfiguriert sind. Dabei wird nicht immer die exakte Konfiguration angegeben, sondern nur angedeutet. Zum einen gibt es Einstellungen, die bei jeder Installation angepasst werden müssen und zum anderen sind die Einstellungen sicherheitsrelevant (bspw. Passwörter).

#### Fritz.Box

Die Fritz.Box baut einen Internetzugang auf und hält diesen offen. Es erfolgt Nachts zwischen 2 und 5 Uhr einen Zwangstrennung des Providers, zu der wir für einen kurzem Zeitraum offline sind und keine Faxe empfangen können.

Als Netzwerkverbindung zwischen Fritz.Box (steht im Schulungsraum) und der Gerätehalle verwenden wir die WLAN-Schnittstelle. Das WLAN muss auf halbem Wege mittels eines Repeaters verstärkt werden.

Die Telefoniefunktion der Fritz.Box ist so konfiguriert, dass Faxe empfangen werden können. Eingehende Faxe werden als E-Mail (mit dem Fax als PDF-Anhang) verschlüsselt an eine E-Mail-Adresse der Domain **ff-lisberg.de** versendet.

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