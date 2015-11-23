#!/bin/busybox sh

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# drops into a shell
#  Usage: mount o ro /dev/nothing /mnt/root || rescue_shell
rescue_shell() {
    echo "Something went wrong. Dropping to a shell."
    exec sh
}

# parses and prints the kernel cmdline
cmdline() {
  local value
  value=" $(cat /proc/cmdline) "
  value="${value##* $1=}"
  value="${value%% *}"
  [ "$value" != "" ] && echo "$value"
}

mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

# Do your stuff here.
echo "This script just mounts and boots the rootfs, nothing else!"
echo "The command line is $(cmdline)!"
 
# Mount the root filesystem.
mount -o rw /dev/sda /mnt/root
 
# Clean up.
umount /proc
umount /sys
 
# Boot the real thing.
exec switch_root /mnt/root /sbin/init
