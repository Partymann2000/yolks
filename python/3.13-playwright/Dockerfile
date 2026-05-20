FROM        --platform=$TARGETOS/$TARGETARCH python:3.13-slim-bookworm

LABEL       author="Chriss Quartz" maintainer="quartz@chrissquartz.xyz"

# 1. System-Abhängigkeiten als Root installieren und den Pterodactyl-User anlegen
RUN         apt-get update && apt-get install -y --no-install-recommends \
                git gcc g++ ca-certificates dnsutils curl iproute2 ffmpeg procps tini \
            && useradd -m -d /home/container container \
            && rm -rf /var/lib/apt/lists/*

# 2. Pip und Playwright-Paket noch als Root installieren (Systemweit im Container)
RUN         pip install --no-cache-dir --upgrade pip setuptools wheel && \
            pip install --no-cache-dir playwright==1.59.0

# 3. JETZT ZUM CONTAINER-USER WECHSELN
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

# 4. Die Browser direkt als Benutzer 'container' installieren!
# Dadurch landen sie automatisch in /home/container/.cache/ms-playwright
RUN         playwright install

STOPSIGNAL  SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
