#!/bin/bash
# Must sudo to run

lsblk
echo ""
echo -n "What device do you want to add (q for quit)? "
read device
if [ $device == 'q' ]; then
    exit 0
fi

dev="/dev/$device"
echo $dev

file -s $dev | grep :\ data &> /dev/null
if [ $? == 0 ]; then
    # Need new filesystem
    mkfs -t ext4 $dev
fi

echo -n "Provide the mount point: "
read mount

mkdir -p $mount
chmod 777 $mount

cat /etc/fstab > /etc/fstab.orig
uuid="UUID=$(lsblk $dev -no UUID)"
echo $uuid
echo "$uuid $mount ext4 defaults,nofail 0 2" >> /etc/fstab
mount -a
