#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# iSheild Installer
# ============================================================

ISHEILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "iSheild"
echo "======="

# ------------------------------------------------------------
# 1. VS Code
# ------------------------------------------------------------

echo
echo "Checking VS Code..."

if command -v code >/dev/null 2>&1; then

    echo "✓ VS Code detected"

    if code --install-extension jediOTW.isheild --force; then
        echo "✓ iSheild VS Code extension installed"
    else
        echo "Warning: failed to install iSheild VS Code extension."
    fi

else

    echo "Warning: VS Code is not installed or 'code' is not available."
    echo "Skipping VS Code integration."

fi

# ------------------------------------------------------------
# 2. Terminal + tmux
# ------------------------------------------------------------

echo
echo "Installing terminal integration..."

if [[ ! -x "$ISHEILD_DIR/terminal/install.sh" ]]; then

    echo "Error: terminal installer not found or not executable:"
    echo "  $ISHEILD_DIR/terminal/install.sh"

    exit 1

fi

"$ISHEILD_DIR/terminal/install.sh"

# ------------------------------------------------------------
# Done
# ------------------------------------------------------------

echo
echo "================================"
echo "iSheild installation complete"
echo "================================"

echo
echo "Integrations:"
echo "  ✓ VS Code"
echo "  ✓ Terminal"
echo "  ✓ tmux (when available)"

echo
echo "Automatic phases:"
echo "  06:00–11:59  Morning"
echo "  12:00–17:59  Day"
echo "  18:00–05:59  Night"