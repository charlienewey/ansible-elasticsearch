# Elasticsearch Cluster with Ansible

This playbook should be enough to set up a rudimentary Elasticsearch cluster
with things such as automatic snapshotting (with `cron` jobs) and reverse
proxying for access control (with `nginx`) automatically configured.

To achieve this, there need to be two types of machines configured in this
playbook: *masters* and *workers*. Both will have slightly different
configuration options, so I'll briefly summarise the similarities and
differences between the two.


## Common Elements

Both *master* and *worker* nodes will have certain common elements including
(obviously) a common Java version and Elasticsearch version.

The following tasks get applied to *both* sets of machines:
* Full system update/upgrade
* Remove GCJ Java and install OpenJDK
* Install and configure Elasticsearch
* Configure IPTables rules (open ports 9201-9300 for inter-node communication)


## Master Nodes

Master nodes have an extra set of software and configuration changes applied
to them. Master nodes have a script deployed that backs up the Elasticsearch
indices automatically, and they also have a `cron` job configured that runs
this script on a regular basis. The script keeps 6 weeks' worth of backups
before deleting old ones.

In addition to this, they also have a basic nginx configuration deployed.
Nginx acts as a reverse proxy for Elasticsearch, that restricts **ALL** access
to Elasticsearch APIs unless they are submitted through a **GET** request.
