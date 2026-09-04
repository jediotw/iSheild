#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# iSheild tmux Phase Switcher
# ============================================================

# Nothing to do if tmux is not installed.
if ! command -v tmux >/dev/null 2>&1; then
    exit 0
fi

# Nothing to do if no tmux server is running.
if ! tmux has-session 2>/dev/null; then
    exit 0
fi

# ------------------------------------------------------------
# Determine current iSheild phase
# ------------------------------------------------------------

hour="$(date +%H)"
hour=$((10#$hour))

if (( hour >= 6 && hour < 12 )); then
    phase="morning"
elif (( hour >= 12 && hour < 18 )); then
    phase="day"
else
    phase="night"
fi

# ------------------------------------------------------------
# Apply iSheild tmux theme
# ------------------------------------------------------------

"$HOME/iSheild/terminal/tmux-theme.sh" "$phase"