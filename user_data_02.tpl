#!/bin/bash
# Partition the volume
sudo yum install lvm2 -y
sudo sleep 2
sudo parted /dev/xvdf --script mklabel gpt
sudo parted /dev/xvdf --script mkpart primary 0% 100%
sudo parted /dev/xvdf set 1 lvm on
sudo partprobe /dev/xvdf
# Create Physical Volume (PV)
sudo pvcreate /dev/xvdf1
# Create Volume Group (VG)
sudo vgcreate vghanalog /dev/xvdf1
# Create Logical Volume (LV)
sudo lvcreate -l 100%FREE vghanalog -n lvhanalog
# Format the Logical Volume with XFS
sudo mkfs.xfs /dev/vghanalog/lvhanalog
# Create mount point
sudo mkdir -p /hana/log
# Mount the volume
sudo mount /dev/vghanalog/lvhanalog /hana/log
# Add to /etc/fstab for automatic mount on boot
sudo echo '/dev/vghanalog/lvhanalog /hana/log xfs defaults,nofail 0 0' >> /etc/fstab