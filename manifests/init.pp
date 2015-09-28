# == Class: globus
#
# Full description of class globus here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'globus':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class globus(

) inherits globus::params {

  include globus::repo

  file { $globus_connect_server_conf:
    ensure  => present,
    content => template('globus/globus-connect-server.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$globus::params::globus_connect_server_package],
  }

  package { $globus::params::globus_connect_server_package:
    ensure  => present,
    require => Class['globus::repo']
  }

}