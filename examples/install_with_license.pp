node 'myserver' {
  # Install Veeam Backup for Linux
  # Example with CIFS share as target and licensed as a workstation
  class { 'veeam_val':
    setup        => true,
    target       => 'cifs',
    cifsserver   => '192.168.1.120',
    cifspath     => '\\somepath',
    username     => 'cifslogin',
    password     => 'veeamiscool123',
    reponame	 => 'backuprepository',
    repopath     => '/data/backup',
    jobname 	 => 'backupjob_puppet',
    objects		 => '/dev/sda',
	license      => 'workstation',
  }
}
