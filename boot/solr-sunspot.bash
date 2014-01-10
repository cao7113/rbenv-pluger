#!/usr/bin/env bash
set -e
which java >/dev/null||{ echo Require java && exit 1;}
echo ==java version: `java -version`
solr_conf_dir=/etc/solr/conf
if [ ! -e $solr_conf ];then
  echo ==Installing solr and tomcat ... 
  sudo apt-get -y install solr-tomcat
  echo ==Info: solr is running on http://localhost:8080/solr/admin/ under user: tomcat6
fi

solr_conf_dir=/etc/solr/conf
_solr_conf_dir=$(dirname $0)/../etc/solr
cat <<-Note
  如运行 sunspot有问题，用$_solr_conf_dir/{schema.xml,solrconfig.xml}替换下$solr_conf_dir试试
Note
echo to end 
