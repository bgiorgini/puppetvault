#!/bin/bash -eu

hosts_section_desc="vagrant hosts"
hosts_file="/etc/hosts"
provision_hosts="/tmp/vagrant_hosts"
disclaimer="do not edit or remove this line"

ed_script_common="# start ${hosts_section_desc} ${disclaimer}
# end ${hosts_section_desc} ${disclaimer}
.
-1
.r ${provision_hosts}
w
"
 
ed_script_insert="i
${ed_script_common}"

ed_script_edit="/^# start ${hosts_section_desc}/,/^# end ${hosts_section_desc}/c
${ed_script_common}"

if ! ed "${hosts_file}" <<< "$ed_script_edit"
then
     echo >> /etc/hosts
     echo >> /etc/hosts
     ed "${hosts_file}" <<< "$ed_script_insert"
fi

apt-get update
apt-get install -y puppet

sed -i 's|^START=no$|START=yes|' /etc/default/puppet

service puppet start

if [ "$(hostname)" = "puppet" ]
then
  apt-get install -y puppetmaster
fi

