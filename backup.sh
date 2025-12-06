#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# backup.sh
# Backup Jira and PostgreSQL Docker volumes.
#
# Usage:
#   ./stop.sh       # Stop running containers
#   ./backup.sh     # Create tar.gz backups of both volumes
#
# Output:
#   jira_data_backup_<timestamp>.tar.gz
#   postgres_data_backup_<timestamp>.tar.gz
#
# Note:
#   Containers must be stopped before backup.
# -----------------------------------------------------------------------------
set -e

# Volume names (adjust when project name changes)
JIRA_VOL="jira-docker-sandbox_jira_data"
PG_VOL="jira-docker-sandbox_postgres_data"

# Output directory
OUTDIR="$PWD"

# Timestamp
TS=$(date +%Y%m%d_%H%M%S)

echo "Backing up Jira volume..."
docker run --rm \
  -v "$JIRA_VOL:/data" \
  -v "$OUTDIR:/backup" \
  alpine \
  tar czvf "/backup/jira_data_backup_${TS}.tar.gz" -C /data .

echo "Backing up PostgreSQL volume..."
docker run --rm \
  -v "$PG_VOL:/data" \
  -v "$OUTDIR:/backup" \
  alpine \
  tar czvf "/backup/postgres_data_backup_${TS}.tar.gz" -C /data .

echo "Backup completed successfully."
