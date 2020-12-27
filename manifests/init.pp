# == Class: hostname
#
# Set up fancontrol service
#
# === Parameters
#
# === Example
#
#   class { 'fancontrol': }
#

class fancontrol (
  String $fancontrol_config,
  Array[String] $modules = ['coretemp', 'jc42', 'w83627ehf', 'w83795']
) {
  package { 'lm_sensors': }

  -> file { '/etc/conf.d/lm_sensors':
    ensure  => file,
    content => template('fancontrol/lm_sensors.conf.erb')
  }

  -> service { 'lm_sensors':
    ensure => running,
    enable => true
  }

  -> file { '/etc/fancontrol':
    ensure  => file,
    content => $fancontrol_config
  }
}
