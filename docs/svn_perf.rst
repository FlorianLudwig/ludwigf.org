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
 * Windows 7, 64 bit

  * AV deactivated
  * IPv6 deactivated
  * Windows file indexing service deactivated


Test Results
------------


+------------+-------------------+----------------------+------------------+
|            | Linux commandline | Windows commandline  | Windows GUI      |
+------------+-------------------+----------------------+------------------+
| Version    |  1.8.8 (r1568071) |1.8.6.254 tortoise    |       TBD        |
+------------+-------------------+----------------------+------------------+
| Method     |  time svn co ...  | PS Measure-Command { |       TBD        |
|            |  > /dev/null      | svn co ... > $null } |                  |
+------------+-------------------+----------------------+------------------+
| ext4       |           1m 23s  |            --        |       TBD        |
+------------+-------------------+----------------------+------------------+
| NYTS       |           4m 20s  |             9m 19s   |       TBD        |
+------------+-------------------+----------------------+------------------+


Interpretation: The slower checkout times on Windows compared to Windows are observed several times as documented on different forums and mailing lists.
One


The repositoty checkout

 * Checkout size: 8.9 GB (without .svn folder 4.9 GB)
 * 410 Folders
 * 23,706 files
