
# main site definition

node 'puppet'
{
  # puppet
}

node 'web'
{
  # web
}

node 'db'
{
  # db
}

node 'mail'
{
  # mail
}

class ssh::params {
  case $::osfamily {
    'Debian': {
      $sshd_package  = "ssh"
      $sshd_service  = "ssh"
    }
    'RedHat': {
      $sshd_package  = "openssh-server"
      $sshd_service  = "sshd"
    }
    default:  {fail("Login class does not work on osfamily: ${::osfamily}")}
  }
}

class ssh (
  manage_package = false,
  manage_service = false,
  package_name   = $::ssh::params::sshd_package
  ) inherits ssh::params {
    if $manage_package == true {
      package { $package_name:
        ensure => installed,
      }
    }
    if $manage_service == true {
      service { $::ssh::params::sshd_service:
        ensure => running,
      }
    }
  }

class { 'ssh':
  manage_package => true,
  manage_service   => true,
}

include ssh 

