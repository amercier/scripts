scripts
=======

Linux &amp; Windows scripts

Synology DiskStation Manager
----------------------------

# Synchronize GitHub repositories

## Requirements

- Git
- Ruby

## Installation

Login as root on your Synology (use admin's password as root password):

    $ ssh root@synology

Download the scripts:

    DiskStation> mkdir -p /root/scripts \
    && curl -sL https://raw.githubusercontent.com/amercier/scripts/master/dsm/github-list.rb -o /root/scripts/github-list.rb \
    && curl -sL https://raw.githubusercontent.com/amercier/scripts/master/dsm/github-sync.rb -o /root/scripts/github-sync.rb \
    && chmod 0700 /root/scripts/github-list.rb /root/scripts/github-sync.rb

Test the script (test twice to make sure the update is working as well):

    DiskStation> mkdir -p /tmp/test-github-sync
    DiskStation> SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt /root/scripts/github-sync.rb USERNAME /tmp/test-github-sync 'LOGIN:PASSORD'
    DiskStation> rm -rf /tmp/test-github-sync

Create a directory called /volume1/git:

    mkdir /volume1/git

Install the crontab script

    curl -sL https://raw.githubusercontent.com/amercier/scripts/master/dsm/crontab.sh -o /sbin/crontab && chmod +x /sbin/crontab

Add this line to your cron (`crontab -e`):

    * * * * * root SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt /root/scripts/github-sync.rb USERNAME /volume1/git 'LOGIN:PASSWORD'

Note: replace spaces by tabs
