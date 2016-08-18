# === Class veeam_val
#
# = Parameters
#   pkg_ensure => ensure if it's installed or not (present or absent)
#
#	type	  	=> File, volume or entire 				(DEFAULT: volume)
#   reponame  	=> Repository name						(DEFAULT: VeeamRepository)
#	repopath  	=> Repository path						(DEFAULT: /data/VeeamBackup)
#	target		=> Local, CIFS, NFS, vbrserver			(DEFAULT: local)
#   jobname   	=> Job name								(DEFAULT: VeeamBackupJob)
#	compression	=> 0 ... 4								(DEFAULT: 1)
# 	dedup		=> true/false							(DEFAULT: true)
#	points		=> 5									(DEFAULT: 7)
#	objects		=> Objects to backup comma seperated	(DEFAULT: /dev/sda)
#   prefreeze	=> Prefreeze script path				(DEFAULT: none)
#   postthaw	=> Postthaw script path					(DEFAULT: none)
#
# = Examples
# node abc {
#  class { 'veeam_val':
#  	 type        => 'volume',
#    reponame  	=> 'Backuprepo',
#  	 repopath  	=> '/data/backup',
#    jobname   	=> 'My_backup_job',
#	 compression => 1,
# 	 dedup		=> false,
#    points		=> 7,
#	 objects	 	=> '/dev/sda1',
#	 prefreeze	=> '/etc/veeam/myscript.sh',
#	 postthaw	=> '/etc/veeam/myscriptdone.sh',
#  }
# }
#
# = Author
#
# Niels Engelen (niels@foonet.be)
#
class veeam_val (
  $pkg_ensure     = $::veeam_val::params::pkg_ensure,
  $pkg_name       = $::veeam_val::params::pkg_name,

  $service_cmd    = $::veeam_val::params::service_cmd,
  $service_name   = $::veeam_val::params::service_name,
  $service_ensure = $::veeam_val::params::service_ensure,

  $reponame       = $::veeam_val::params::reponame,
  $repopath       = $::veeam_val::params::repopath,
  $target         = $::veeam_val::params::target,

  $type           = $::veeam_val::params::type,
  $jobname        = $::veeam_val::params::jobname,
  $compression    = $::veeam_val::params::compression,
  $dedup          = $::veeam_val::params::dedup,
  $points         = $::veeam_val::params::points,
  $objects        = $::veeam_val::params::objects,
) inherits veeam_val::params {
  # Includes
  include veeam_val::install
  include veeam_val::config
  include veeam_val::service

  Class[ 'veeam_val::params' ] ->
  Class[ 'veeam_val::install' ] ->
  Class[ 'veeam_val::service' ] ->
  Class[ 'veeam_val::config' ]
}
