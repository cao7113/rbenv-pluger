#!/usr/bin/env bash

set -e
loc=${1:-zh_CN}
echo Previous locales: 
locale -a
#another method: sudo locale-gen zh_CN.UTF-8
sudo /usr/share/locales/install-language-pack $loc
echo Installed locale: $loc, now locales: 
locale -a
