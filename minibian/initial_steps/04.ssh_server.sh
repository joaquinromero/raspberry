#!/bin/bash
apt-get install openssh-server
cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.original_copy
