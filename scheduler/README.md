# Scheduler - Cron Job Setup

This directory contains scripts for scheduling periodic tasks using cron.

## Files

- `setup_cron.sh` - Setup script to add the hello world Python script to crontab (runs every 5 minutes)

## Usage

### Setup the Cron Job

Run the setup script to schedule the hello world Python script:

```bash
cd /home/brentvering/simpler_data/repos/dgx_launcher/scheduler
chmod +x setup_cron.sh
./setup_cron.sh
```

This will:
1. Make `/home/brentvering/simpler_data/repos/dgx_launcher/hello_world/hello.py` executable
2. Add a cron job that runs every 5 minutes
3. Log cron output to `/home/brentvering/simpler_data/repos/dgx_launcher/hello_world/cron_output.log`
4. The script itself creates its own log at `/home/brentvering/simpler_data/repos/dgx_launcher/hello_world/hello_world_log.txt`

### View Active Cron Jobs

```bash
crontab -l
```

### Monitor the Log Files

```bash
# Monitor cron output
tail -f /home/brentvering/simpler_data/repos/dgx_launcher/hello_world/cron_output.log

# Monitor the script's own log
tail -f /home/brentvering/simpler_data/repos/dgx_launcher/hello_world/hello_world_log.txt
```

### Remove the Cron Job

```bash
crontab -e
# Delete the line containing hello.py
```

Or remove all cron jobs:

```bash
crontab -r
```

## Cron Schedule Format

The cron job uses the format: `*/5 * * * *`

This means:
- `*/5` - Every 5 minutes
- `*` - Every hour
- `*` - Every day of month
- `*` - Every month
- `*` - Every day of week

## Testing

To test the hello world script manually:

```bash
cd /home/brentvering/simpler_data/repos/dgx_launcher/hello_world
python3 hello.py
```
