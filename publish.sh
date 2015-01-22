#!/usr/bin/sh

pip install -U Sphinx sphinx-rtd-theme
sphinx-build -b html docs build
rsync -av build/ root@ludwigf.org:/srv/ludwigf/www/
