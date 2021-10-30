# Duplicacy Configuration

## Installation
The two prerequisites are golang with go-dep, and Duplicacy. 

Duplicacy **must** be installed from source at this time. 
For Google Drive backups to work properly, we need [this commit](https://github.com/gilbertchen/duplicacy/commit/e43e848d47176144049b93938f09820c61effc72). 
However, the current compiled executable is out of date, thus we must compile from source. 

This is not a trivial task, as there it relies on the now-depreciated go-dep and has some broken dependencies. 
I highly recommend installing using [this](https://github.com/eosti/utat-ansible/blob/main/install-duplicacy.yml) Ansible playbook to install, as it will apply the various patches as needed. 

The Duplicacy initialization is also [automated](https://github.com/eosti/utat-ansible/blob/main/duplicacy-init.yml) with Ansible, for ease of deployment. 
It will create this directory and README (hello!), and initialize Duplicacy with the root directory as its repository. 
It will also add a basic filter list that aims to backup nearly all important files, while leaving out redundant system files. 

Backups are scheduled daily at 4am, and will prune automatically to retain daily backups for a month, weekly backups for 180 days, and monthly backups past that.
This is all done by the sudo crontab. 

Duplicacy must be run as root to access all of the system and user files to backup, so the Duplicacy settings and crontab are all installed for the root user. 

Author: Reid Sox-Harris

October 30 2021
