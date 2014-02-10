#!/usr/bin/env bash

set -e
[ -e ~/.ssh/id_rsa.pub ] && echo Found ~/.ssh/id_rsa.pub && exit 1
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N '' -C 'some note'
