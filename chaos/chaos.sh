#!/bin/bash
CONFIG="../config/scenarios.json"

if command -v jq >/dev/null 2>&1; then
    SCENARIOS=($(jq -r '.scenarios[]' "$CONFIG"))
    INTERVAL=$(jq -r '.interval_seconds' "$CONFIG")
else
    echo "jq not found; falling back to default scenarios"
    SCENARIOS=("kill_container" "kill_process" "cpu_stress")
    INTERVAL=10
fi

if [ ${#SCENARIOS[@]} -eq 0 ]; then
    echo "No scenarios loaded. Exiting."
    exit 1
fi

while true; do
	RANDOM_INDEX=$((RANDOM % ${#SCENARIOS[@]}))
	ACTION=${SCENARIOS[$RANDOM_INDEX]}
	echo "Injecting $ACTION"

	case $ACTION in
		kill_container)
			docker kill chaos_app;;
		kill_process)
			docker exec chaos_app pkill node;;
		cpu_stress)
			docker exec chaos_app sh -c "yes > /dev/null & sleep 5; kill $!";;
	esac

	sleep $INTERVAL
done
