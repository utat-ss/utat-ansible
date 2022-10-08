# utat-ansible
Collection of Ansible scripts for UTAT IT. 

## Current Playbooks
* `install-go`: Installs [go](https://golang.org/). Duh. 
* `install-duplicacy`: Installs latest [duplicacy](https://github.com/gilbertchen/duplicacy) from source
* `duplicacy-init`: Initializes duplicacy to backup to Google Drive via cron, using a basic filter set
* `duplicacy-maint`: Runs basic maintenance on a duplicacy backup, including exhaustive prune and integrity checking. 
* `duplicacy-update-filters`: Replaces Duplicacy's filters with the filters in this repo
* `install-docker-slack-viewer`: Creates a Docker image that runs [slack-export-viewer](https://github.com/hfaran/slack-export-viewer)
* `copy-slack-export`: Copies a Slack export to a server with slack-export-viewer
