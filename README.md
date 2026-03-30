# ibm-de-bash-backup

Bash Scripting mini project for IBM's Shell Scripting Course: the goal is to automatically back up any file updated in the last 24h in a given directory.

## What it does
- Validates input arguments (target directory, destination directory).
- Scans the target directory and selects files modified in the last 24 hours.
- Creates a timestamped `.tar.gz` archive containing only the selected files.
- Moves the archive to the destination directory.

## Data source
- Local filesystem (the target directory you pass as the first argument).

## Outputs
- A compressed archive: `backup-<epoch_timestamp>.tar.gz` saved into the destination directory.
- Terminal output showing progress (and tar verbose output if enabled in the script).

## Project structure
- `backup.sh` — main script.
- `README.md` — project documentation.

## Setup
**Prerequisites**
- Bash (Linux/WSL/macOS).
- `tar` available on your system.
- GNU `date` recommended (the script uses `date -r` to read file modification times).

## Cron (run daily at midnight)
To run the backup automatically every day at 00:00, add a cron entry.

1. Open your crontab:
```bash
crontab -e
```
2. Add a line like this (paths to be changed):
```bash
0 0 * * * /bin/bash /absolute/path/to/backup.sh /absolute/path/to/target_dir /absolute/path/to/destination_dir >> /absolute/path/to/cron.log 2>&1
