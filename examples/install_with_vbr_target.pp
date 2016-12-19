node 'myserver' {
  # Install Veeam Backup for Linux
  # Example with Veeam Backup & Replication repository as target
  class { 'veeam_val':
    setup        => true,
    pkg_ensure   => 'present',
    type         => 'entire',
    target       => 'vbrserver',
    vbrname      => 'VBR',
    vbrserver    => '192.168.1.1',
    domain       => 'VEEAM',
    username     => 'veeam',
    password     => 'veeamiscool123',
    reponame     => '[VBR]STORAGE',
    jobname 	 => 'backupjob_puppet',
  }
}
