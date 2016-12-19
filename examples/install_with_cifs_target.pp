node 'myserver' { 
  # Install Veeam Agent for Linux
  # Example with CIFS share as target, running in free mode and no crontab
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
  }
}
