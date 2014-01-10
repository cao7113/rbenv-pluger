#!/usr/bin/env bash
set -e
local_script=$ush_home/bin/hub #~/bin/hub
curl http://hub.github.com/standalone -sLo $local_script
chmod +x $local_script
echo write a cript: $local_script, try hub or ref: http://hub.github.com
