#!/usr/bin/env bash
# Run on App-A or App-B (Amazon Linux 2023).
# Usage: ./verify-connectivity.sh <peer-private-ip>
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <peer-private-ip>" >&2
  exit 2
fi

peer_ip="$1"
echo "=== Host identity ==="
hostname
hostname -I
echo
echo "=== Ping peer: ${peer_ip} ==="
ping -c 4 "$peer_ip"
