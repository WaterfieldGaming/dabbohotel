FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC \
    HOME=/home/container

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      bash ca-certificates curl wget git unzip zip xz-utils \
      procps iproute2 iputils-ping dnsutils netcat-openbsd \
      tini tzdata python3 python3-venv \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/container \
 && chown -R 1000:1000 /home/container

WORKDIR /home/container

COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod 0755 /usr/local/bin/entrypoint

# Pterodactyl/Wings normally supplies the runtime UID/GID when it starts
# the container. Do not rely on systemd or require a privileged container.
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint"]
CMD ["/bin/bash"]
