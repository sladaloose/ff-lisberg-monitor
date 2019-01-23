# ff-lisberg-monitor
Dieses Repository enthält eine Dokumentation über Einsatz Monitor bei FF Lisberg und aller von uns gebauten Scripts.

Der Einsatz Monitor für unsere Feuerwehr zeigt in der Gerätehalle den aktuellen Einsatz an, sodass jeder Kamerad weiß wo er hin muss und was ihm am Einsatzort erwartet. Im folgenden ist zu lesen, wie wir das umgesetzt haben.

![Anzeige](./pictures/Anzeige.jpg)

## Übersicht Einsatzablauf
Unsere Leitstelle Bamberg verschickt ein Einsatzfax, in dem alle relevanten und bekannten Daten für den Einsatz enthalten sind, zu jedem Einsatz an eine Telefonnummer. Eine Fritzbox verwaltet die Telefonnummer und empfängt auch das Fax. Das Fax werten wir maschinell aus und verwenden die Informationen für die Anzeige in der Gerätehalle. Zusätzlich wird das Fax automatisch gedruckt, sodass der Kommandant oder der Gruppenführer die Informationen gleich mit zum Einsatz nehmen kann.

### Beschreibung der Knoten

In diesem Kapitel befinden sich ein paar kurze Beschreibungen zur Hardwareausstattung.

![Deployment-Diagramm](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.github.com/sladaloose/ff-lisberg-monitor/master/pictures/deployment-overview.iuml)

![Hardware](./pictures/Equipment.jpg)

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

Folgende Software haben wir installiert:
- Windows 10
- Firefox
- Adobe Acrobat Reader
- EM_OCR
- Einsatz Monitor

![Mini-PC](./pictures/Mini-PC.jpg)

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

#### E-Mail-Server

Am E-Mail-Server gibt es im wesentlichen zwei wichtige Einstellungen. Das ist zum einen die E-Mail-Adresse selbst und zum anderen geeignete Filtereinstellungen, sodass nur tatsächliche Einsatzmeldungen verarbeitet werden.

Die E-Mail-Adresse selbst ist mit einem modernen Provider sehr schnell erledigt. Dafür gibt es Konfigurationsmasken und es nicht nötig Konfigurationsdatien zu editieren. Wichtig ist hier nur ein ausreichend sicheres Passwort zu verwenden - unseres hat eine Qualität von 155 Bit, was einer Länge von 28 Zeichen entspricht.

Da prinzipiell jeder eine E-Mail an diese Adresse schicken kann und wir ja nur wollen, dass eine Einsatzmeldung nur bei einem echten Einsatz erfolgt, brauchen wir noch geeignete Filterregeln. Das heißt, dass eine eingehend E-Mail geprüft wird und wenn diese nicht die von uns definierten Merkmale erfüllt, wird sie sofort gelöscht. Damit unser Schutz nicht umgangen werden kann, geben wir hier nur so viel Preis: Es ist ein Geheimnis, das unsere Fritz.Box beim Versand der E-Mail mit hinterlegt gegen das wir serverseitig prüfen.  

#### Thunderbird

Am Mini PC verwenden wir das Proramm "Thunderbird" zum E-Mail Empfang. Das Programm ist etabliert, gilt im allgemeinen als stabil und holt regelmäßig neue E-Mails vom Server ab. Es hat den Nachteil, dass es für den Zweck (E-Mail-Empfang und extrahieren der PDF-Anlage) relativ viel Hauptspeicher benötigt. Es kann gut sein, dass wir den Thunderbird mittelfristig mit einem Script ersetzen, das die gleiche Aufgabe erfüllt - das Script müsste jedoch regelmäßig getriggert werden.

Am Thunderbird ist als Konfiguration der E-Mail-Account hinterlegt, den wir vorher angelegt haben. Nun müssen wir noch eine Regel (in Thunderbird heißt das "Filter") definieren, die automatisch den PDF-Anhang eingehender E-Mails in einen Ordner auf der Festplatte extrahiert. Leider beherrscht das der Thunderbird standardmäßig nicht. Mit der Extension "FiltaQuilla" kann so eine Regel allerdings angelegt werden.

