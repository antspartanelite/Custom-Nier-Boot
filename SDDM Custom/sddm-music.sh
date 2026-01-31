#!/usr/bin/env bash
set -euo pipefail

STARTUP_SOUND="/usr/share/sounds/sddm-startup.wav"
MUSIC_DIR="/usr/share/sounds/sddm-music"
VOLUME=0.15

[ -d "$MUSIC_DIR" ] || exit 0

mapfile -t TRACKS < <(find "$MUSIC_DIR" -type f -name '*.wav' | shuf)
[ "${#TRACKS[@]}" -gt 0 ] || exit 0

# Start playback (no fade effect here)
play -q \
    "$STARTUP_SOUND" "${TRACKS[@]}" \
    pad 0.5 0 \
    vol "$VOLUME"

