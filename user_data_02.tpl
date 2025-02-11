#!/bin/bash

# Partition the volume /hana/log

sudo yum install lvm2 -y
sudo sleep 2
sudo parted /dev/xvdb --script mklabel gpt
sudo parted /dev/xvdb --script mkpart primary 0% 100%
sudo parted /dev/xvdb set 1 lvm on
sudo partprobe /dev/xvdb
# Create Physical Volume (PV)
sudo pvcreate /dev/xvdb1
# Create Volume Group (VG)
sudo vgcreate vghanalog /dev/xvdb1
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


# Partition the volume /hana/data

sudo yum install lvm2 -y
sudo sleep 2
sudo parted /dev/xvdc --script mklabel gpt
sudo parted /dev/xvdc --script mkpart primary 0% 100%
sudo parted /dev/xvdc set 1 lvm on
sudo partprobe /dev/xvdc
# Create Physical Volume (PV)
sudo pvcreate /dev/xvdc1
# Create Volume Group (VG)
sudo vgcreate vghanadata /dev/xvdc1
# Create Logical Volume (LV)
sudo lvcreate -l 100%FREE vghanadata -n lvhanadata
# Format the Logical Volume with XFS
sudo mkfs.xfs /dev/vghanadata/lvhanadata
# Create mount point
sudo mkdir -p /hana/data
# Mount the volume
sudo mount /dev/vghanadata/lvhanadata /hana/data
# Add to /etc/fstab for automatic mount on boot
sudo echo '/dev/vghanadata/lvhanadata /hana/data xfs defaults,nofail 0 0' >> /etc/fstab

# Partition the volume /hana/shared

sudo yum install lvm2 -y
sudo sleep 2
sudo parted /dev/xvdd --script mklabel gpt
sudo parted /dev/xvdd --script mkpart primary 0% 100%
sudo parted /dev/xvdd set 1 lvm on
sudo partprobe /dev/xvdd
# Create Physical Volume (PV)
sudo pvcreate /dev/xvdd1
# Create Volume Group (VG)
sudo vgcreate vghanashared /dev/xvdd1
# Create Logical Volume (LV)
sudo lvcreate -l 100%FREE vghanashared -n lvhanashared
# Format the Logical Volume with XFS
sudo mkfs.xfs /dev/vghanashared/lvhanashared
# Create mount point
sudo mkdir -p /hana/shared
# Mount the volume
sudo mount /dev/vghanashared/lvhanashared /hana/shared
# Add to /etc/fstab for automatic mount on boot
sudo echo '/dev/vghanashared/lvhanashared /hana/shared xfs defaults,nofail 0 0' >> /etc/fstab

# Partition the volume /hana/backup

sudo yum install lvm2 -y
sudo sleep 2
sudo parted /dev/xvde --script mklabel gpt
sudo parted /dev/xvde --script mkpart primary 0% 100%
sudo parted /dev/xvde set 1 lvm on
sudo partprobe /dev/xvde
# Create Physical Volume (PV)
sudo pvcreate /dev/xvde1
# Create Volume Group (VG)
sudo vgcreate vghanabackup /dev/xvde1
# Create Logical Volume (LV)
sudo lvcreate -l 100%FREE vghanabackup -n lvhanabackup
# Format the Logical Volume with XFS
sudo mkfs.xfs /dev/vghanabackup/lvhanabackup
# Create mount point
sudo mkdir -p /hana/backup
# Mount the volume
sudo mount /dev/vghanabackup/lvhanabackup /hana/backup
# Add to /etc/fstab for automatic mount on boot
sudo echo '/dev/vghanabackup/lvhanabackup /hana/backup xfs defaults,nofail 0 0' >> /etc/fstab


# Partition the volume /usr/sap

sudo yum install lvm2 -y
sudo sleep 2
sudo parted /dev/xvdf --script mklabel gpt
sudo parted /dev/xvdf --script mkpart primary 0% 100%
sudo parted /dev/xvdf set 1 lvm on
sudo partprobe /dev/xvdf
# Create Physical Volume (PV)
sudo pvcreate /dev/xvdf1
# Create Volume Group (VG)
sudo vgcreate vgusrsap /dev/xvdf1
# Create Logical Volume (LV)
sudo lvcreate -l 100%FREE vgusrsap -n lvusrsap
# Format the Logical Volume with XFS
sudo mkfs.xfs /dev/vgusrsap/lvusrsap
# Create mount point
sudo mkdir -p /usr/sap
# Mount the volume
sudo mount /dev/vgusrsap/lvusrsap /usr/sap
# Add to /etc/fstab for automatic mount on boot
sudo echo '/dev/vgusrsap/lvusrsap /usr/sap xfs defaults,nofail 0 0' >> /etc/fstab

# Partition the volume swap

sudo yum install lvm2 -y
sudo sleep 2
sudo parted /dev/xvdg --script mklabel gpt
sudo parted /dev/xvdg --script mkpart primary 0% 100%
sudo parted /dev/xvdg set 1 lvm on
sudo partprobe /dev/xvdg
# Create Physical Volume (PV)
sudo pvcreate /dev/xvdg1
# Create Volume Group (VG)
sudo vgcreate vgswap /dev/xvdg1
# Create Logical Volume (LV)
sudo lvcreate -l 100%FREE vgswap -n lvswap
# Format the Logical Volume with XFS
sudo mkfs.xfs /dev/vgswap/lvswap
# Create mount point
sudo mkdir -p /swap
# Mount the volume
#sudo mount /dev/vgswap/lvswap /swap
# Make a swap
mkswap /dev/vgswap/lvswap
# Tun swap on
swapon
# Verify if swap is on
#swapon -v /dev/mapper/vgswap-lvswap
# Add to /etc/fstab for automatic mount on boot
sudo echo '/dev/vgswap/lvswap /swap xfs defaults,nofail 0 0' >> /etc/fstab
