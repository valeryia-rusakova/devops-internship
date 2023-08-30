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

#Create user and group
sudo useradd -m bob
sudo groupadd tech_group
sudo usermod -aG tech_group bob

#Check if there is network with host machine
ping 172.20.10.7 #host machine ip address

#Allow remote password auth for bob
sudo nano /etc/ssh/sshd_config #Change password authentication
sudo service sshd restart

#Set password complexity
sudo apt install libpam-pwquality
sudo cp /etc/pam.d/common-password /etc/pam.d/common-password.bak #backup
sudo vim /etc/pam.d/common-password #set password complexity

#Add permission for tech_group
sudo visudo -f /etc/sudoers

#Add one more user and add it to the group
sudo useradd -m smith
sudo usermod -aG tech_group smith
