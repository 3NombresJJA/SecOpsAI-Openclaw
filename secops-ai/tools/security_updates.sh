#!/bin/bash
# security_updates.sh
# SecOps AI - Phase 3: Read-Only Security Tools
# PURPOSE: List available system security updates
# SAFETY: READ-ONLY - does not install, upgrade, or modify any packages

set -euo pipefail

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "========================================"
echo " SecOps AI - Available Security Updates"
echo " Timestamp: $TIMESTAMP"
echo "========================================"
echo ""

if ! command -v apt &>/dev/null; then
    echo "INFO: apt not available. This tool supports Debian/Ubuntu systems."
    exit 0
fi

echo "[*] Refreshing package index (read-only)..."
apt update -qq 2>/dev/null || echo "Could not refresh index (may need sudo)."
echo ""

echo "[*] Upgradable packages:"
echo ""
apt list --upgradable 2>/dev/null | grep -v "^Listing" || echo "No upgradable packages found."

echo ""
echo "[*] Checking critical security packages..."
CRITICAL=("openssl" "openssh-server" "openssh-client" "linux-image" "libc6" "sudo" "curl" "wget")
for pkg in "${CRITICAL[@]}"; do
    if apt list --upgradable 2>/dev/null | grep -q "^${pkg}/"; then
        echo "  ⚠️  CRITICAL UPDATE AVAILABLE: $pkg"
    fi
done

echo ""
echo "========================================"
echo " NOTE: READ-ONLY. No packages were installed or upgraded."
echo "========================================"
