SVN Performance on Windows
==========================

We evaluated Subversion for storing assets and asset source files such as Photoshop files.
We found svn to run rather slow for actions such as commit or checkout on repositories with "more than a few" files.
To make that a quantitative statement a test as follows was conducted.

Server Setup
------------

svn serv command used (as recommended in the `svn book <http://svnbook.red-bean.com/en/1.7/svn.serverconfig.optimization.html>`_)::

    svnserve -d --memory-cache-size 2048  -r /srv/svn_repos/ --cache-txdeltas yes --cache-fulltexts yes -c 0

Client Machine
--------------

 * Intel(R) Xeon(R) CPU E3-1230 V2 @ 3.30GHz
 * checkout to HDD not SSD
 * 1 GBit LAN to server
 * Linux, Fedora 20 64 bit

  * Kernel 3.13.8
  * ext4: journaling enabled (rw,relatime,data=ordered)
  * NTFS: type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096)

 * Windows 7, 64 bit

  * AV deactivated
  * IPv6 deactivated
  * Windows file indexing service deactivated [`1 <http://tortoisesvn.tigris.org/faq.html#cantmove2>`_]
  * Windows auto updates disabled
  * Windows Media Player * Service deactivated [`1 <http://answers.microsoft.com/en-us/windows/forum/windows_7-performance/pid-4-high-disk-activity-what-and-why/966bc528-aa9b-4268-b598-3a92e12d3800>`_]


Test Results
------------

All tests where run twice and the better result taken.

+-------------------+-------------------+----------------------+------------------+
|                   | Linux commandline | Windows commandline  | Windows GUI      |
+-------------------+-------------------+----------------------+------------------+
| Version           |  1.8.8 (r1568071) |1.8.6.254 tortoise    |       TBD        |
+-------------------+-------------------+----------------------+------------------+
| Method            |  time svn --queit | PS Measure-Command { | Trained Human    |
|                   |  co ...           | svn --queit co ... } | with stopwatch   |
+-------------------+-------------------+----------------------+------------------+
| ext4              |         1m 16s    |            --        |       TBD        |
+-------------------+-------------------+----------------------+------------------+
| NTFS              |       3m 29s [1]  |           9m 19s [1] |       TBD        |
+-------------------+-------------------+----------------------+------------------+
| NTFS + exclusive  |       3m  2s [1]  |           6m 52s [1] |                  |
| locking [2]       |                   |                      |                  |
+-------------------+-------------------+----------------------+------------------+

Table notes:

 1. Same partition
 2. svn co --quiet --config-option config:working-copy:exclusive-locking=true


The Repository
--------------

The test repository was a usual project folder from our designers.
Subversion was not productively used so there are not many (=8) revisions in the repository.
Here the stats:

 * Checkout size: 8.9 GB (without .svn folder 4.9 GB)
 * 410 Folders
 * 23,706 files
 * the wast majority are binary files (images)


Subversion Version
------------------

Detailed information obtained via `svn --version --verbose`

Linux::

    svn, version 1.8.8 (r1568071)
       compiled Feb 28 2014, 19:40:43 on x86_64-redhat-linux-gnu

    Copyright (C) 2013 The Apache Software Foundation.
    This software consists of contributions made by many people;
    see the NOTICE file for more information.
    Subversion is open source software, see http://subversion.apache.org/

    The following repository access (RA) modules are available:

    * ra_svn : Module for accessing a repository using the svn network protocol.
      - with Cyrus SASL authentication
      - handles 'svn' scheme
    * ra_local : Module for accessing a repository on local disk.
      - handles 'file' scheme
    * ra_serf : Module for accessing a repository via WebDAV protocol using serf.
      - using serf 1.3.4
      - handles 'http' scheme
      - handles 'https' scheme

    System information:

    * running on x86_64-unknown-linux-gnu
      - Fedora release 20 (Heisenbug) (Heisenbug) [Linux 3.13.8-200.fc20.x86_64]
    * linked dependencies:
      - APR 1.5.0 (compiled with 1.5.0)
      - APR-Util 1.5.3 (compiled with 1.5.3)
      - SQLite 3.8.4.2 (compiled with 3.8.3)


