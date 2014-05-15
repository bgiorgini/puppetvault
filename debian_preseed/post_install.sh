#!/bin/bash -eu

# this is for debian like oses

PATH="/usr/sbin:/usr/bin:/sbin:/bin"
export PATH

newhn=$(uuidgen)
oldhn=$(hostname)

hostname $newhn
echo $newhn > /etc/hostname
sed -i 's|\(\s\)'$oldhn'$|\1'$newhn'|g' /etc/hosts
sed -i 's|^START=no$|START=yes|' /etc/default/puppet

