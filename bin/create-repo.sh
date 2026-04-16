#!/bin/bash

rm -rf Packages Packages.gz Release Release.gpg InRelease

apt-ftparchive  packages . > Packages
gzip -k -f Packages
apt-ftparchive release . > Release
