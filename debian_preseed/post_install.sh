#!/bin/bash -eu

# this is for debian like oses

PATH="/usr/sbin:/usr/bin:/sbin:/bin"
export PATH

newhncmnd="curl -s http://www.computernamer.com/ | grep -o 'entries/[0-9]\+-[^/\"]\+' | sort -u | awk -F- '{print \$2;exit}'"
newhn="$(sh <<< $newhncmnd)"        ; sleep 1
newhn="$newhn-$(sh <<< $newhncmnd)" ; sleep 1
newhn="$newhn-$(sh <<< $newhncmnd)"

oldhn="$(hostname -s)"

hostname "$newhn"
echo "$newhn" > /etc/hostname
sed -i 's|\(\s\)'"$oldhn"'[^a-zA-Z0-9-]*|\1'"$newhn"'|g' /etc/hosts
sed -i 's|^START=no$|START=yes|' /etc/default/puppet

# echo x.x.x.x puppet >> /etc/hosts

