#!/bin/bash
# system_info.sh
# SecOps AI - Phase 3: Read-Only Security Tools
# PURPOSE: Display system information for situational awareness
# SAFETY: READ-ONLY - no system modifications

set -euo pipefail

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "========================================"
echo " SecOps AI - System Information"
echo " Timestamp: $TIMESTAMP"
echo "========================================"
echo ""

echo "[*] Host Identity:"
hostnamectl 2>/dev/null || echo "hostnamectl not available"
echo ""

echo "[*] Kernel:"
uname -a
echo ""

echo "[*] Uptime:"
uptime
echo ""

echo "[*] Disk Usage:"
df -h
echo ""

echo "[*] Memory Usage:"
free -h
echo ""

echo "========================================"
echo " NOTE: READ-ONLY. No changes were made."
echo "========================================"
