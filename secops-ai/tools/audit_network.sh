#!/bin/bash
# audit_network.sh
# SecOps AI - Phase 3: Read-Only Security Tools
# PURPOSE: Scan local VM ports and identify open services
# SAFETY: READ-ONLY - does not modify any system configuration
# SCOPE: Scans localhost only (127.0.0.1)

set -euo pipefail

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
TARGET="127.0.0.1"

echo "========================================"
echo " SecOps AI - Network Audit"
echo " Timestamp: $TIMESTAMP"
echo " Target: $TARGET (localhost only)"
echo "========================================"
echo ""

if ! command -v nmap &>/dev/null; then
    echo "ERROR: nmap is not installed."
    echo "Install it with: sudo apt install nmap"
    exit 1
fi

echo "[*] Running service version scan..."
echo "    Command: nmap -sV $TARGET"
echo ""

nmap -sV "$TARGET"

echo ""
echo "========================================"
echo " Scan complete."
echo " NOTE: This was a READ-ONLY operation."
echo "       No system changes were made."
echo "========================================"
