#!/bin/bash
# install.sh
# Installs SecOps AI skills and workspace files into OpenClaw

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OC_WORKSPACE="${HOME}/.openclaw/workspace"
SKILLS_DIR="${OC_WORKSPACE}/skills"
TOOLS_DIR="${HOME}/secops-ai/tools"

echo "========================================"
echo " SecOps AI - OpenClaw Installer"
echo "========================================"
echo ""

# 1. Create OpenClaw workspace dir
echo "[1/5] Creating OpenClaw workspace directories..."
mkdir -p "$SKILLS_DIR"
mkdir -p "$TOOLS_DIR"
echo "  ✓ ${SKILLS_DIR}"
echo "  ✓ ${TOOLS_DIR}"

# 2. Copy workspace markdown files
echo ""
echo "[2/5] Copying workspace files (SOUL, AGENTS, TOOLS)..."

for f in SOUL.md AGENTS.md TOOLS.md; do
    if [ -f "${SCRIPT_DIR}/${f}" ]; then
        cp "${SCRIPT_DIR}/${f}" "${OC_WORKSPACE}/${f}"
        echo "  ✓ ${OC_WORKSPACE}/${f}"
    else
        echo "  ⚠ Missing: ${SCRIPT_DIR}/${f}"
    fi
done

# 3. Copy skills
echo ""
echo "[3/5] Installing skills..."

SKILL_DIRS=("audit-network" "firewall-status" "iptables-status" "listening-ports" "auth-logs" "system-info" "docker-status" "security-updates")

for skill in "${SKILL_DIRS[@]}"; do
    SRC="${SCRIPT_DIR}/skills/${skill}"
    DST="${SKILLS_DIR}/${skill}"
    if [ -d "$SRC" ]; then
        mkdir -p "$DST"
        cp "${SRC}/SKILL.md" "${DST}/SKILL.md"
        echo "  ✓ skill: ${skill}"
    else
        echo "  ⚠ Missing skill directory: ${SRC}"
    fi
done

# 4. Copy tool scripts
echo ""
echo "[4/5] Copying tool scripts..."

for script in "${SCRIPT_DIR}"/tools/*.sh; do
    name=$(basename "$script")
    cp "$script" "${TOOLS_DIR}/${name}"
    chmod +x "${TOOLS_DIR}/${name}"
    echo "  ✓ ${TOOLS_DIR}/${name}"
done

# 5. Check dependencies
echo ""
echo "[5/5] Checking tool dependencies..."

TOOLS=("nmap" "ufw" "iptables" "ss" "docker")
for tool in "${TOOLS[@]}"; do
    if command -v "$tool" &>/dev/null; then
        echo "  ✓ ${tool} found"
    else
        echo "  ⚠ ${tool} NOT found — some tools will be limited"
    fi
done

echo ""
echo "========================================"
echo " Installation complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Reload OpenClaw skills:"
echo "     openclaw gateway restart"
echo "     (or send /new in chat)"
echo ""
echo "  2. Verify skills loaded:"
echo "     openclaw skills list"
echo ""
echo "  3. Test in Telegram or dashboard:"
echo "     /audit_network"
echo ""
