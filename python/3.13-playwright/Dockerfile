FROM        --platform=$TARGETOS/$TARGETARCH python:3.13-slim-bookworm
LABEL       author="Chriss Quartz" maintainer="quartz@chrissquartz.xyz"

# 1. System-Abhängigkeiten
RUN         apt-get update && apt-get install -y --no-install-recommends \
                git gcc g++ ca-certificates dnsutils curl iproute2 ffmpeg procps tini \
            && useradd -m -d /home/container container \
            && rm -rf /var/lib/apt/lists/*

# 2. Pip + Playwright
RUN         pip install --no-cache-dir --upgrade pip setuptools wheel && \
            pip install --no-cache-dir playwright==1.59.0

# 3. Browser-Pfad außerhalb von /home/container
ENV         PLAYWRIGHT_BROWSERS_PATH=/opt/ms-playwright

# 4. Browser + System-Deps als root installieren (Pfad bleibt nach Mount erhalten)
RUN         playwright install --with-deps chromium && \
            chmod -R o+rX /opt/ms-playwright

# 5. Jetzt zum container-User wechseln
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL  SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
