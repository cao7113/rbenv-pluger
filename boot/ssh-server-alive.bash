#!/usr/bin/env bash

set -e 
cat <<-Doc
  do this manually, ref: udoc/tools/ssh

  on almost-online server vm(eg. tj desktop):
    sudo vi /etc/ssh/sshd_config

    append lines:

      GatewayPorts yes
      ClientAliveInterval 30
      ClientAliveCountMax 99999

  on proxy vps:
    sudo vi /etc/ssh/sshd_config

    append lines:

      GatewayPorts yes

    or ports on vps:

      tcp        0      0 127.0.0.1:50022         0.0.0.0:*               LISTEN      2194/sshd: doger
      tcp6       0      0 ::1:50022               :::*                    LISTEN      2194/sshd: doger

    just accessible on the vps, bind to localhost

    if add below and sudo restart ssh on vps:  

      GatewayPorts yes

    note: 也应该加上其它两句

    then ports on vps(Note: also restart sshdog or relink):

      tcp        0      0 0.0.0.0:50022           0.0.0.0:*               LISTEN      2965/sshd: doger
      tcp6       0      0 :::50022                :::*                    LISTEN      2965/sshd: doger

    that is any host can access proxy's port
Doc
