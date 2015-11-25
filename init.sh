#!/bin/busybox sh

set -o errexit
set -o nounset
set -o pipefail

rescue_shell() {
    echo "Something went wrong. Dropping to a shell."
    exec sh
}

mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev
 
mount -o rw /dev/sda /mnt/root || rescure_shell

umount /proc
umount /sys
 
exec switch_root /mnt/root /sbin/init
