node 'myserver' { 
  # Install Veeam Agent for Linux
  # Example with local storage as target and running via cron everyday at 5
  class { 'veeam_val':
    setup        => true,
    target      => 'local',
	type        => 'volume',
    reponame	=> 'backuprepo',
	repopath	=> '/data/backup',
	jobname 	=> 'backupjob_puppet',
    objects     => '/dev/sda3',
	schedule     => true,
	schedulecron => '0 5 * * *',
  }
}
