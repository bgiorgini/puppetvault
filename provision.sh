#!/bin/bash -eu

hosts_section_desc="vagrant hosts"
hosts_file="/etc/hosts"
provision_hosts="/tmp/vagrant_hosts"

ed_script_common="# start ${hosts_section_desc} do not edit or remove this line
# end ${hosts_section_desc} do not edit or remove this line
.
-1
.r ${provision_hosts}
w
"
 
ed_script_insert="i
${ed_script_common}"

ed_script_edit="/^# start ${hosts_section_desc}/,/^# end ${hosts_section_desc}/c
${ed_script_common}"

if ! echo "$ed_script_edit"   | ed "${hosts_file}"
then
     echo "$ed_script_insert" | ed "${hosts_file}"
fi

