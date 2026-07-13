FROM        --platform=$TARGETPLATFORM node:24-bookworm-slim

LABEL       author="Pterodactyl Image Maker" maintainer="partymann2000"

# Installiert System-Abhängigkeiten für Headless-Chromium (analog zu Playwright/Puppeteer)
RUN         apt-get update \
            && apt-get -y install --no-install-recommends \
                curl \
                ca-certificates \
                ffmpeg \
                git \
                python3 \
                build-essential \
                chromium \
                fonts-ipafont-gothic \
                fonts-wqy-zenhei \
                fonts-thai-tlwg \
                fonts-kacst \
                fonts-freefont-ttf \
                libxss1 \
            && rm -rf /var/lib/apt/lists/* \
            && useradd -m -d /home/container container

# Zwingt Puppeteer/OpenWA, das installierte System-Chromium zu nutzen
ENV         PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV         CHROME_PATH=/usr/bin/chromium
ENV         PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
