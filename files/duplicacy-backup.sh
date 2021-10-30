#!/bin/bash
# Duplicacy backup cron script
# v0.1, Oct 6 2021, by Reid Sox-Harris

PATH="/usr/local/bin:/usr/bin:/bin"

# Debugging helper
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }

info "Beginning backup..."

cd ~/duplicacy
duplicacy backup

# Pruning: Keep daily backups for a month, weekly backups for 180 days, monthly past that
info "Pruning backup..."
duplicacy prune -keep 1:7
duplicacy prune -keep 7:30
duplicacy prune -keep 30:180
duplicacy prune

info "Backup complete!"
exit 0
