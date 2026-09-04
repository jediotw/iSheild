#!/usr/bin/env bash

set -euo pipefail

PTYXIS_SCHEMA="org.gnome.Ptyxis"
PROFILE_SCHEMA="org.gnome.Ptyxis.Profile"

profile_uuid="$(
    gsettings get "$PTYXIS_SCHEMA" default-profile-uuid |
    tr -d "'"
)"

profile_path="/org/gnome/Ptyxis/Profiles/${profile_uuid}/"

hour="$(date +%H)"
hour=$((10#$hour))

if (( hour >= 6 && hour < 12 )); then
    phase="morning"
    palette="iSheild Morning"
elif (( hour >= 12 && hour < 18 )); then
    phase="day"
    palette="iSheild Day"
else
    phase="night"
    palette="iSheild Night"
fi

current="$(
    gsettings get \
        "${PROFILE_SCHEMA}:${profile_path}" \
        palette |
    tr -d "'"
)"

if [[ "$current" == "$palette" ]]; then
    exit 0
fi

gsettings set \
    "${PROFILE_SCHEMA}:${profile_path}" \
    palette "$palette"