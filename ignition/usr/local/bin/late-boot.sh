#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

useradd mikedanese \
  --create-home \
  --password "" \
  --shell /bin/bash \
  --base-dir /home/ \
  || true

cat <<EOF > /etc/sudoers.d/00_root
mikedanese  ALL=(ALL:ALL) NOPASSWD:ALL
root        ALL=(ALL:ALL) ALL
EOF

mkdir -p /home/mikedanese/.ssh/

cat <<EOF > /home/mikedanese/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkK7goCQ6zbAk5zzgu75ByCEUbCODc5gyaISQyDQHxfxqgvRSbEYf9V7ATEKhhnqPEV7H1UYX2vXokp550wa4gK4i7xA6emXgLeK+Sdxgny+TGDo7EzL9V7vGJoNNorsYJyCbLtfknWi731GvMAk1N7tNtuuw5Tz8KoavB4gdsKZV+cmhqEbTcyGZvkiLz3ZhjW9oGFIqimz58tNnTKOecK/BXKNKfS3F1ct9suOYrubvw3py+oXy6g45U9UmnsR9M0tQ9pGdBPwyGDcog0lg6n4yuQqp1rvZwZGifGoy8vHoBZwioPqBKunHQnBnvQNbb9IZFB6kKvf2PmiqHimSB mikedanese@ubuntu
EOF
chmod 0440 /home/mikedanese/.ssh/authorized_keys
chown root:root /home/mikedanese/.ssh/authorized_keys

chmod 0644 /home/mikedanese/.ssh/authorized_keys
chown -R mikedanese /home/mikedanese/.ssh/authorized_keys

if [[ ! -f "/etc/ssh/ssh_host_rsa_key" ]]; then
  ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ""
fi

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y htop byobu stress git zsh systemd-container

echo done