Windows::

    svn, version 1.8.8 (r1568071)
       compiled Apr 12 2014, 14:17:25 on x86-microsoft-windows

    Copyright (C) 2013 The Apache Software Foundation.
    This software consists of contributions made by many people;
    see the NOTICE file for more information.
    Subversion is open source software, see http://subversion.apache.org/

    The following repository access (RA) modules are available:

    * ra_svn : Module for accessing a repository using the svn network protocol.
      - with Cyrus SASL authentication
      - handles 'svn' scheme
    * ra_local : Module for accessing a repository on local disk.
      - handles 'file' scheme
    * ra_serf : Module for accessing a repository via WebDAV protocol using serf.
      - using serf 1.3.4
      - handles 'http' scheme
      - handles 'https' scheme

    System information:

    * running on x86_64-microsoft-windows6.1.7601
      - Windows 7 Ultimate N, Service Pack 1, build 7601 [6.1 Client Multiprocessor Free]
    * linked dependencies:
      - APR 1.5.0 (compiled with 1.5.0)
      - APR-Util 1.5.3 (compiled with 1.5.3)
      - SQLite 3.8.3.1 (compiled with 3.8.3.1)
    * loaded shared libraries:
      - C:\Program Files\TortoiseSVN\bin\svn.exe   (1.8.8.60743)
      - C:\Windows\SYSTEM32\ntdll.dll   (6.1.7601.18247)
      - C:\Windows\system32\kernel32.dll   (6.1.7601.18409)
      - C:\Windows\system32\KERNELBASE.dll   (6.1.7601.18229)
      - C:\Program Files\TortoiseSVN\bin\libsvn_tsvn.dll   (1.8.8.60743)
      - C:\Program Files\TortoiseSVN\bin\libapr_tsvn.dll   (1.5)
      - C:\Windows\system32\WS2_32.dll   (6.1.7601.17514)
      - C:\Windows\system32\msvcrt.dll   (7.0.7601.17744)
      - C:\Windows\system32\RPCRT4.dll   (6.1.7601.18205)
      - C:\Windows\system32\NSI.dll   (6.1.7600.16385)
      - C:\Windows\system32\MSWSOCK.dll   (6.1.7601.18254)
      - C:\Windows\system32\user32.dll   (6.1.7601.17514)
      - C:\Windows\system32\GDI32.dll   (6.1.7601.18275)
      - C:\Windows\system32\LPK.dll   (6.1.7601.18177)
      - C:\Windows\system32\USP10.dll   (1.626.7601.18009)
      - C:\Windows\system32\ADVAPI32.dll   (6.1.7601.18247)
      - C:\Windows\SYSTEM32\sechost.dll   (6.1.7600.16385)
      - C:\Windows\system32\SHELL32.dll   (6.1.7601.18222)
      - C:\Windows\system32\SHLWAPI.dll   (6.1.7601.17514)
      - C:\Windows\system32\MSVCR110.dll   (11.0.51106.1)
      - C:\Program Files\TortoiseSVN\bin\libaprutil_tsvn.dll   (1.5.3)
      - C:\Windows\system32\WLDAP32.dll   (6.1.7601.17514)
      - C:\Program Files\TortoiseSVN\bin\intl3_tsvn.dll   (0.14.6)
      - C:\Program Files\TortoiseSVN\bin\libsasl.dll   (2.1.24)
      - C:\Windows\system32\ole32.dll   (6.1.7601.17514)
      - C:\Windows\system32\Secur32.dll   (6.1.7601.18270)
      - C:\Windows\system32\SSPICLI.DLL   (6.1.7601.18270)
      - C:\Windows\system32\CRYPT32.dll   (6.1.7601.18277)
      - C:\Windows\system32\MSASN1.dll   (6.1.7601.17514)
      - C:\Windows\system32\VERSION.dll   (6.1.7600.16385)
      - C:\Windows\system32\IMM32.DLL   (6.1.7600.16385)
      - C:\Windows\system32\MSCTF.dll   (6.1.7600.16385)
      - C:\Windows\system32\profapi.dll   (6.1.7600.16385)
      - C:\Program Files\TortoiseSVN\bin\saslANONYMOUS.dll   (2.1.24)
      - C:\Program Files\TortoiseSVN\bin\saslCRAMMD5.dll   (2.1.24)
      - C:\Program Files\TortoiseSVN\bin\saslDIGESTMD5.dll   (2.1.24)
      - C:\Program Files\TortoiseSVN\bin\saslGSSAPI.dll   (2.1.24)
      - C:\Program Files\TortoiseSVN\bin\saslLOGIN.dll   (2.1.24)
      - C:\Program Files\TortoiseSVN\bin\saslNTLM.dll   (2.1.24)
      - C:\Program Files\TortoiseSVN\bin\saslPLAIN.dll   (2.1.24)
      - C:\Windows\system32\Msimg32.DLL   (6.1.7600.16385)
      - C:\Windows\system32\api-ms-win-downlevel-advapi32-l1-1-0.dll   (6.2.9200.16492)
      - C:\Windows\system32\psapi.dll   (6.1.7600.16385)

Notes
-----

 * Using --quiet instead of piping to null does not affect performance [`subversion mailling list <http://mail-archives.apache.org/mod_mbox/subversion-users/201404.mbox/browser>`_]