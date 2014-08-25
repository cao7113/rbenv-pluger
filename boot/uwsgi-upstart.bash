#!/usr/bin/env bash 
#Created from mksh on 2014年 08月 23日 星期六 16:23:57 CST

# 生成uwsgi upstart init脚本

echo ref https://uwsgi-docs.readthedocs.org/en/latest/Upstart.html

echo generate uWsgi upstart init config file

cat <<-Conf
description "uwsgi upstart init conf"
#start on socket PROTO=inet PORT=303 #ubuntu12.04+ for socket lazy activation
start on runlevel [2345]
stop on runlevel [06]
exec uwsgi --master --processes 4 --die-on-term --socket :3031 --wsgi-file /var/www/myapp.wsgi
Conf


## TODO /etc/init/uwsgi-xxx.conf