![Thunderbird Filter PDF Extrakt](pictures/thunderbird-filter-screenshot.png)

Es gibt ein Problem mit Thunderbird, wenn der Rechner in der Nacht automatisch neu gestartet wird. Wir müssen sicher stellen, dass auch der Thunderbird gestartet wird, sonst werden ja keine E-Mails empfangen. Leider ist es so, dass sich das Programm in den Vordergrund legt. Das heißt im Falle eines Einsatzes sehen wir das Thunderbird Programm anstelle der Information wo wir tatsächlich hin fahren müssen. Um das zu umgehen, müssen wir noch die Extension "MinimizeToTray revived" installieren. Diese Extension legt Thunderbird in den SystemTray (die Symbole unten rechts neben der Uhr), wenn die Applikation minimiert ist.

Damit der Thunderbird tatsächlich automatisch nach Windows Neustart minimiert gestartet wird, brauchen wir noch ein kleines Script, das den Thunderbird minimiert. Das Script (PowerShell) startet Thunderbird, wartet 15 Sekunden und führt dann über die Windows-API die Minimieren Funktion des Fensters aus.
Script: [Script](./thunderbird/tb-start.ps1)

Ein PowerShell script lässt sich schwierig über den Windows Autostart starten. Daher ist im Autostart eine Verknüpfung zu einer normalen Batch-Datei hinterlegt und die Batch-Datei startet das PowerShell Script.
Batch-Datei: [Batch-Datei]/./thunderbird/tb-start.bat)

#### EM_OCR

Wir verwenden die Software EM OCR von Stefan Seider um das ankommende Fax zu analysieren und auszuwerten. Das ließe sich zwar auch ohne machen, ist allerdings in Zusammenarbeit von ghostscript, tesseract und Einsatz Monitor eher sperrig und fehleranfällig. EM OCR leistet hier eine sehr gute Unterstützung.

Neben EM OCR müssen auch noch die Software-Pakete tesseract und ghostscript installiert werden. Ghostscript verwandelt die PDF Datei in eine TIF Datei, die von tesseract weiter verarbeitet werden kann. Tesseract sucht in der TIF Datei nach Text und versucht diesen auszuwerten. Um seine Arbeit hier in Bezug auf den Einsatzfaxen bestens anwenden zu können, ist es nötig die Datei "alarm.traineddata" bereit zu stellen.

Link zu EM OCR: https://feuersoftware.com/forum/index.php?thread/2125-em-ocr-einsatzmonitor-pdf-tiff-txt-fax-konverter-mit-ordner%C3%BCberwachung/

Folgende Einstellungen haben wir im EM OCR vorgenommen:
- "Eingangs-Ordner": Zeigt auf den Ordner, in den der Thunderbird die PDF-Anhänge eingehender E-Mails extrahiert
- "Ausgabe-Ordner": Zeigt auf den Ordner, den der Einsatz Monitor als "Input Ordner" benutzt. Das ist üblicherweise C:\Users\<Profil>\Einsatz_Monitor\Text_Input
- "Archiv-Ordner": In diesem Ordner legt EM OCR die PDF-Dateien ab, die bereits bearbeitet wurden. Dabei bekommen die Dateien einen neuen Dateinamen, der das aktuelle Datum und die aktuelle Uhrzeit enthält
- "Tesseract-Pfad": Hier muss die tesseract.exe aus der tesseract Installation angegeben werden
- "GhostScript-Pfad": Hier muss die ghostscript.exe aus der ghostscript Installation angegeben werden (heißt überlichweise gswin64c.exe)
- "GS / Tesseract Einstellungen": Hier verwenden wir die Standardeinstellungen
- "Druckeinstellungen": Hier legen wir fest, dass auf unserem angeschlossenen Drucker der Einsatz auch ausgedruckt wird
- "EM-OCR mit Windows starten": Der Haken ist bei uns gesetzt, damit auch EM OCR nach jedem Neustart des Rechners wieder automatisch zur Verfügung steht
- "Service starten bei Programmstart": Starten von EM OCR alleine reicht nicht aus; der Service muss aktiv sein, damit der Eingangs-Ordner tatsächlich überwacht wird
- "Minimiert starten": Natürlich starten wir auch minimiert, damit sich der EM OCR nicht über den Einsatz Monitor legt
- "AutoParser Einstellungen": Hier definieren wir, welche Felder aus dem Einsatzfax ausgewertet werden und welchen Namen die Werte für die Auswertung im Einsatz Monitor bekommen*
    - Straße -> Straße
    - Abschnitt -> Ortsteil
    - Ort -> Ort
    - Objekt -> Objekt
    - Schlagwort -> Sachverhalt
    - Einsatznummer -> Einsatznummer
    - Prio -> Zusatzinformation1
    - --> Jeweils ist der Haken bei "n/A" gesetzt, da es sein kann, dass die Leitstelle gewissen Informationen nicht immer überträgt

