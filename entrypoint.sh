#!/usr/bin/env bash
set -Eeuo pipefail

cd /home/container

if [[ -z "${STARTUP:-}" ]]; then
    echo "No STARTUP command was supplied by Pterodactyl."
    exec /bin/bash
fi

echo "Dabb Hotel container is starting..."
exec /bin/bash -lc "${STARTUP}"
