WSL_LANG_NAME="Deutsch"

WSL_WELCOME="Willkommen!
Dieses Skript richtet das \"Windows Subsystem for Linux\" (WSL) ein.
Zusätzlich werden information zu den einzelnen Schritten des Setups eingeblendet.
Im Wiki des Github Repositories sind weiterführende Information zu den Setup-Schritten \
zu finden."

WSL_INFO="Das WSL ist keine virtuelle Maschine(VM). Daher kann es sein, \
dass nicht alle Programme und Befehle wie gewohnt funktionieren.
Nach meine bisherigen Erfahrung funktionieren aber alle gängigen Programme problemlos."

WSL_SYS_UPGRADE="Es werden die neuesten Updates für dein System installiert.
In Ubuntu werden dafür die folgende Befehle verwende:
    sudo apt update
    sudo apt full-upgrade
sudo bedeutet so viel wie als Administrator ausführen, weshalb du im folgenden nach deinem \
Passwort gefragt wirst."

WSL_SYS_UPGRADE_FINISHED="Dein System ist jetzt auf dem aktuellsten Stand."

WSL_NO_ADMIN="Für die Installation des WSL werden Windows-Admin-Rechte benötigt. \
Bitte beende Ubuntu und starte es erneut als Administrator!"

WSL_INSTALL_XMING="Jetzt wird XMing installiert. XMing ist ein sog. XServer, der benötigt wird um grafische \
Oberflächen von Programmen anzuzeigen. Der Server wird unter Windows installiert und nicht im WSL, \
da sich Windows für die Darstellung der Fenster zuständig ist. Daher auch ein entsprechendes Symbol \
unten rechts im Infobereich angezeigt, wenn der Server aktiv ist."

WSL_INSTALL_XMING_FONT="Damit der XServer die Schrift richtig darstellen kann, müssen einige Standardschriftarten \
installiert werden."

WSL_CREATE_SCALEABLE_FONT="Da die Standardschriftarten nur eine sehr schlechte Darstellung bieten, \
werden jetzt zusätzlich die Windows schriftarten für den XServer verfügbar gemacht. Dafür werden die \
beiden Dateien fonts.dir und fonts.scale im Verzeichnis C:\\\\Windows\\Fonts erzeugt. Diese Dateien \
sind für Windows völlig unproblematisch."

WSL_INSTALL_CONFIG="Jetzt werden die standard Konfigurationsdateien installiert: \n\
  .xinitrc: Konfigurationsdatei, die beim Start des XServers eingelesen wird. \
In dieser wird z.B. festgelegt, welche Programm zu Beginn gestartet werden sollen. \n\
  .profile: Konfigurationsdatei, die beim Login des Benutzers eingelesen wird. \
Typischer weise werden in dieser Umgebungsvariablen gesetzt. Diese sind z.B. dafür notwendig, \
damit das ausführbare Programme findet, die nicht in einem der Standardverzeichnisse installiert \
sind. \n\
  .startXming.sh: Ein Script, dass automatisch XMing startet, wenn Ubuntu gestartet wird." 

WSL_INSTALL_TERMINATOR="Der Windowseigene Terminalemulator(Kommandozeile) für Ubuntu ist für ein wirkliches Arbeiten \
damit nicht geeignet. Daher wird nur Terminator installiert. Dabei handelt es sich um Terminalemulator, \
mit dem der Bildschrim in mehrere Terminals geteilt werden kann und mehrer Tabs mit verschiedenen Layouts \
angelegt werden können. Das Layout kann jederzeit per Drag & Drop sowie einer vielzahl von Kurzbefehlen \
verändert werden. Die kurz Befehle lassen sich wie bei fasst jeden Linux befehlt mit dem man Befehl erfragen (man termiantor)."

WSL_INSTALL_TERMINATOR_FAILED="Die Installation von Terminator ist fehlgeschlagen!"

WSL_SUCCESSFULL="Die Einrichtung des WSL war erfolgreich."

WSL_SCALEABLE_FAILED="Das indizieren der Windows Schriftarten ist fehlgeschlagen!"

WSL_DIALOG="Es wird geprüft ob das Paket \"dialog\" verfügbar ist. \
Diese Paket wird benötigt um die Dialoge dieses Skripts \"schön\" darzustellen."

WSL_META="Im Verzeichnis /mnt wird dein Windows C Laufwerk eingebunden. Dadurch kannst du \
im WSL mit deinen Windows Dateien arbeiten. Führst du das WSL nicht als Administrator aus, \
so hast du nur in deinem Persönlichen Ordner unter C:\\\\Users\\<dein Nutzername> Schreibrechte. \
Damit du die Zugriffsrechte für deine Windowsdateien auch im WSL bearbeiten kannst, werden nun die \
Metadaten für diese Dateien aktiviert. Dadurch wird ein gewisses Zussamenspiel zwischen den WSL- und \
Windows-Zugriffsrechten ermöglicht. Mehr Informtionen findest du im Abschnitt Links."

WSL_META_FAILED="FEHLER! Die Metadaten konnten nicht aktiviert werden.
Schließe alle offenen WSL Fenster, beende XMing und starte das Setup erneut."
