#!/usr/bin/env bash
set -e
puma_gem_root=$(dirname $(dirname $(gem which puma)))
puma_version=$(basename $puma_gem_root)
puma_version=${puma_version#puma-}

if (echo ${puma_version} 2.7.1 | awk '!($1<$2){exit 1}') then #bash只能比较整数
  echo Require puma 2.7.1+ && exit 1
fi
initfile=/etc/init/puma.conf
[ -z $FORCE -a -f $initfile ] && { echo Found $initfile && exit 1;}

sudo cp $puma_gem_root/tools/jungle/upstart/puma{,-manager}.conf /etc/init/
sudo touch /etc/puma.conf 

cat <<-Note && read && sudo vi /etc/init/puma.conf 
  note the user(default: apps) and rbenv(location and include shims) settings
  press any key to continue to edit /etc/init/puma.conf
Note

cat <<-'Note'
* introduce two upstart job: puma, puma-manager
* cmd: puma, pumactl
* control status app: puma --control 0.0.0.0:9293 --control-token foo #access ?token=foo  is good
* deploy into /apps, nginx config in /etc/nginx/conf.d/puma*.conf
* app log at: /var/log/upstart/puma-*.log
* fill init puma apps in /etc/puma.conf
Note
