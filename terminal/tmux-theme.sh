#!/usr/bin/env bash

set -euo pipefail

PHASE="${1:-}"

case "$PHASE" in
    morning)
        BG="#F7F1DF"
        SURFACE="#EEE8D5"
        HOVER="#E5DFCC"
        SELECTION="#D9E3E3"
        TEXT="#263238"
        MUTED="#687A80"
        BORDER="#D8D1BC"
        ACCENT="#268BD2"
        ;;

    day)
        BG="#21252B"
        SURFACE="#282C34"
        HOVER="#30343D"
        SELECTION="#3E4451"
        TEXT="#ABB2BF"
        MUTED="#7F848E"
        BORDER="#3A3F4B"
        ACCENT="#61AFEF"
        ;;

    night)
        BG="#1E1E1E"
        SURFACE="#252526"
        HOVER="#2A2D2E"
        SELECTION="#264F78"
        TEXT="#D0D0D0"
        MUTED="#858585"
        BORDER="#38383D"
        ACCENT="#569CD6"
        ;;

    *)
        echo "Usage: $0 {morning|day|night}" >&2
        exit 1
        ;;
esac

# ============================================================
# iSheild tmux theme
# ============================================================

# ------------------------------------------------------------
# General
# ------------------------------------------------------------

tmux set-option -g status-position bottom
tmux set-option -g status-interval 5

# ------------------------------------------------------------
# Status bar
# ------------------------------------------------------------

tmux set-option -g status-style \
    "bg=$BG,fg=$TEXT"

tmux set-option -g status-left-length 30
tmux set-option -g status-right-length 60

tmux set-option -g status-left \
    "#[fg=$ACCENT,bold] #S #[fg=$MUTED]│"

tmux set-option -g status-right \
    "#[fg=$MUTED]#{pane_current_path} #[fg=$BORDER]│ #[fg=$TEXT]%H:%M "

# ------------------------------------------------------------
# Window status
# ------------------------------------------------------------

tmux set-option -g window-status-format \
    "#[fg=$MUTED] #I #[fg=$MUTED]#W "

tmux set-option -g window-status-current-format \
    "#[fg=$BG,bg=$ACCENT,bold] #I #W "

tmux set-option -g window-status-separator ""

# ------------------------------------------------------------
# Pane borders
# ------------------------------------------------------------

tmux set-option -g pane-border-style \
    "fg=$BORDER"

tmux set-option -g pane-active-border-style \
    "fg=$ACCENT"

# ------------------------------------------------------------
# Messages
# ------------------------------------------------------------

tmux set-option -g message-style \
    "bg=$SURFACE,fg=$TEXT,align=centre"

tmux set-option -g message-command-style \
    "bg=$SURFACE,fg=$ACCENT,align=centre"

# ------------------------------------------------------------
# Copy / mode UI
# ------------------------------------------------------------

tmux set-option -g mode-style \
    "bg=$SELECTION,fg=$TEXT,bold"

# ------------------------------------------------------------
# Popup UI
# ------------------------------------------------------------

tmux set-option -g popup-style \
    "bg=$SURFACE,fg=$TEXT"

tmux set-option -g popup-border-style \
    "fg=$BORDER"

# ------------------------------------------------------------
# Menu UI
# ------------------------------------------------------------

tmux set-option -g menu-style \
    "bg=$SURFACE,fg=$TEXT"

tmux set-option -g menu-selected-style \
    "bg=$HOVER,fg=$TEXT,bold"

tmux set-option -g menu-border-style \
    "fg=$BORDER"

# ------------------------------------------------------------
# Activity / bell
# ------------------------------------------------------------

tmux set-option -g window-status-activity-style \
    "bg=$HOVER,fg=$TEXT"

tmux set-option -g window-status-bell-style \
    "bg=$HOVER,fg=$TEXT"

# ------------------------------------------------------------
# Clock
# ------------------------------------------------------------

tmux set-option -g clock-mode-colour "$ACCENT"
tmux set-option -g clock-mode-style 24

# ------------------------------------------------------------
# Refresh
# ------------------------------------------------------------

tmux refresh-client -S