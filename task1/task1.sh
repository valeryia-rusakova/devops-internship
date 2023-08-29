#!/bin/sh
# Create partition for /home
sudo fdisk /dev/sdb
sudo mkfs.ext4 /dev/sdb1
sudo mkdir -p /srv/home #dir for temporary mount
sudo mount /dev/sdb1 /srv/home
sudo rsync -av /home/* /srv/home/
sudo mv /home /home.bak
sudo mkdir /home
sudo umount /dev/sdb1
sudo mount /dev/sdb1 /home
sudo cp /etc/fstab /etc/fstab.bak #backup
sudo blkid /dev/sdb1 #copy UUID of the filesystem
sudo vim /etc/fstab #write UUID=copied /home ext4 defaults 0 2

#Create partition for /var/log
sudo fdisk /dev/sdb
sudo mkfs.ext4 /dev/sdb2
cd srv
sudo mkdir -p var/log
sudo mount dev/sdb2 /srv/var/log
sudo rsync -av /var/log/* /srv/var/log
sudo mv /var/log /var/log.bak #backup
sudo mkdir /var/log
sudo umount /dev/sdb2
sudo mount /dev/sdb2 /var/log
sudo blkid /dev/sdb2  #cope UUID of the filesystem
sudo vim /etc/fstab #write UUID=copied /var/log ext4 defaults 0 2
