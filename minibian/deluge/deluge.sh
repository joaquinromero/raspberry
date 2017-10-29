# reference http://dev.deluge-torrent.org/wiki/UserGuide/ThinClient#DelugeDaemonSetup
# reference http://dev.deluge-torrent.org/wiki/UserGuide/Service/systemd

apt-get install deluged
# For security create an user using the following command (a new system user and group named deluge with no login access and home directory: /var/lib/deluge ):
adduser --system  --gecos "Deluge Service" --disabled-password --group --home /var/lib/deluge deluge
#Add to the deluge group any users you wish to be able to easily manage or access files downloaded through Deluge, for example:
adduser <username> deluge

#Remove any old init.d files named deluge in /etc/init.d/ like this:
rm /etc/init.d/deluged

#Deluge Daemon (deluged) Service
#Create the file /etc/systemd/system/deluged.service containing the following:
------------------------------
[Unit]
Description=Deluge Bittorrent Client Daemon
Documentation=man:deluged
After=network-online.target
[Service]
Type=simple
User=deluge
Group=deluge
UMask=007
ExecStart=/usr/bin/deluged -d
Restart=on-failure
# Time to wait before forcefully stopped.
TimeoutStopSec=300
[Install]
WantedBy=multi-user.target
--------------------------------
#    You may wish to modify the above umask as it applies to any files downloaded by deluged.
#        007 grants full access to the user and members of the group deluged is running as (in this case deluge) and prevents access from all other accounts.
#        022 grants full access to the user deluged is running as and only read access to other accounts.
#        002 grants full access to the user and group deluged is running as and only read access to other accounts.
#        000 grants full access to all accounts. 

#Now enable it to start up on boot, start the service and verify it is running:
systemctl enable /etc/systemd/system/deluged.service
systemctl start deluged
systemctl status deluged

# Enable remote connection
systemctl stop deluged
# In file /var/lib/deluge/.config/deluge/core.conf change to true "allow_remote"
-----------------------------
"allow_remote": true
-----------------------------
# Setup a remote user in file /var/lib/deluge/.config/deluge/auth
-----------------------------
user:pass:10
-----------------------------
systemctl start deluged
# conect deluge client on port 58846

# Logging
#Create a log directory for Deluge and give the service user (e.g. deluge), full access:
# sudo mkdir -p /var/log/deluge
# sudo chown -R deluge:deluge /var/log/deluge
# sudo chmod -R 750 /var/log/deluge
#     The deluge log directory is now configured so that user deluge has full access, group deluge read only and everyone else denied access. The umask specified in the services sets the permission of new log files. 
# Enable logging in the service files by editing the ExecStart line, appending -l and -L options:
# ExecStart=/usr/bin/deluged -d -l /var/log/deluge/daemon.log -L warning
#     See Deluge Logging for all available log-levels. 
# Restart the services:
# sudo systemctl restart deluged

# Log Rotation
# To enable log rotation create /etc/logrotate.d/deluge with the following code:
# 
# /var/log/deluge/*.log {
#         rotate 4
#         weekly
#         missingok
#         notifempty
#         compress
#         delaycompress
#         sharedscripts
#         postrotate
#                 systemctl restart deluged >/dev/null 2>&1 || true
#         endscript
# }

# Start deluged only if mount exists
# Use this if you have a usb disk drive or network drive that may not be immediately available on boot or disconnected at random.
# The following additions wait for those mountpoints before starting deluged. If they are unmounted or disconnected then deluged is stopped. When they become available again deluged is started.
# Ensure you have added the correct drive details to fstab or equivalent so they are mounted at boot.
# List the available drive mounts:
# sudo systemctl -t mount
# Look for your mount point in the Description column. Mounts are formatted similar to the mount point with - substituted for / in the path. Eg: media-xyz.mount
# Modify the [Unit] section of the deluged.service script. Substitute xyz.mount for the mount you want the service to depend on:
# [Unit]
# Description=Deluge Bittorrent Client Daemon
# # Start after network and specified mounts are available.
# After=network-online.target xyz.mount
# Requires=xyz.mount
# # Stops deluged if mount points disconnect
# BindsTo=xyz.mount

# For multiple mount points add a space between additional entries. Eg: After=network-online.target xyz.mount abc.mount def.mount
# Modify the [Install] section to ensure the deluged service is started when the mount point comes back online:
# [Install]
# WantedBy=multi-user.target xyz.mount
# Note: WantedBy seems to work on some distros and not others. Possibly different versions of systemd?
# Reference: ​systemd.unit
