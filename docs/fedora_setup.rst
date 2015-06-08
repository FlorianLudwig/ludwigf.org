Fedora Setup
============
Notes on setting up a new fedora install


General
-------

 * /etc/fstab -> noatim
 * `trim? <http://wiki.ubuntuusers.de/SSD>`_
 * `rpm fusion <http://rpmfusion.org/Configuration>`_
 * `livna <http://rpm.livna.org/>`_ (dvd support)
 * clean_requirements_on_remove=1 under [main] in /etc/dnf.conf (`about <http://blog.christophersmart.com/2010/11/11/testing-dnfs-autoremove-orphaned-deps-feature/>`_)


My usual apps
-------------

 * xorg-x11-apps for xkill
 * gnome-media-apps for audio recorder

+-------------------+--------------------------------+
| Package           | Usage                          |
+===================+================================+
| inkscape          |                                |
| gimp              |                                |
| xournal           |                                |
+-------------------+--------------------------------+
| screen            | cli tools                      |
+-------------------+--------------------------------+

Install::

  dnf -y install inkscape gimp xournal avidemux-gtk gtk-recordmydesktop audacity-freeworld libdvdread libdvdcss gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer-ffmpeg gstreamer-plugins-bad-nonfree htop vim-enhanced xorg-x11-apps tinc powertop iotop screen ack libva-utils libva-freeworld freetype-freeworld gnome-media-apps libtxc_dxtn sshfs pidgin pidgin-otr


Coding Stuff
------------


 * dnf -y install git subversion meld regexxer virt-manager gitk
 * dnf -y install reinteract python-virtualenv python-virtualenvwrapper python-pip
 * dnf -y install mysql-server phpMyAdmin mysql-workbench
 * dnf -y install gcc gcc-c++
 * http://docs.mongodb.org/manual/tutorial/install-mongodb-on-redhat-centos-or-fedora-linux/

Other stuff
-----------

 * `Virtual Box <https://www.virtualbox.org/>`_
 * `Google Chrome <https://www.google.de/chrome/browser/desktop/>`_
 * `Seafile <https://copr.fedoraproject.org/coprs/pkerling/seafile/>`_
