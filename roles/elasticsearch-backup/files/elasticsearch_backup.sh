#! /bin/sh
# Script to backup Elasticsearch indices (and delete old ones)

backup_create() {
    curl -XPUT "localhost:9200/_snapshot/backup/snapshot_$(date +'%Y-%m-%d')?wait_for_completion=true&pretty=true";
}

clear_old_backup() {
    curl -XDELETE "localhost:9200/_snapshot/backup/snapshot_$(date --date="5 weeks ago" +"%Y-%m-%d")?wait_for_completion=true&pretty=true";
}

# Main
backup_create
clear_old_backup

exit 0
