#!/bin/bash
# iptables_status.sh
# SecOps AI - Phase 3: Read-Only Security Tools
# PURPOSE: Display current iptables packet filtering rules
# SAFETY: READ-ONLY - does not modify any rules

set -euo pipefail

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "========================================"
echo " SecOps AI - IPTables Status"
echo " Timestamp: $TIMESTAMP"
echo "========================================"
echo ""

if ! command -v iptables &>/dev/null; then
    echo "ERROR: iptables is not available."
    exit 1
fi

echo "[*] --- FILTER TABLE (default) ---"
echo ""
iptables -L -n -v --line-numbers 2>/dev/null || \
    echo "Note: Run as root to see full iptables output."

echo ""
echo "[*] --- NAT TABLE ---"
echo ""
iptables -t nat -L -n -v --line-numbers 2>/dev/null || \
    echo "Note: Run as root to see NAT table."

echo ""
echo "========================================"
echo " NOTE: This was a READ-ONLY operation."
echo "       No rules were added or modified."
echo "========================================"
