#!/usr/bin/env bash

set -e 
cat <<-Doc
  do this manually, ref: udoc/tools/ssh

  sudo vi /etc/ssh/sshd_config

  append lines:

  GatewayPorts yes
  ClientAliveInterval 30
  ClientAliveCountMax 99999
Doc
