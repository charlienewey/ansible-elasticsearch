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


## Reverse-Proxy Nodes

Reverse-proxy nodes have a basic `nginx` configuration deployed that acts as a
combination of reverse-proxy and load-balancer for the Elasticsearch master
nodes. Nginx acts as a reverse proxy for Elasticsearch that **only** allows
access to the `_search` endpoint of the Elasticsearch API. This allows an
administrator to expose the `es_safe_port` outside of a firewall and know that
any access will be logged, and only safe requests are allowed. This can be
configured further by editing the Jinja2 template for the `nginx`
configuration file in the [./roles/nginx/templates](./roles/nginx/templates)
directory.
