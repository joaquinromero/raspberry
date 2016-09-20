#!/bin/bash
#Start fdisk:
fdisk /dev/mmcblk0

#Then delete partitions with d and create a new with n. You can view the existing table with p.
#
#    p to see the current start of the main partition
#    d, 2 to delete the main partition
#    n p 2 to create a new primary partition, next you need to enter the start of the old main partition and then the size (enter for complete SD card). The main partition on Minibian image from 2015-11-12 starts at 125056, but the start of your partition might be different. Check the p output!
#    w write the new partition table
reboot
#Now you need to reboot.
#After the reboot you need to resize the filesystem on the partition. The resize2fs command will resize your filesystem to the new size from the changed partition table.
resize2fs /dev/mmcblk0p2

#This will take a few minutes, depending on the size and speed of your SD card.

#When it is done, you can check the new size with:
df -h
