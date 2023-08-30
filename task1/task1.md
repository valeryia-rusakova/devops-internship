# Task 1

## sudo fdisk /dev/sdb

We press "n" to create a new partition. Then press "p" to specify partition type and "1"(in case of /home directory) to specify partition number.
Next we choose the size of the partition(+8G for /home and +6,5G for /var/log).
Then we press "w" to save all changes.

## Allow remote password auth for bob

We need to change **/etc/ssh/sshd_config** file and add next lines:  
**Match User bob**  
**PasswordAuthentication yes**  
**Match all**  

## Set password complexity

After installing the libpam-pwquality we need to change /etc/pam.d/common_password file.
Set **minlen=14 dcredit=-1 lcredit=-1** in the following line: **password requisite**.

## Add permission for tech_group

Write the following line: **%tech_group ALL=(ALL:ALL) ALL**
to allow members of tech_group to execute commands as root

## Add ssh key to smith authorized_keys

First we need to generate ssh key pair using **ssh-keygen** command.
Then we need to login as smith and connect to our host machine via ssh using password (to create .ssh/ directory).
### Login as smith
**su smith**
### Connect to host machine via ssh
**ssh valeryia@172.20.10.7**
The .ssh/ directory was generated. Now we can create authorized_keys file and put the generated public key there.
Finally we are ready to connect to Linux from host machine using the following command:  
**ssh -i ./mykey smith@172.20.10.9** (we are using private key, not public)

## Ban smith to connect remotely using password
We need to change **/etc/ssh/sshd_config** file and add the following lines:  
Match User bob  
PasswordAuthentication yes  
**Match User smith**  
**PasswordAuthentication no**  
Match all  

## Create permanent env variable for smith
We need to login as smith and add the following line to the end of **~/.profile**, **~/.bashrc** files:  
**export USER_DESCRIPTION='The user for secure access'**

## Mount local folder
First we need to create a shared folder from Virtual Box Manager and enable auto-mounting. Then we need to be member of the group **vboxsf** to have access to these folder.
