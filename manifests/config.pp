# === Class veeam_vbl::config
#
# = Author
#
# Niels Engelen <niels@foonet.be>
#
class veeam_vbl::config (
  $service_cmd     = $::veeam_vbl::service_cmd,
  $service_name    = $::veeam_vbl::service_name,
  $service_ensure  = $::veeam_vbl::service_ensure,

  $reponame        = $::veeam_vbl::reponame,
  $repopath        = $::veeam_vbl::repopath,
  $target          = $::veeam_vbl::target,

  $type            = $::veeam_vbl::type,
  $jobname         = $::veeam_vbl::jobname,
  $compression     = $::veeam_vbl::compression,
  $dedup           = $::veeam_vbl::dedup,
  $points          = $::veeam_vbl::points,
  $objects         = $::veeam_vbl::objects,

  $prefreeze       = $::veeam_vbl::prefreeze,
  $postthaw        = $::veeam_vbl::postthaw,
) {
  # Create the backup director if not present
  # using exec as puppet can't make all missing dirs recursively
  exec { 'create_repository_path':
    command => "/bin/mkdir -p ${repopath}",
    creates => $repopath,
  }

  Exec { path => [ '/usr/bin/' ] }

  exec { 'create_repository_config':
    command => "${service_cmd} repository create --name '${reponame}' --location '${repopath}'",
    unless  => "${service_cmd} repository list | /bin/grep -c ${reponame}",
  }

  exec { 'create_job_config':
    command => "${service_cmd} job create --name '${jobname}' --repoName '${reponame}' --compressionLevel ${compression} --dedup ${dedup} --maxPoints ${points} --objects '${objects}'",
    unless  => "${service_cmd} job list | /bin/grep -c ${jobname}",
    require => Exec['create_repository_config'],
  }
}
