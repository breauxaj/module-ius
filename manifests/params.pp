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

  case $::operatingsystem {
    'CentOS', 'OracleLinux', 'RedHat', 'Scientific': {
      $ius_package = 'ius-release'

      case $::operatingsystemmajrelease {
        '6': {
          if ( !$::ius_installed ) {
            yumrepo { 'ius-temp':
              mirrorlist     => 'https://mirrors.iuscommunity.org/mirrorlist?repo=ius-centos6&arch=$basearch&protocol=http',
              failovermethod => 'priority',
              enabled        => '1',
              gpgcheck       => '1',
              gpgkey         => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
              descr          => 'IUS Community Packages for Enterprise Linux 6 - $basearch',
              require        => File['/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY'],
            }

            file { '/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY':
              ensure => present,
              owner  => 'root',
              group  => 'root',
              mode   => '0644',
              source => 'puppet:///modules/ius/IUS-COMMUNITY-GPG-KEY',
            }
          } else {
            yumrepo { 'ius-temp':
              ensure => absent
            }
          }
        }
        '7': {
          if ( !$::ius_installed ) {
            yumrepo { 'ius-temp':
              mirrorlist     => 'https://mirrors.iuscommunity.org/mirrorlist?repo=ius-centos7&arch=$basearch&protocol=http',
              failovermethod => 'priority',
              enabled        => '1',
              gpgcheck       => '1',
              gpgkey         => 'file:///etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY',
              descr          => 'IUS Community Packages for Enterprise Linux 7 - $basearch',
              require        => File['/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY'],
            }

            file { '/etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY':
              ensure => present,
              owner  => 'root',
              group  => 'root',
              mode   => '0644',
              source => 'puppet:///modules/ius/IUS-COMMUNITY-GPG-KEY',
            }
          } else {
            yumrepo { 'ius-temp':
              ensure => absent
            }
          }
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} ${::operatingsystemmajrelease} distribution.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::operatingsystem} based system.")
    }
  }
}