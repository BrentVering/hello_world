#!/bin/bash

# Deploy all cron jobs: hello.py + dbt jaffle_shop
# Run this script to add both jobs to your crontab.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Deploying cron jobs ==="
echo ""

echo "--- 1. hello.py ---"
bash "$SCRIPT_DIR/setup_cron.sh"
echo ""

echo "--- 2. dbt jaffle_shop ---"
bash "$SCRIPT_DIR/setup_dbt_cron.sh"
echo ""

echo "=== Current crontab ==="
crontab -l 2>/dev/null || echo "(empty)"
echo ""
echo "Done. Both cron jobs are scheduled."
