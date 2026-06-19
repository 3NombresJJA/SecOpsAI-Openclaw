#!/bin/bash
# listening_ports.sh
# SecOps AI - Phase 3: Read-Only Security Tools
# PURPOSE: List all TCP/UDP ports currently listening with owning process
# SAFETY: READ-ONLY - no system modifications

set -euo pipefail

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "========================================"
echo " SecOps AI - Listening Ports"
echo " Timestamp: $TIMESTAMP"
echo "========================================"
echo ""

echo "[*] TCP listening ports:"
echo ""
ss -tlnp 2>/dev/null || netstat -tlnp 2>/dev/null || echo "Neither ss nor netstat available."

echo ""
echo "[*] UDP listening ports:"
echo ""
ss -ulnp 2>/dev/null || netstat -ulnp 2>/dev/null || echo "Neither ss nor netstat available."

echo ""
echo "========================================"
echo " NOTE: READ-ONLY. No changes were made."
echo "========================================"
