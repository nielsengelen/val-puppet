# === Class veeam_vbl
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
#  class { 'veeam_vbl':
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
class veeam_vbl (
  $pkg_ensure     = $::veeam_vbl::params::pkg_ensure,
  $pkg_name       = $::veeam_vbl::params::pkg_name,
  $pkg_options    = $::veeam_vbl::params::pkg_options,

  $service_cmd    = $::veeam_vbl::params::service_cmd,
  $service_name   = $::veeam_vbl::params::service_name,
  $service_ensure = $::veeam_vbl::params::service_ensure,

  $reponame       = $::veeam_vbl::params::reponame,
  $repopath       = $::veeam_vbl::params::repopath,
  $target         = $::veeam_vbl::params::target,

  $type           = $::veeam_vbl::params::type,
  $jobname        = $::veeam_vbl::params::jobname,
  $compression    = $::veeam_vbl::params::compression,
  $dedup          = $::veeam_vbl::params::dedup,
  $points         = $::veeam_vbl::params::points,
  $objects        = $::veeam_vbl::params::objects,
) inherits veeam_vbl::params {
  # Includes
  include veeam_vbl::install
  include veeam_vbl::config

  Class[ 'veeam_vbl::params' ] ->
  Class[ 'veeam_vbl::install' ] ->
  Class[ 'veeam_vbl::config' ] #->
  #Class[ 'veeam_vbl::service' ]
}
