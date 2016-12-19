# Class: veeam_val::service
#
# This class makes sure the service is running.
#
# = Author
#
# Niels Engelen <niels@foonet.be>
#
class veeam_val::service {
  # Make sure the veeam service is running
  service { $::veeam_val::service_name:
    ensure     => $::veeam_val::service_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => Package[$::veeam_val::pkg_name],
    require    => Package[$::veeam_val::pkg_name],
  }
}
