# Veeam Agent for Linux puppet class

####Table of Contents

1. [Overview](#overview)
2. [Module description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Advanced features - Extra information on advanced usage](#advanced-features)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Support - When you need help with this module](#support)

##Overview

This module manages Veeam Agent for Linux. Veeam Agent for Linux is an agent-based solution running inside the guest OS (operating system).

The following is currently supported:
  - Create a repository (VBR repository, local, NFS or CIFS)
  - Create a backup job (Entire computer, volume based or file level backup)
  - Define the schedule
  
##Module description

The Veeam Agent for Linux module deploys the agent on multiple nodes with the specified configuration.

##Usage

###Main class

####Install with the default settings

```puppet
 class { 'veeam_val':
   
  }
```

####Install with specific settings

```puppet
 class { 'veeam_val':
        type            => 'volume',
        reponame        => 'backuprepo',
        repopath        => '/data/backup',
        jobname         => 'backupjob_puppet',
        compression     => 1,
        points          => 7,
        objects         => '/dev/sda',
  }
```

##Advanced features
```puppet
 class { 'veeam_val':
        type        => File, volume or entire (DEFAULT: volume)
        reponame    => Repository name (DEFAULT: VeeamRepository)
        repopath    => Repository path (DEFAULT: /data/VeeamBackup)
        target      => Local, CIFS, NFS, vbrserver (DEFAULT: local)
        jobname     => Job name (DEFAULT: VeeamBackupJob)
        compression => 0 ... 4 (DEFAULT: 1)
        dedup       => true/false (DEFAULT: true)
        points      => 5 (DEFAULT: 7)
        objects     => Objects to backup comma seperated (DEFAULT: /dev/sda)
        prefreeze   => Prefreeze script path (DEFAULT: none)
        postthaw    => Postthaw script path (DEFAULT: none)
  }
```

##Limitations

This module has been built on and tested against Puppet 3.2 and higher.

The module has been tested on:

* Debian 6/7/8
* CentOS 6/7
* Ubuntu 12.04, 14.04, 16.04

Testing on other platforms has not been performed and is currently not supported.

##Development

Please contact Niels Engelen via [twitter](https://twitter.com/nielsengelen).

##Support

Need help? Join us on the [discussion forum](https://forums.veeam.com/veeam-agent-for-linux-f41/).