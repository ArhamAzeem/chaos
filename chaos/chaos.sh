#!/bin/bash
CONFIG="../config/scenarios.json"

SCENARIOS=("kill_container" "kill_process" "cpu_stress")
INTERVAL=10

function is_container_running() {
	docker ps -q -f "name=^chaos_app$" | grep -q .
}

while true; do
	RANDOM_INDEX=$((RANDOM % ${#SCENARIOS[@]}))
	ACTION=${SCENARIOS[$RANDOM_INDEX]}
	echo "Injecting $ACTION"

	case $ACTION in
		kill_container)
			if is_container_running; then
				docker exec chaos_app sh -c 'pkill -9 node || true'
			else
				echo "Container chaos_app not running; skipping kill"
			fi;;
		kill_process)
			if is_container_running; then
				docker exec chaos_app sh -c 'pkill -TERM node || true'
			else
				echo "Container chaos_app not running; skipping pkill"
			fi;;
		cpu_stress)
			if is_container_running; then
				docker exec chaos_app sh -c 'yes > /dev/null 2>&1 & PID=$!; sleep 5; kill -TERM "$PID" >/dev/null 2>&1 || true'
			else
				echo "Container chaos_app not running; skipping cpu stress"
			fi;;
	esac

	sleep $INTERVAL
done
