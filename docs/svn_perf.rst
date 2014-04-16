SVN Performance on Windows
==========================

We evaluated Subversion for storing assets and asset source files such as Photoshop files.
We found svn to run rather slow for actions such as commit or checkout on repositories with "more than a few" files.
To make that a quantitative statement a test as follows was conducted.

Server Setup
------------

svn serv command used to (as recommended in the `svn book <http://svnbook.red-bean.com/en/1.7/svn.serverconfig.optimization.html>`_)::

    svnserve -d --memory-cache-size 2048  -r /srv/svn_repos/ --cache-txdeltas yes --cache-fulltexts yes -c 0

Client Machine
--------------

 * Intel(R) Xeon(R) CPU E3-1230 V2 @ 3.30GHz
 * checkout to HDD not SSD
 * 1 GBit LAN to server
 * Linux, Fedora 20 64 bit

  * Kernel 3.13.8
  * ext4: journaling enabled (rw,relatime,data=ordered)
  * NTFS: type fuseblk (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other,blksize=4096

 * Windows 7, 64 bit

  * AV deactivated
  * IPv6 deactivated
  * Windows file indexing service deactivated [`1 <http://tortoisesvn.tigris.org/faq.html#cantmove2>`_]
  * Windows auto updates disabled
  * Windows Media Player * Service deactivated [`1 <http://answers.microsoft.com/en-us/windows/forum/windows_7-performance/pid-4-high-disk-activity-what-and-why/966bc528-aa9b-4268-b598-3a92e12d3800>`_]


Test Results
------------

All tests where run twice and the better result taken.

+------------+-------------------+----------------------+------------------+
|            | Linux commandline | Windows commandline  | Windows GUI      |
+------------+-------------------+----------------------+------------------+
| Version    |  1.8.8 (r1568071) |1.8.6.254 tortoise    |       TBD        |
+------------+-------------------+----------------------+------------------+
| Method     |  time svn co ...  | PS Measure-Command { | Trained Human    |
|            |  > /dev/null      | svn co ... > $null } | with stopwatch   |
+------------+-------------------+----------------------+------------------+
| ext4       |         1m 16s    |            --        |       TBD        |
+------------+-------------------+----------------------+------------------+
| NTFS       |         3m 29s *  |            9m 19s *  |       TBD        |
+------------+-------------------+----------------------+------------------+

[*] Same partition


The repositoty checkout

 * Checkout size: 8.9 GB (without .svn folder 4.9 GB)
 * 410 Folders
 * 23,706 files
