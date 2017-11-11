#!/bin/bash

#Install udisks-glue to automount usb drives without starting the desktop.
# install udisks-glue
apt-get install udisks-glue policykit-1

#add system user with no login
useradd -r mountgr

nano /etc/systemd/system/udisks-glue.service
#-------------------------------------------------------------
[Unit]
Description = mount disks automatically with standby
After = local-fs.target

[Service]
User = jok
Group = mountgr
Type = simple
#ExecStartPre = /bin/bash -c "rmdir /media/*/ 2>/dev/null; time udevadm settle; exit 0"
ExecStart = /usr/bin/udisks-glue -c /etc/udisks-glue.conf --foreground

[Install]
WantedBy = multi-user.target
#-------------------------------------------------------------
nano /etc/polkit-1/localauthority/50-local.d/50-mount-as-mountgr.pkla
#-------------------------------------------------------------
[Media mounting by mountgr]
Identity=unix-group:mountgr
Action=org.freedesktop.udisks.filesystem-mount
ResultAny=yes
#-------------------------------------------------------------
nano /etc/udisks-glue.conf
#-------------------------------------------------------------
filter disks {
    optical = false
    partition_table = false
    usage = filesystem
}

match disks {
    automount = true
#    automount_options = {sync,umask=000}
    post_insertion_command = "udisks --mount %device_file --mount-options sync,umask=007"
}
#-------------------------------------------------------------
#añadir usuarios al grupo
usermod -a -G mountgr <user>
