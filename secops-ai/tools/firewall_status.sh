#!/bin/bash
# firewall_status.sh
# SecOps AI - Phase 3: Read-Only Security Tools
# PURPOSE: Display UFW firewall configuration and active rules
# SAFETY: READ-ONLY - does not modify any firewall rules

set -euo pipefail

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "========================================"
echo " SecOps AI - Firewall Status (UFW)"
echo " Timestamp: $TIMESTAMP"
echo "========================================"
echo ""

if ! command -v ufw &>/dev/null; then
    echo "ERROR: ufw is not installed or not in PATH."
    echo "Install it with: sudo apt install ufw"
    exit 1
fi

echo "[*] Checking UFW firewall status..."
echo ""

ufw status verbose

echo ""
echo "========================================"
echo " NOTE: This was a READ-ONLY operation."
echo "       No firewall rules were modified."
echo "========================================"
