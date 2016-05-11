# Class: veeam_vbl::service
#
# Placeholder.
#
# = Author
#
# Niels Engelen <niels@foonet.be>
#
class veeam_vbl::service {
  # Make sure the veeam_vbl service is running
  service { $::veeam_vbl::service_name:
    ensure     => $::veeam_vbl::service_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => [ Package [ $::veeam_vbl::pkg_name ] ],
    require    => Class [ 'veeam_vbl::install' ],
  }
}
