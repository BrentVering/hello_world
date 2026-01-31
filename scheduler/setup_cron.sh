#!/bin/bash

# Setup script for scheduling hello.py to run at midnight every night

# Get the absolute path to the hello.py script
HELLO_SCRIPT="/home/brentvering/simpler_data/repos/dgx_launcher/hello_world/hello.py"
HELLO_DIR="$(dirname "$HELLO_SCRIPT")"
LOG_FILE="$HELLO_DIR/cron_output.log"

# Make hello.py executable
chmod +x "$HELLO_SCRIPT"

# Create the cron job entry (cd to the script directory so the log file is created there)
CRON_JOB="0 * * * * cd $HELLO_DIR && /usr/bin/env python3 $HELLO_SCRIPT >> $LOG_FILE 2>&1"

# Check if the cron job already exists
(crontab -l 2>/dev/null | grep -F "$HELLO_SCRIPT") && {
    echo "Cron job for hello.py already exists!"
    exit 0
}

# Add the cron job
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

echo "Cron job added successfully!"
echo "The hello.py script will run every 5 minutes."
echo "Script location: $HELLO_SCRIPT"
echo "Cron output will be logged to: $LOG_FILE"
echo "Script's own log file: $HELLO_DIR/hello_world_log.txt"
echo ""
echo "To view the cron job, run: crontab -l"
echo "To remove the cron job, run: crontab -e (and delete the line)"
