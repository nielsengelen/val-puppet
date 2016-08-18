# Class: veeam_val::install
#
# This class provides the main installation.
#
# = Author
#
# Niels Engelen <niels@foonet.be>
#
class veeam_val::install {
  # Get all packages installed properly
  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $pkg_name    = [ 'dkms', 'lvm2', 'veeamsnap', 'veeam' ]
      $pkg_options = [ '--nogpgcheck' ]
      $ensure      = 'present'

      # A yum repository for RHEL based servers
      file { '/etc/yum.repos.d/':
        ensure => 'directory',
        mode   => '0755',
      }

      file { '/etc/yum.repos.d/veeam.repo':
        ensure  => 'file',
        mode    => '0644',
        owner   => root,
        group   => root,
        content => template('veeam_val/veeam.repo.erb'),
      }

      case $::operatingsystemrelease {
        /5./: {
          $osversion = 5
        }
        /6./: {
          $osversion = 6
        }
        /7./: {
          $osversion = 7
        }
        default: {
          $osversion = 7
        }
      }

      yumrepo { 'epel':
        mirrorlist     => "https://mirrors.fedoraproject.org/metalink?repo=epel-${osversion}&arch=\$basearch",
        descr          => 'Extra Packages for Enterprise Linux',
        enabled        => 1,
        gpgcheck       => 0,
        failovermethod => 'priority',
      }
    }

    'Debian', 'Ubuntu': {
      $pkg_name    = [ 'dkms', 'lvm2', 'veeamsnap', 'veeam', ]
      $pkg_options = [ '--allow-unauthenticated', '--force-yes' ]
      $ensure      = 'present'

      # A debian repository for debian based servers
      file { '/etc/apt/sources.list.d/':
        ensure => 'directory',
        mode   => '0755',
      }

      file { '/etc/apt/sources.list.d/veeam.list':
        ensure  => 'file',
        mode    => '0644',
        owner   => root,
        group   => root,
        content => template('veeam_val/veeam.deb.erb'),
      }
    }

    default: {
      fail "Operating system (${::operatingsystem}) not (yet) supported in the veeam_val module. Modify the veeam_val/manifests/install.pp file to extend functionality."
    }
  }

  package { $pkg_name:
    ensure          => $ensure,
    install_options => $pkg_options,
  }
}
