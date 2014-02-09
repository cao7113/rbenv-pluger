#!/usr/bin/env bash 

set -e
uname=${USER:-doger}
sudo useradd -m -s /bin/bash -G sudo $uname
sudo passwd $uname
