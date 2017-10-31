#!/bin/bash

#Install udisks-glue to automount usb drives without starting the desktop.
# install udisks-glue
apt-get install udisks-glue policykit-1
# edit config file to enable automount
sed -i '/^match disks /a\    automount = true' /etc/udisks-glue.conf

#Supervisor provides a simple way to add user services, without messing with SysV or other init scripts.
apt-get install supervisor

nano /etc/supervisor/conf.d/udisks-glue.conf:
--------------------------------------------------------
[program:udisks-glue]
user = pi
command = udisks-glue -f
autostart = true
autorestart = true
stdout_logfile = /var/log/supervisor/udisks-glue-out.log
stderr_logfile = /var/log/supervisor/udisks-glue-err.log
--------------------------------------------------------
# reload supervisor config
supervisorctl reload

#The udisks-glue program should start automatically on boot. Use supervisorctl with start, stop, and restart to manually control Supervisor programs: supervisorctl restart udisks-glue.
