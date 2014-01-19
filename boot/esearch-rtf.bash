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
runtime=elasticsearch/bin/service/elasticsearch
chmod +x $runtime
sudo ln -sb $rtf_home/$runtime /usr/local/bin/esearch-rtf
cd $old_pwd
cat <<Doc
  Installed into $rtf_home from $rtf_url

  esearch-rtf console|start|stop|install|remove

  vi elasticsearch-rtf/elasticsearch/bin/service/elasticsearch.conf

  默认JAVA HEAP大小为1G，根据你的服务器环境，需要自行调整，一般设置为物理内存的50%.

  set.default.ES_HEAP_SIZE=1024

  detail ref: https://github.com/medcl/elasticsearch-rtf
Doc
