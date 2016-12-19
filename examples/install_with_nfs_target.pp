node 'myserver' {
  # Install Veeam Backup for Linux
  # Example with NFS share as target, licensed as a server and running via cron everyday at 5
  class { 'veeam_val':
    setup        => true,
    target       => 'nfs',
	nfsserver    => '192.168.1.1',
	nfspath      => '/archive1/vbl',
    username     => 'nfslogin',
    password     => 'veeamiscool123',
    reponame	 => 'backuprepository'
	repopath     => '/data/backup',
	jobname 	 => 'backupjob_puppet',
	objects		 => '/dev/sda',
	prejob       => '/root/prejob.sh',
	postjob      => '/root/postjob.sh',
	schedulecron => '0 5 * * *',
	license      => 'server',
  }
}
