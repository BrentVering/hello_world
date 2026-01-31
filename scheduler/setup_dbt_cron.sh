#!/bin/bash

# Setup script for scheduling dbt run (jaffle_shop) at midnight every night

JAFFLE_DIR="/home/brentvering/simpler_data/repos/dgx_launcher/dbt/jaffle_shop"
LOG_FILE="$JAFFLE_DIR/dbt_run.log"
RUN_SCRIPT="$JAFFLE_DIR/run_dbt_cron.sh"

# Create a small wrapper script so cron runs in the right directory and logs
cat > "$RUN_SCRIPT" << 'WRAPPER'
#!/bin/bash
JAFFLE_DIR="/home/brentvering/simpler_data/repos/dgx_launcher/dbt/jaffle_shop"
LOG_FILE="$JAFFLE_DIR/dbt_run.log"
cd "$JAFFLE_DIR" || exit 1
echo "=== $(date -Iseconds) dbt run ===" >> "$LOG_FILE"
dbt run >> "$LOG_FILE" 2>&1
echo "=== exit $? ===" >> "$LOG_FILE"
WRAPPER
chmod +x "$RUN_SCRIPT"

# Cron: minute 0, hour 0 = midnight every night
CRON_JOB="0 0 * * * $RUN_SCRIPT"

# Check if this cron job already exists
(crontab -l 2>/dev/null | grep -F "$RUN_SCRIPT") && {
    echo "Cron job for dbt jaffle_shop already exists!"
    exit 0
}

# Add the cron job
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "Cron job added successfully!"
echo "dbt run (jaffle_shop) will run at midnight every night (0 0 * * *)."
echo "Project: $JAFFLE_DIR"
echo "Output logged to: $LOG_FILE"
echo ""
echo "To view the cron job: crontab -l"
echo "To remove the cron job: crontab -e (and delete the line)"
