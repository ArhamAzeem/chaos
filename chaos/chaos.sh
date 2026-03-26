#!/bin/bash
CONFIG="../config/scenarios.json"

SCENARIOS=("kill_container" "kill_process" "cpu_stress")
INTERVAL=10

function is_container_running() {
	docker ps -q -f "name=^chaos_app$" | grep -q .
}

function wait_for_container_healthy() {
	local timeout_seconds=30
	local elapsed=0
	while [ $elapsed -lt $timeout_seconds ]; do
		local health=$(docker inspect --format='{{.State.Health.Status}}' chaos_app 2>/dev/null || echo "none")
		if [ "$health" = "healthy" ]; then
			return 0
		fi
		if [ "$health" = "unhealthy" ]; then
			echo "[wait_for_container_healthy] still unhealthy"
		fi
		sleep 2
		elapsed=$((elapsed + 2))
	done
	return 1
}

while true; do
	RANDOM_INDEX=$((RANDOM % ${#SCENARIOS[@]}))
	ACTION=${SCENARIOS[$RANDOM_INDEX]}
	echo "Injecting $ACTION"

	case $ACTION in
		kill_container)
			if is_container_running; then
				docker kill chaos_app || true
			else
				echo "Container chaos_app not running; skipping kill"
			fi
			echo "Waiting for restart and health recovery..."
			sleep 15
			wait_for_container_healthy || echo "Container did not become healthy in expected time";;
		kill_process)
			if is_container_running; then
				docker exec chaos_app pkill node || true
			else
				echo "Container chaos_app not running; skipping pkill"
			fi
			echo "Waiting for restart and health recovery..."
			sleep 15
			wait_for_container_healthy || echo "Container did not become healthy in expected time";;
		cpu_stress)
			if is_container_running; then
				docker exec chaos_app sh -c 'yes > /dev/null 2>&1 & PID=$!; sleep 5; kill -TERM "$PID" >/dev/null 2>&1 || true'
			else
				echo "Container chaos_app not running; skipping cpu stress"
			fi;;
	esac

	sleep $INTERVAL
done
