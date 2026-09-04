#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# iSheild Terminal Installer
# ============================================================

ISHEILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PALETTE_SOURCE="$ISHEILD_DIR/palettes"
PALETTE_TARGET="$HOME/.local/share/org.gnome.Ptyxis/palettes"

SYSTEMD_SOURCE="$ISHEILD_DIR/systemd"
SYSTEMD_TARGET="$HOME/.config/systemd/user"

PTYXIS_SCHEMA="org.gnome.Ptyxis"
PROFILE_SCHEMA="org.gnome.Ptyxis.Profile"

echo "iSheild installer"
echo "================="

# ------------------------------------------------------------
# 1. Check required palette files
# ------------------------------------------------------------

if [[ ! -d "$PALETTE_SOURCE" ]]; then
    echo "Error: missing palettes directory:"
    echo "  $PALETTE_SOURCE"
    exit 1
fi

for palette in \
    isheild-morning.palette \
    isheild-day.palette \
    isheild-night.palette
do
    if [[ ! -f "$PALETTE_SOURCE/$palette" ]]; then
        echo "Error: missing palette: $palette"
        exit 1
    fi
done

# ------------------------------------------------------------
# 2. Install Ptyxis palettes
# ------------------------------------------------------------

echo
echo "Installing Ptyxis palettes..."

mkdir -p "$PALETTE_TARGET"

cp "$PALETTE_SOURCE"/isheild-*.palette \
   "$PALETTE_TARGET/"

echo "✓ Ptyxis palettes installed"

# ------------------------------------------------------------
# 3. Detect and configure Ptyxis
# ------------------------------------------------------------

if ! command -v ptyxis >/dev/null 2>&1; then

    echo
    echo "Warning: Ptyxis is not installed."
    echo "Skipping Ptyxis profile configuration."

else

    echo
    echo "Configuring Ptyxis..."

    profile_uuid="$(
        gsettings get "$PTYXIS_SCHEMA" default-profile-uuid |
        tr -d "'"
    )"

    if [[ -z "$profile_uuid" ]]; then

        echo "Warning: could not determine Ptyxis profile."

    else

        profile_path="/org/gnome/Ptyxis/Profiles/${profile_uuid}/"

        gsettings set \
            "${PROFILE_SCHEMA}:${profile_path}" \
            palette "iSheild Day"

        echo "✓ Ptyxis profile configured"
        echo "  Profile: $profile_uuid"
        echo "  Palette: iSheild Day"

    fi

fi

# ------------------------------------------------------------
# 4. Install tmux integration
# ------------------------------------------------------------

if command -v tmux >/dev/null 2>&1; then

    echo
    echo "Installing tmux integration..."

    if [[ ! -f "$ISHEILD_DIR/tmux-theme.sh" ]]; then

        echo "Error: missing tmux theme script:"
        echo "  $ISHEILD_DIR/tmux-theme.sh"

        exit 1

    fi

    if [[ ! -f "$ISHEILD_DIR/switch-tmux.sh" ]]; then

        echo "Error: missing tmux phase switcher:"
        echo "  $ISHEILD_DIR/switch-tmux.sh"

        exit 1

    fi

    chmod +x \
        "$ISHEILD_DIR/tmux-theme.sh" \
        "$ISHEILD_DIR/switch-tmux.sh"

    echo "✓ tmux integration installed"

else

    echo
    echo "Warning: tmux is not installed."
    echo "Skipping tmux configuration."

fi

# ------------------------------------------------------------
# 5. Install systemd units
# ------------------------------------------------------------

if [[ -d "$SYSTEMD_SOURCE" ]]; then

    if [[ ! -f "$SYSTEMD_SOURCE/isheild-terminal.timer" ]]; then

        echo
        echo "Error: missing systemd timer:"
        echo "  $SYSTEMD_SOURCE/isheild-terminal.timer"

        exit 1

    fi

    echo
    echo "Installing systemd units..."

    mkdir -p "$SYSTEMD_TARGET"

    # Generate the service using the actual repository location.
    cat > "$SYSTEMD_TARGET/isheild-terminal.service" <<EOF
[Unit]
Description=iSheild terminal and tmux theme switcher

[Service]
Type=oneshot
ExecStart=$ISHEILD_DIR/switch-palette.sh
ExecStart=$ISHEILD_DIR/switch-tmux.sh
EOF

    cp "$SYSTEMD_SOURCE/isheild-terminal.timer" \
       "$SYSTEMD_TARGET/isheild-terminal.timer"

    systemctl --user daemon-reload

    systemctl --user enable --now isheild-terminal.timer

    echo "✓ systemd units installed"
    echo "  Repository: $ISHEILD_DIR"

else

    echo
    echo "Warning: terminal/systemd directory not found."
    echo "Skipping systemd installation."

fi

# ------------------------------------------------------------
# Done
# ------------------------------------------------------------

echo
echo "================================"
echo "iSheild installation complete"
echo "================================"

echo
echo "Terminal phases:"
echo "  06:00–11:59  Morning"
echo "  12:00–17:59  Day"
echo "  18:00–05:59  Night"