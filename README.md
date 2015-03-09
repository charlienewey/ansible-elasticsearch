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
