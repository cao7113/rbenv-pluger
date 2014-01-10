#!/usr/bin/env bash
set -e
cat <<-'Note' > /dev/null
* cmd: puma, pumactl
* control status app: puma --control 0.0.0.0:9293 --control-token foo #access ?token=foo  is good
* deploy into /apps, nginx config in /etc/nginx/conf.d/puma*.conf
Note

puma_gem_root=$(dirname $(dirname $(gem which puma)))
#check 2.7.1+
initfile=/etc/init/puma.conf
[ ! -f $initfile ] && echo Found $initfile && exit 1

sudo cp $puma_gem_root/tools/jungle/upstart/puma{,-manager}.conf /etc/init/
sudo vi /etc/init/puma.conf && cat <<-Note 
Make sure the user and rubyenv settings, introduce two upstart job: puma, puma-manager
 default running in user: apps
 app log at: /var/log/upstart/puma-*.log
Note
sudo touch /etc/puma.conf 
echo fill init puma apps in /etc/puma.conf
