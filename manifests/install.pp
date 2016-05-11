# Class: veeam_vbl::install
#
# This class provides the main installation.
#
# = Author
#
# Niels Engelen <niels@foonet.be>
#
class veeam_vbl::install {
  # Get all packages installed properly
  package { $::veeam_vbl::pkg_name:
    ensure          => $::veeam_vbl::pkg_ensure,
    install_options => $::veeam_vbl::pkg_options,
  }
}
