#!/bin/bash -ex
# Add sec groups for basic access to all profiles
secgroup=${1:-`openstack security group list |grep default| awk '{print $2}'`}

for group in $secgroup; do

    for port in 22 53 80 81 443 9443; do  # LA_TEMP
        openstack security group rule create $group --proto tcp --remote-ip 0.0.0.0/0 --dst-port $port ||:
    done

    openstack security group rule create $group --proto icmp --remote-ip 0.0.0.0/0 ||:
done

