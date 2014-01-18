#!/usr/bin/env bash
set -e

which java &>/dev/null || { echo No java environment, recommend jdk7 && exit 1;}
search_home=${PREFIX:-/opt/esearch}
[ -e $search_home ] || { sudo mkdir -p $search_home && sudo chown -R $USER:$USER $search_home;}
rtf_url=https://github.com/medcl/elasticsearch-rtf.git
rtf_name=elasticsearch-rtf
rtf_home=$search_home/$rtf_name
[ -e $rtf_home ] && echo Warn: existed $rtf_home && exit 1

old_pwd=`pwd`
cd $search_home 
git clone $rtf_url $rtf_name 
cd $rtf_name
search_script=elasticsearch/bin/service/elasticsearch
chmod +x $search_script
sudo ln -sb $rtf_home/$search_script /usr/local/bin/esearch-rtf
cd $old_pwd
cat <<Doc
  Installed into $rtf_home from $rtf_url

  esearch-rtf console|start|stop|install|remove
Doc
