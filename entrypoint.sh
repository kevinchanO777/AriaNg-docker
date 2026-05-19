#!/bin/sh

LOG_FILE="/tmp/aria2.log"

mkdir -p /downloads
echo "Starting aria2c..."
aria2c --enable-rpc --rpc-listen-all --rpc-allow-origin-all \
  --rpc-listen-port=6800 \
  --dir=/downloads \
  --continue=true --max-connection-per-server=16 \
  --min-split-size=1M --split=16 \
  --max-file-not-found=10 \
  --max-tries=100 \
  --retry-wait=10 \
  --log=$LOG_FILE --log-level=warn \
  --daemon

sleep 1
if pgrep aria2c >/dev/null 2>&1; then
  echo "aria2c started on port 6800"
else
  echo "aria2c failed to start. Logs:"
  cat $LOG_FILE
fi
echo "Starting HTTP server on port 9222..."
python3 -m http.server 9222 -d /app
