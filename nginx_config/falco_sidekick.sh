#!/usr/bin/env bash
#
# tail_and_send.sh
#
# Continuously tails an Nginx JSON‐formatted access log and POSTs each line
# to the Falco Sidekick HTTP endpoint.
#
# Usage: run this script in your nginx container (or host with access to the log):
#   ./tail_and_send.sh

set -euo pipefail

# Path to the JSON‐formatted access log
LOG_FILE="/var/log/nginx/audit/falco_sidekick.log"
# LOG_FILE="logs/access.log"

# Falco Sidekick HTTP endpoint
# ENDPOINT="http://localhost:2801/"
ENDPOINT="http://falco-falcosidekick.default.svc.cluster.local:2801/"

# Ensure the log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "Error: log file not found: $LOG_FILE" >&2
  exit 1
fi

# Start tailing new lines and POST each non-empty line
tail -n0 -F "$LOG_FILE" | while IFS= read -r line; do
  # skip blank lines
  [[ -z "${line//[[:space:]]/}" ]] && continue

  # POST JSON line to Sidekick
  curl -s -X POST "$ENDPOINT" \
    -H "Content-Type: application/json" \
    --data-raw "$line" \
  || echo "Warning: failed to POST line" >&2
done
