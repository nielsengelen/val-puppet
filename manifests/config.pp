# === Class veeam_val::config
#
# = Author
#
# Niels Engelen <niels@foonet.be>
#
class veeam_val::config (
  $service_cmd     = $::veeam_val::service_cmd,
  $service_name    = $::veeam_val::service_name,
  $service_ensure  = $::veeam_val::service_ensure,

  $reponame        = $::veeam_val::reponame,
  $repopath        = $::veeam_val::repopath,
  $target          = $::veeam_val::target,

  $type            = $::veeam_val::type,
  $jobname         = $::veeam_val::jobname,
  $compression     = $::veeam_val::compression,
  $dedup           = $::veeam_val::dedup,
  $points          = $::veeam_val::points,
  $objects         = $::veeam_val::objects,

  $prefreeze       = $::veeam_val::prefreeze,
  $postthaw        = $::veeam_val::postthaw,
) {
  # Create the backup directory if not present
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
    command => "${service_cmd} job create --name '${jobname}' --repoName '${reponame}' --compressionLevel ${compression} --dedup --maxPoints ${points} --objects '${objects}'",
    unless  => "${service_cmd} job list | /bin/grep -c ${jobname}",
    require => Exec['create_repository_config'],
  }
}
