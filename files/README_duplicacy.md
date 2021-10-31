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

Duplicacy must be run as root to access all of the system and user files to backup, so the Duplicacy settings and crontab are all installed for the root user. 
The configuration files are located at `~root/duplicacy/`. 

## Backups
Backups are scheduled daily at 4am, and will prune automatically to retain daily backups for a month, weekly backups for 180 days, and monthly backups past that.
This is all done by the sudo crontab. 

Manual backups can be executed by running the command `duplicacy backup` as root while in the configuration directory. 

## Restoring
To view all snapshots, use `duplicacy list`. 

To restore to a specific snapshot, use `duplicacy restore -r <revision>`. 
This will restore *all* files from that revision, but without overwriting existing files. 
To overwrite existing files to do a complete rollback, use the `-overwrite` flag. 

To restore specific files, add an [include/exclude list](https://github.com/gilbertchen/duplicacy/wiki/Include-Exclude-Patterns) after the command. 

Other useful functions exist, such as `duplicacy diff` and `duplicacy history`, which may aid in selecting the right backup. 
Full documentation for the various commands can be found [here](https://github.com/gilbertchen/duplicacy/wiki). 

## Maintenance
Duplicacy is very low maintenance, so no actions need to be taken to ensure robust backups. 
However, there are a few items that may be performed occasionally to reduce backup size and verify integrity. 

Pruning is already done automatically every backup; however, pruning may be done manually to remove extra backups. 
This may be useful to remove super old backups to save storage space. 
Manually prune using `duplicacy prune` with specific options as shown in the [documentation](https://github.com/gilbertchen/duplicacy/wiki/prune). 

Running `duplicacy prune -exhaustive` may be able to clean up unreferenced chunks that have gotten lost at some point. 

Finally, running `duplicacy check -files` can be used to verify the full integrity of a snapshot. 
If this command finds any issues in the present snapshot, it is highly recommended to run a full backup using `duplicacy backup -hash`

Running an exhaustive prune and checking the snapshot can be run automatically using [this](https://github.com/eosti/utat-ansible/blob/main/duplicacy-maint.yml) Ansible playbook. 

***

Author: Reid Sox-Harris ([@eosti](https://github.com/eosti/))

October 31 2021 🎃
