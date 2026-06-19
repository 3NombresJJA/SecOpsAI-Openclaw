#!/bin/bash
# docker_status.sh
# SecOps AI - Phase 3: Read-Only Security Tools
# PURPOSE: List running Docker containers and exposed ports
# SAFETY: READ-ONLY - does not stop, start, or modify containers

set -euo pipefail

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "========================================"
echo " SecOps AI - Docker Status"
echo " Timestamp: $TIMESTAMP"
echo "========================================"
echo ""

if ! command -v docker &>/dev/null; then
    echo "INFO: Docker is not installed on this system."
    exit 0
fi

echo "[*] Running containers:"
echo ""
docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}" 2>/dev/null || \
    echo "Could not connect to Docker daemon."

echo ""
echo "[*] All containers (including stopped):"
echo ""
docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}" 2>/dev/null || \
    echo "Could not connect to Docker daemon."

echo ""
echo "========================================"
echo " NOTE: READ-ONLY. No containers were modified."
echo "========================================"
