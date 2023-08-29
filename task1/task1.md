# Task 1

## sudo fdisk /dev/sdb

We press "n" to create a new partition. Then press "p" to specify partition type and "1"(in case of /home directory) to specify partition number.
Next we choose the size of the partition(+8G for /home and +6,5G for /var/log).
Then we press "w" to save all changes.

## Allow remote password auth for bob

We need to change /etc/ssh/sshd-config file and add next lines:
Match User Bob
PasswordAuthentication yes (remove #)
Match all

## Set password complexity

After installing the libpam-pwquality we need to change /etc/pam.d/common-password file.
Set minlen=14 dcredit=-1 lcredit=-1 in the following line: password requisite.
