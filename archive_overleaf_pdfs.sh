#!/bin/bash

# Directories
COMPILE_ROOT="/compiles"
ARCHIVE_DIR="/srv/overleaf-archives"
LOG_FILE="/app/logs/archive_overleaf_pdfs.log"

# Create log file if it doesn't exist
mkdir -p "$ARCHIVE_DIR"
mkdir -p "$(dirname "$LOG_FILE")"
touch "$LOG_FILE"

log() {
    timestamp="[$(date +'%Y-%m-%d %H:%M:%S')]"
    message="$timestamp $1"
    echo "$message" | tee -a "$LOG_FILE"
}

log "Starting Overleaf PDF archive scan"

# Loop through all output.pdf files in each project directory
find "$COMPILE_ROOT" -mindepth 2 -maxdepth 2 -type f -name "output.pdf" | while read -r pdf_path; do
    # Extract project ID from parent directory
    project_id=$(basename "$(dirname "$pdf_path")")
    dest_path="$ARCHIVE_DIR/${project_id}.pdf"

    # Copy if new or updated
    if [ ! -f "$dest_path" ]; then
        cp "$pdf_path" "$dest_path"
        log "Archived new PDF for project $project_id"
    elif [ "$pdf_path" -nt "$dest_path" ]; then
        cp "$pdf_path" "$dest_path"
        log "Updated PDF for project $project_id"
    else
        log "Skipped unchanged PDF for project $project_id"
    fi
done

log "Finished scan"