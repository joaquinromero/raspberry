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
     automount_options = {'noatime','sync','umask=007'}
     post_mount_command = 'echo "Devicd %device_file mounted in %mount_point"'
}

default {
        post_insertion_command = 'echo "Device %device_file did not match any rules."; ls -al "%device_file"; echo "blkid: $(/sbin/blkid %device_file)"; /usr/bin/udisks --show-info %device_file'
}
#-------------------------------------------------------------
#añadir usuarios al grupo
usermod -a -G mountgr <user>
#arrancar servicio
systemctl enable udisks-glue.service
#ver logs
journalctl -u udisks-glue.service

