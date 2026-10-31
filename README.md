# Dabb Hotel — Debian 13 Pterodactyl runtime

This repository builds a lightweight Debian 13 (Trixie) runtime image intended to be selected as a Docker image for a Pterodactyl server.

## What this image is

- Debian 13 slim base
- Common command-line tools for installing and running application components
- A small entrypoint that runs the Pterodactyl `STARTUP` command
- No systemd, privileged mode, or host-level service management

Pterodactyl/Wings should manage the container lifecycle. Do not try to run a full systemd host inside this container.

## Build locally

```bash
docker build -t dabb-hotel-debian13:latest .
```

## GitHub Container Registry

The GitHub Actions workflow in `.github/workflows/publish.yml` builds and publishes:

`ghcr.io/waterfieldgaming/dabb-hotel-debian13:latest`

The package may need to be made public in the GitHub Packages settings before a Pterodactyl node can pull it without registry credentials.

## Pterodactyl setup

1. Wait for the GitHub Actions image build to finish.
2. In the Pterodactyl egg, set the Docker image to the published GHCR image.
3. Keep the server unprivileged and let Wings set the container UID/GID.
4. Set the egg startup command using the actual application startup command.
5. Allocate the ports required by the emulator and web client in the Panel.

## Important

This repository currently supplies the **base runtime image only**. It does not yet install or configure PlusEMU, Volt, or a database. Those components need to be added after their exact upstream release/source and runtime requirements have been confirmed. Do not expose database ports publicly; use a private Docker network or a separately secured database service.
