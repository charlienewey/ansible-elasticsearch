#! /bin/sh
# Script to create an Elasticsearch snapshot repository

snapshot_repo_create() {
    curl -XPUT 'localhost:9200/_snapshot/backup/?wait_for_completion=true' -d '{
        "type": "fs",
        "settings": {
            "location": "/elasticsearch_snapshot",
            "compress": "true"
        }
    }';
}

# Main
snapshot_repo_create

exit 0
