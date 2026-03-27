#!/bin/bash
COMMAND=$1

case $COMMAND in
    start)
        docker compose up -d --build --wait
        ;;
    stop)
        docker compose down
        ;;
    chaos)
        bash chaos/chaos.sh
        ;;
    monitor)
        bash monitor/monitor.sh
        ;;
    alert)
        bash monitor/alert.sh
        ;;
    report)
        bash reports/reports.sh
        ;;
    *)
        echo "Usage: ./chaoskit.sh [start|stop|chaos|monitor|alert|report]"
        ;;
esac