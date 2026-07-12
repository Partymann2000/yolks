#!/bin/bash
cd /home/container

# Falls der Ordner leer ist, klone das OpenWA Repository automatisch
if [ ! -d ".git" ]; then
    echo "--- OpenWA existiert noch nicht. Klone Repository... ---"
    git clone https://github.com/rmyndharis/OpenWA.git .
    echo "--- Installiere Node-Pakete... ---"
    npm install
fi

# Pterodactyl Startup-Variablen auflösen
MODIFIED_STARTUP=$(echo -e -n ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "--- Starte OpenWA WhatsApp API Gateway ---"

# Startet die Anwendung
eval ${MODIFIED_STARTUP}
