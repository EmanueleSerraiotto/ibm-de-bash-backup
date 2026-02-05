#!/usr/bin/env bash

# Create a gzip-compressed tar archive containing files modified in the last 24 hours
# from <target_dir>, then move the archive into <destination_dir>.
#
# Usage:
#   ./backup.sh <target_dir> <destination_dir>


usage() {
  # usage message
  echo "Usage: $0 <target_dir> <destination_dir>"
}

# Validating arguments 

# Checking if the number of arguments is 2
if (( $# != 2 )); then
  usage
  exit 1
fi

target_dir="$1"
destination_dir="$2"

# Checking if valid paths were provided
if [[ ! -d "$target_dir" || ! -d "$destination_dir" ]]; then
  echo "Error: invalid directory path provided."
  usage
  exit 1
fi

# Saving timestamps and paths
current_ts=$(date +%s)
yesterday_ts=$(( current_ts - 24 * 60 * 60 ))

backup_filename="backup-${current_ts}.tar.gz"

start_dir="$(pwd)"

cd "$destination_dir"
destination_abs_dir="$(pwd)"

cd "$start_dir"
cd "$target_dir"

# Identifying files to backup

files_to_backup=()

for file in *; do

  # If the file was modified in the last 24 hours, include it.
  if (( $(date -r "$file" +%s) > yesterday_ts )); then
    files_to_backup+=("$file")
  fi
done

if (( ${#files_to_backup[@]} == 0 )); then
  echo "No files modified in the last 24 hours. Nothing to back up."
  exit 0
fi

# --- Create archive and move it ---------------------------------------------

tar -czvf "$backup_filename" "${files_to_backup[@]}"

mv "$backup_filename" "$destination_abs_dir"

echo "Backup created: ${destination_abs_dir}/${backup_filename}"
