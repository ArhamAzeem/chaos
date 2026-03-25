#!/bin/bash
mkdir -p ../logs

LOG_FILE="../logs/monitor.log"

touch "$LOG_FILE"

echo "Monitoring http://localhost:3000/health... (Press Ctrl+C to stop)"

while true; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/health)
    TIME=$(date "+%H:%M:%S")

    if [ "$STATUS" -eq 200 ]; then
        echo "[$TIME] UP (Status: $STATUS)" | tee -a "$LOG_FILE"
    else
        echo "[$TIME] DOWN (Status: $STATUS)" | tee -a "$LOG_FILE"
    fi

    sleep 5
done