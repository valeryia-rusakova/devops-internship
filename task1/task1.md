Task 1

sudo fdisk /dev/sdb

We press "n" to create a new partition. Then press "p" to specify partition type and "1"(in case of /home directory) to specify partition number.
Next we choose the size of the partition(+8G for /home and +6,5G for /var/log).
Then we press "w" to save all changes.
