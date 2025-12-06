# Jira Docker Sandbox

A lightweight and reproducible sandbox environment for running Atlassian Jira Data Center with Docker Compose.  
Useful for testing, plugin development, data generation, and verification before Cloud migration.

---

## Features

- Jira Data Center (official Docker image): https://hub.docker.com/r/atlassian/jira-software
- PostgreSQL: https://hub.docker.com/_/postgres
- Persistent Docker volumes
- Utility scripts:
  - run.sh — Start Jira + PostgreSQL
  - stop.sh — Stop running containers
  - reset.sh — Remove volumes (dangerous)
  - backup.sh — Backup Jira & PostgreSQL volumes
  - restore.sh — Restore from latest backups

---

## Repository Structure

jira-docker-sandbox/  
├── docker-compose.yml       # Jira + PostgreSQL environment  
├── run.sh                   # Start services  
├── stop.sh                  # Stop services  
├── reset.sh                 # Reset volumes (dangerous)  
├── backup.sh                # Backup volumes  
├── restore.sh               # Restore volumes  
└── README.md                # This file

---

## Requirements

- Docker  
- Docker Compose plugin  
- macOS/Linux (WSL2 should work, not fully tested)

---

## Usage

### Start Jira
```
./run.sh
```

### Check Jira log
```
docker exec -it jira-docker-sandbox-jira-1 bash
tail -f /var/atlassian/application-data/jira/log/atlassian-jira.log
```

### Access Jira
Once the container is running, open:

http://localhost:8090

You should see the Jira setup wizard or your restored instance.

You can get a license for testing here:

https://developer.atlassian.com/platform/marketplace/timebomb-licenses-for-testing-server-apps/

### Stop Jira
```
./stop.sh
```

### Reset all volumes (dangerous)
```
./reset.sh
```

### Backup volumes
```
./backup.sh
```

### Restore from the latest backups
```
./restore.sh
```

---

## Notes

- Volumes are persistent unless removed with `reset.sh`.
- Backups are stored as tar.gz files in the repository directory.
- Restore script automatically finds the latest backup.

---

## Reference Links

- Jira Software Release Notes: https://confluence.atlassian.com/jirasoftware/jira-software-release-notes-776821069.html
- Atlassian End of Support Policy: https://confluence.atlassian.com/support/atlassian-end-of-support-policy-201851003.html

---

## Acknowledgements

This repository was originally forked from:  
https://github.com/collabsoft-net/example-jira-app-with-docker-compose  
Thanks to the original authors for providing a helpful baseline.
