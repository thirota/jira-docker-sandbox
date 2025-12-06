#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# restore.sh
# Restore Jira and PostgreSQL volumes from backup tar.gz files.
#
# Usage:
#   ./stop.sh       # Stop containers (must not be running)
#   ./reset.sh      # Remove existing volumes (down -v)
#   ./restore.sh    # Restore latest backup files into fresh volumes
#   ./run.sh        # Start Jira with restored data
#
# Note:
#   "reset.sh" must be executed before restore.sh.
#   restore.sh automatically uses the latest backup files:
#       jira_data_backup_*.tar.gz
#       postgres_data_backup_*.tar.gz
# -----------------------------------------------------------------------------
set -e

# Volume names (adjust when project name changes)
JIRA_VOL="jira-docker-sandbox_jira_data"
PG_VOL="jira-docker-sandbox_postgres_data"

# Find latest backup files
JIRA_BKP=$(ls -1t jira_data_backup_*.tar.gz | head -1)
PG_BKP=$(ls -1t postgres_data_backup_*.tar.gz | head -1)

if [[ -z "$JIRA_BKP" || -z "$PG_BKP" ]]; then
  echo "No backup files found. Aborting."
  exit 1
fi

echo "Using backup files:"
echo "  Jira: $JIRA_BKP"
echo "  PostgreSQL: $PG_BKP"
echo ""

echo "Restoring Jira volume..."
docker run --rm \
  -v "$JIRA_VOL:/data" \
  -v "$PWD:/backup" \
  alpine \
  sh -c "cd /data && tar xzvf /backup/$JIRA_BKP"

echo "Restoring PostgreSQL volume..."
docker run --rm \
  -v "$PG_VOL:/data" \
  -v "$PWD:/backup" \
  alpine \
  sh -c "cd /data && tar xzvf /backup/$PG_BKP"

echo "Restore completed."
