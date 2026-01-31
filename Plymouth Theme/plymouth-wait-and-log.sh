#!/usr/bin/env bash
journalctl -b -f -o short | while read -r line; do
    plymouth message --text="${line:0:200}"
done &
LOGGER_PID=$!

sleep 30   # tuned per system

kill "$LOGGER_PID"
