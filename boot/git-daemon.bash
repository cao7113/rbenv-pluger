#!/usr/bin/env bash

# Summary: install a local git daemon

set -e
sudo apt-get -y install git-daemon-run
cat <<-Note
  now can link to your git repos root like:
  sudo rm -fr /var/cache/git
  sudo ln -sb /u/repos /var/cache/git
  ls -l /var/cache/git
Note
