# Class: ius
#
# This class installs the ius repository
#
# Parameters:
#
#  ensure: (default latest)
#    Determine the state of the packages
#
# Actions:
#   - Installs the ius repository
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'ius':
#      ensure => 'latest'
#    }
#
#  To remove the installation, use:
#
#    class { 'ius':
#      ensure => 'absent'
#    }
#
class ius (
  $ensure = $::ius::params::ius_package_ensure
) inherits ::ius::params {
  package { $::ius::params::ius_package:
    ensure  => $ensure,
  }

}
