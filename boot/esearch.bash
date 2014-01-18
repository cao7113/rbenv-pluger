#!/usr/bin/env bash
set -e
which java &>/dev/null || { echo No java environment, recommend jdk7 && exit 1;}
esearch_home=${PREFIX:-/opt/esearch}
[ -d $esearch_home ] ||{ sudo mkdir -p $esearch_home && sudo chown -R $USER:$USER $esearch_home;}
cd $esearch_home

action=${1:-help}
case "$action" in 
  -h|--help|help)
    echo "$0 help|list|<version>"
    exit
    ;;
  -l|--list|list)
    xdg-open http://www.elasticsearch.org/downloads/ 
    exit
    ;;
  *)
    version=$action
    pkg_name=elasticsearch-$version
    [ -d $pkg_name ] && echo Already exists $esearch_home/$pkg_name && exit 1
    pkg_url=https://download.elasticsearch.org/elasticsearch/elasticsearch/$pkg_name.tar.gz
    [ -e $pkg_name.tar.gz ] ||  wget $pkg_url 
    tar xzvf $pkg_name.tar.gz
    #wrapper: https://github.com/elasticsearch/elasticsearch-servicewrapper
    ;;
esac
#set cluster name in config/elasticsearch.yml: cluster.name: xxx
#https://github.com/mobz/elasticsearch-head
#sudo bin/plugin -install mobz/elasticsearch-head && echo access at http://localhost:9200/_plugin/head/
#sudo bin/plugin -install elasticsearch/elasticsearch-analysis-smartcn/1.2.0

#Ruby:
# https://github.com/karmi/retire
