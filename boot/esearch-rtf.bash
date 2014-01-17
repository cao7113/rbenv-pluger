#!/usr/bin/env bash
set -e

search_home=${PREFIX:-/opt/esearch}
rtf_url=https://github.com/medcl/elasticsearch-rtf

[ ! -e $search_home ] && sudo mkdir -p $search_home
rtf_name=elasticsearch-rtf
dest_dir=$search_home/$rtf_name
[ -e $dest_dir ] && echo Warn: found exited $dest_dir && exit 1

search_script=elasticsearch/bin/service/elasticsearch
old_pwd=`pwd`
cd $search_home 
git clone $rtf_url $rtf_name && echo cloned to $dest_dir 
#some extra operation
cd $rtf_name
chmod +x $search_script
sudo ln -sb $dest_dir/$search_script /usr/local/bin/esearch
cd $old_pwd
echo Installed into $dest_dir from $rtf_url
