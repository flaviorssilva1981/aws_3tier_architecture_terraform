#!/bin/bash

# Register Suse Cloud

SUSEConnect --de-register
SUSEConnect --cleanup
rm -f /etc/SUSEConnect
rm -rf /etc/zypp/credentials.d/*
rm -rf /etc/zypp/repos.d/*
rm -f /etc/zypp/services.d/*
registercloudguest
sleep 3
zypper refresh
sleep 2

# Partition the volume /hana/log

sudo zypper install -y lvm2
sudo sleep 2
sudo parted /dev/nvme8n1 --script mklabel gpt
sudo parted /dev/nvme8n1 --script mkpart primary 0% 100%
sudo parted /dev/nvme8n1 set 1 lvm on
sudo partprobe /dev/nvme8n1
# Create Physical Volume (PV)
sudo pvcreate /dev/nvme8n1p1
# Create Volume Group (VG)
sudo vgcreate vghanalog /dev/nvme8n1p1
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

#sudo yum install lvm2 -y
#sudo sleep 2
sudo parted /dev/nvme3n1 --script mklabel gpt
sudo parted /dev/nvme3n1 --script mkpart primary 0% 100%
sudo parted /dev/nvme3n1 set 1 lvm on
sudo partprobe /dev/nvme3n1
# Create Physical Volume (PV)
sudo pvcreate /dev/nvme3n1p1
# Create Volume Group (VG)
sudo vgcreate vghanadata /dev/nvme3n1p1
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

#sudo yum install lvm2 -y
#sudo sleep 2
sudo parted /dev/nvme7n1 --script mklabel gpt
sudo parted /dev/nvme7n1 --script mkpart primary 0% 100%
sudo parted /dev/nvme7n1 set 1 lvm on
sudo partprobe /dev/nvme7n1
# Create Physical Volume (PV)
sudo pvcreate /dev/nvme7n1p1
# Create Volume Group (VG)
sudo vgcreate vghanashared /dev/nvme7n1p1
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

#sudo yum install lvm2 -y
#sudo sleep 2
sudo parted /dev/nvme6n1 --script mklabel gpt
sudo parted /dev/nvme6n1 --script mkpart primary 0% 100%
sudo parted /dev/nvme6n1 set 1 lvm on
sudo partprobe /dev/nvme6n1
# Create Physical Volume (PV)
sudo pvcreate /dev/nvme6n1p1
# Create Volume Group (VG)
sudo vgcreate vghanabackup /dev/nvme6n1p1
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

#sudo yum install lvm2 -y
#sudo sleep 2
sudo parted /dev/nvme4n1 --script mklabel gpt
sudo parted /dev/nvme4n1 --script mkpart primary 0% 100%
sudo parted /dev/nvme4n1 set 1 lvm on
sudo partprobe /dev/nvme4n1
# Create Physical Volume (PV)
sudo pvcreate /dev/nvme4n1p1
# Create Volume Group (VG)
sudo vgcreate vgusrsap /dev/nvme4n1p1
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

#sudo yum install lvm2 -y
#sudo sleep 2
sudo parted /dev/nvme5n1 --script mklabel gpt
sudo parted /dev/nvme5n1 --script mkpart primary 0% 100%
sudo parted /dev/nvme5n1 set 1 lvm on
sudo partprobe /dev/nvme5n1
# Create Physical Volume (PV)
sudo pvcreate /dev/nvme5n1p1
# Create Volume Group (VG)
sudo vgcreate vgswap /dev/nvme5n1p1
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
swapon -v /dev/mapper/vgswap-lvswap
# Add to /etc/fstab for automatic mount on boot
sudo echo '/dev/vgswap/lvswap swap swap defaults,nofail 0 0' >> /etc/fstab


## Create user and key


