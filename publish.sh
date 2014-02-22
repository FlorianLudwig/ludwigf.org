#!/usr/bin/sh

sphinx-build -b html docs build
rsync -av build/ root@ludwigf.org:/srv/ludwigf/www/
