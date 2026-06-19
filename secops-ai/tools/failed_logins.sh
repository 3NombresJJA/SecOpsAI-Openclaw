#!/bin/bash
# failed_logins.sh
# SecOps AI - Phase 3: Read-Only Security Tools
# PURPOSE: Review recent failed authentication events from system logs
# SAFETY: READ-ONLY - only reads log files, no modifications

set -euo pipefail

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE="/var/log/auth.log"
LINES="${1:-50}"

echo "========================================"
echo " SecOps AI - Authentication Log Review"
echo " Timestamp: $TIMESTAMP"
echo "========================================"
echo ""

if [ ! -f "$LOG_FILE" ]; then
    echo "WARNING: $LOG_FILE not found."
    echo "Trying /var/log/secure as fallback (RHEL/CentOS)..."
    LOG_FILE="/var/log/secure"
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: No authentication log file found."
    echo "Checked: /var/log/auth.log, /var/log/secure"
    exit 1
fi

if [ ! -r "$LOG_FILE" ]; then
    echo "ERROR: Cannot read $LOG_FILE — insufficient permissions."
    echo "The agent may need elevated privileges to read auth logs."
    exit 1
fi

echo "[*] Last $LINES failed password attempts:"
echo ""
grep "Failed password" "$LOG_FILE" 2>/dev/null | tail -"$LINES" || \
    echo "No failed password entries found."

echo ""
echo "[*] Top source IPs with failed attempts:"
echo ""
grep "Failed password" "$LOG_FILE" 2>/dev/null | \
    grep -oE 'from [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | \
    sort | uniq -c | sort -rn | head -20 || \
    echo "No data to summarize."

echo ""
echo "[*] Invalid user attempts:"
echo ""
grep "Invalid user" "$LOG_FILE" 2>/dev/null | tail -20 || \
    echo "No invalid user attempts found."

echo ""
echo "========================================"
echo " NOTE: READ-ONLY. Log files were not modified."
echo "========================================"
