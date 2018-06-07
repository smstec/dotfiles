#!/bin/bash
# Must sudo to run

# Get the list of block devices
lsblk

# Get device id from the user
echo ""
echo -n "What device do you want to add (q for quit)? "
read device

# Quit if told
if [ $device == 'q' ]; then
    exit 0
fi

# Print full device path
dev="/dev/$device"
echo $dev

# Determine need for filesystem
file -s $dev | grep :\ data &> /dev/null
if [ $? == 0 ]; then
    # Need new filesystem
    mkfs -t ext4 $dev
fi

echo -n "Provide the mount point (q for quit): "
read mount
# Quit if told
if [ $mount == 'q' ]; then
    exit 0
fi

# Create the mount point
mkdir -p $mount

# Update fstab to automount
# Save fstab to another file
cat /etc/fstab > /etc/fstab.orig
# Get UUID
uuid="UUID=$(lsblk $dev -no UUID)"
echo $uuid
# Write mount point into fstab
echo "$uuid $mount ext4 defaults,nofail 0 2" >> /etc/fstab
# Mount everything
mount -a

# Update permissions to allow everyone to rwx
chmod 777 $mount