*) Faktisch erstellt EM OCR eine Textdatei aus dem PDF und diese Textdatei wird dem Einsatz Monitor zur Verfügung gestellt. Der Einsatz Monitor muss freilich diese Datei erneut auswerten.

#### Einsatz Monitor

Als Anzeige Software eines Einsatzes verwenden wir den Einsatz Monitor von der Feuer Software GmbH (https://feuersoftware.com/forum/wcf/index.php?einsatzmonitor/). Diese Software wird dankenswerterweise von der Firma kostenfrei zur Verfügung gestellt.

Nach der Installation haben wir folgende Konfiguration am Einsatz Monitor vorgenommen:
- Auswertung
    - Bei der "Auswertung" haben wir die "File Überwachung" aktiviert
    - Als Pattern haben wir ein neues angelegt, mit folgendem Inhalt: [Einsatz Monitor Pattern](./Einsatz_Monitor_Pattern_ILS_Bamberg.txt)
- Einstellungen
    - Kategorie "Einsatz": Hier nehmen wir die Standardeinstellungen und lassen die Anzeige nach 45 Minuten zurück setzen
    - Kategorie "Hintergrund": Als Hintergrundbild haben wir ein Bild unseres FF Hauses eingerichtet
    - Kategorie "Karten":
        - Provider: Open Street Map
        - Marker: Rot
        - Zoom: 15
        - Breite: 31%
        - Routenanzeige: ON
        - Helikoptermodus: OFF
        - Hydranten anzeigen: OFF
    - Kategorie "Organisation": Hier haben wir die "FF Lisberg" und die Adresse eingetragen

Zu guter letzt ist natürlich auch der Einsatz Monitor in der Autostart Gruppe von Windows hinterlegt, damit die Software nach jedem Rechnerneustart automatisch startet.

### Beschreibung der Schritte

![Ablaufdiagramm](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.github.com/sladaloose/ff-lisberg-monitor/master/pictures/sequence-diagram.iuml)

1. Fax wird von Leitstelle an unsere Faxnummer geschickt. Das Fax wird von der Fritzbox in Empfang genommen.
1. Das Fax wird von der Fritzbox in ein PDF konvertiert an eine E-Mail angehängt und diese an die hinterlegte E-Mail Adresse verschickt.
1. Auf Serverseite prüfen wir, ob die E-Mail valide ist - wir wollen nicht, dass jede x-beliebige Mail eine Einsatzmeldung auslöst, sondern nur wenn tatsächlich ein Einsatz ist.
1. Ist die Prüfung fehlgeschlagen, wird die E-Mail gelöscht - so haben unerwünschte E-Mails keine Chance.
1. Auf dem Mini-PC prüft der E-Mail Client in regelmäßigen Abständen, ob es neue E-Mails gibt
1. Gibt es neue, noch nicht abgerufene E-Mails, werden diese an den E-Mail Client geschickt
1. Der E-Mail-Client extrahiert (wie oben beschrieben) das PDF aus der E-Mail und legt es in einen definierten Ordner "EM_INPUT" auf der lokalen Festplatte ab.
1. Das Programm EM_OCR prüft regelmäßig auf neue Dateien in dem Ordner "EM_INPUT".
1. Gibt es eine neue Datei, so wird die Verarbeitung im EM_OCR angestoßen.
1. Zuerst wird das PDF in eine Textdatei konvertiert; zuerst mit Ghostscript in ein TIF, dann mit Tesseract in eine Textdatei (das erleichtert die weitere Verarbeitung).
1. Danach wird die Textdatei ausgewertet in dem Schlüsselwörter (siehe oben) gesucht werden.
1. Mit der Ergebnismenge wird eine neue Textdatei erzeugt, die nun die Software "Einsatz Monitor" in der Lage ist einfach auszuwerten.
1. Die Datei für den "Einsatz Monitor" wird in den Ordner "Text_Input" auf der lokalen Festplatte kopiert.
1. EM_OCR stößt außerdem einen Druck der originalen PDF-Datei an - damit haben wir die Einsatzmeldung auch ausgedruckt im Einsatz dabei.
1. Das original PDF wird von EM_OCR auf der lokalen Festplatte archiviert.
1. Die Software "Einsatz Monitor" prüft ebenfalls in regelmäßigen Abständen auf eine neue Datei im Ordner "Text_Input" (das heißt im Umkehrschluss, dass die Schritte 14 und 15 auch parallel zu 16 ablaufen können).
1. Ist eine neue Datei vorhanden, legt die Software "Einsatz Monitor" los.
1. Im "Einsatz Monitor" wird die Textdatei anhand des hinterlegten Patterns ausgewertet.
1. Nun steht fest, wo der Einsatz stattfindet und die Anzeige am Monitor/TV wird umgeschalten.
1. Im "Einsatz Monitor" kann hinterlegt werden welche Aktionen bei einem Einsatz ablaufen sollen. Hier nutzen wir neben den Standardeinstellungen lediglich die Option einen Script aufzurufen. Das Script (siehe [printscript.bat](./scripts/printscript.bat) und das Kapitel [Printscript](#Printscript) unten) druckt eine vorbereitete Datei, das Einsatzprotokoll.
1. Etwa 45 Minuten später wird die Einsatzanzeige automatisch zurück gesetzt.

## Printscript

Das Script öffnet den Adobe Acrobat Reader (dieser muss wie oben beschrieben natürlich installiert sein) mit Kommandozeile und übergibt das zu druckende PDF und stößt den Druckbefehl an.

Bevor das Printscript tatsächlich eingesetzt werden kann, müssen folgende Variablen im Script ersetzt werden. Bitte unbedingt die Klammern <> mit ersetzen!

Die Variablen sind mit folgenden Werten zu ersetzen:
- PATH_TO_ACRORD32EXE = Pfad zur Datei ``AcroRd32.exe``; liegt typischerweise im Ordner ``C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\``.
- NAME_OF_PDF_FILE = Name der Datei, die gedruckt werden soll. Die Datei muss im selben Verzeichnis liegen, wie das Script.
- NAME_OF_PRINTER = Name des Druckers, wie in der Systemsteuerung sichtbar.

## Neustart um 4 Uhr

Wir haben die Erfahrung gemacht, dass sich der Einsatz Monitor nach einiger Zeit aufhängt und vermuten einen Memory Leak. Außerdem benötigt Windows selbst öfter mal einen Neustart um aktuelle Updates einzuspielen. Damit wir ein funktionierendes System haben, starten wir es täglich um 4 Uhr neu.

Dazu verwenden wir den Windows Task Scheduler (Deutsch: "Aufgabenplanung"). Hier haben wir einen Task eingerichtet, der täglich um 4 Uhr ausgeführt wird. Der Task ruft eine Batch-Datei auf die einen Reboot ansteuert.
Batch Datei: [Batch Datei](./reboot/restart.bat)

## Schaltung für Monitor

Damit der Monitor nicht dauerhaft an ist und entsprechend Strom verbraucht, schalten wir ihn nur auf Bedarf ein. Geplant ist, dass wir eine Schaltung haben,die den Monitor automatisch anschaltet, sobald sich das Tor zur Gerätehalle öffnet (wird automatisch ausgelöst, wenn die Sirene getriggert wird). Aktuell verwenden wir noch einen Kippschalter, den ein Kamerad kurz betätigen muss.

![Kippschalter für Monitor](./pictures/Stromschaltung.jpg)