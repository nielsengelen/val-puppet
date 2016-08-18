# === Class veeam_val::params
#
# = Author
#
# Niels Engelen <niels@foonet.be>
#
class veeam_val::params {
  # Define all default parameters
  $pkg_name       = 'veeam'
  $pkg_ensure     = 'present'

  $service_cmd    = 'veeamconfig'
  $service_name   = 'veeamservice'
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
}
