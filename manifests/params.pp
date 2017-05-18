# Class: ius::params
#
# This class sets parameters used in this module
#
# Actions:
#   - Defines numerous parameters used by other classes
#   - Does not support other osfamily patterns - RedHat only
#
class ius::params {
  $ius_package_ensure = 'latest'

  case $::osfamily {
    'RedHat': {
      $ius_package = 'ius-release'

      case $::operatingsystem {
        default: {
          case $::operatingsystemmajrelease {
            default: {
              if ( !$::ius_installed ) {
                file { '/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY':
                  ensure => present,
                  owner  => 'root',
                  group  => 'root',
                  mode   => '0644',
                  source => 'puppet:///modules/ius/IUS-COMMUNITY-GPG-KEY',
                }

                yumrepo { 'ius-temp':
                  mirrorlist     => 'https://mirrors.iuscommunity.org/mirrorlist?repo=ius-centos7&arch=$basearch&protocol=http',
                  failovermethod => 'priority',
                  enabled        => '1',
                  gpgcheck       => '1',
                  gpgkey         => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
                  descr          => 'IUS Community Packages for Enterprise Linux 7 - $basearch',
                  require        => File['/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY'],
                }
              } else {
                yumrepo { 'ius-temp':
                  ensure => absent
                }
              }
            }
          }
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

}
