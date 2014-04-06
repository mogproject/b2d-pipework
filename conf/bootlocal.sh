#!/bin/sh

# SSH key
mkdir -p /home/docker/.ssh
cat /var/lib/boot2docker/keys/*.pub > /home/docker/.ssh/authorized_keys

# Pipework
ln -s /var/lib/boot2docker/bin/pipework /usr/local/bin/pipework

# Add to host-only network
ip addr add {{HOSTONLY_VBOX_ADDRESS}} dev eth1
ip link set eth1 up

