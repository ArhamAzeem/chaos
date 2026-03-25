#!/bin/bash
LOG_FILE='../logs/monitor.log'

TOTAL_DOWN=$(grep -c "DOWN" "$LOG_FILE")
TOTAL_UP=$(grep -c "UP" "$LOG_FILE")

echo "Report"
echo "Downtime events: $TOTAL_DOWN"
echo "Uptime events: $TOTAL_UP"