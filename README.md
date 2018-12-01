# ff-lisberg-monitor
Dieses Repository enthält eine Dokumentation über Einsatz Monitor bei FF Lisberg und aller von uns gebauten Scripts.

Der Einsatz Monitor für unsere Feuerwehr zeigt in der Gerätehalle den aktuellen Einsatz an, sodass jeder Kamerad weiß wo er hin muss und was ihm am Einsatzort erwartet. Im folgenden ist zu lesen, wie wir das umgesetzt haben.

## Übersicht
Unsere Leitstelle Bamberg verschickt ein Einsatzfax, in dem alle relevanten und bekannten Daten für den Einsatz enthalten sind, zu jedem Einsatz an eine Telefonnummer. Eine Fritzbox verwaltet die Telefonnummer und empfängt auch das Fax. Das Fax werten wir maschinell aus und verwenden die Informationen für die Anzeige in der Gerätehalle. Zusätzlich wird das Fax automatisch gedruckt, sodass der Kommandant oder der Gruppenführer die Informationen gleich mit zum Einsatz nehmen kann.

![Übersichtsdiagramm](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.github.com/sladaloose/ff-lisberg-monitor/master/pictures/deployment-overview.iuml)
