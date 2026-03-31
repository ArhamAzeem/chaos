#!/bin/bash
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_FILE="$ROOT/logs/monitor.log"

tail -Fn0 $LOG_FILE | while read line; do
    if echo "$line" | grep -q "DOWN"; then
        echo "[$(date "+%H:%M:%S")] ALERT Service is DOWN"
    fi
done