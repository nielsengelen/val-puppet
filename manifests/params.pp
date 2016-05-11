# === Class veeam_vbl::params
#
# = Author
#
# Niels Engelen <niels@foonet.be>
#
class veeam_vbl::params {
  # Define all default parameters
  $pkg_ensure     = present

  $service_cmd    = 'veeamlpbconfig'
  $service_name   = 'veeam'
  $service_ensure = 'running'

  $reponame       = 'VeeamRepository'
  $repopath       = '/data/veeambackup'
  $target         = 'local'

  $type           = 'volume'
  $jobname        = 'VeeamBackupJob'
  $compression    = 1
  $dedup          = true
  $points         = 7
  $objects        = '/dev/sda'

  $prefreeze      = ''
  $postthaw       = ''

  case $::operatingsystem {
    'RedHat', 'CentOS': {
      $pkg_name    = [ 'dkms', 'veeamlpb' ]
      $pkg_options = [ '--nogpgcheck' ]

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
        content => template('veeam_vbl/veeam.repo.erb'),
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
      $pkg_name    = [ 'veeamlpb' ]
      $pkg_options = [ '--allow-unauthenticated', '--force-yes' ]

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
        content => template('veeam_vbl/veeam.deb.erb'),
      }
    }

    default: {
      fail "Operating system (${::operatingsystem}) not (yet) supported in the veeam_vbl module. Modify the veeam_vbl/manifests/params.pp file to extend functionality."
    }
  }
}
