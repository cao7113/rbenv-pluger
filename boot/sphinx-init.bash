#!/bin/bash
#Created from mksh on 2012年 10月 24日 星期三 09:40:16 CST
#Description:
#  current use System-Init version, ref: http://linux.justinhartman.com/Startup_Script_for_Sphinx
#  TODO use Upstart script instead
#Note: you can remove this autorun by running: sudo update-rc.d -f $daemon_name remove
#Bugs report: caoruijian@tianji.com or http://shareup.me

#[ $# -lt 1 ] && echo Usage: $0 [rails_dev] [service_user_name], e.g. $0 [development] [www] && exit 1
rails_env="${1:-development}"
service_user="${2:-$USER}"  #默认使用当前登录用户，请保持和运行rails的一致
#echo ==debug: $0 $rails_env $service_user ... && exit 1

sphinx_home=/usr/local  #sphinx的安装目录
daemon_name=searchd
daemon_path=$sphinx_home/bin/$daemon_name
init_sphinx_searchd=/etc/init.d/$daemon_name
[ -e $init_sphinx_searchd ] && echo Warning: $init_sphinx_searchd has existed now, check firstly! I will overwrite it #&& exit 1

this_script_path=`readlink -f $0`
this_script_dir=`dirname $this_script_path`
sphinx_config=$this_script_dir/../config/$rails_env.sphinx.conf  
[ ! -e $sphinx_config ] && echo Error: Not exists $sphinx_config ... && exit 1
echo ==Info: Installing init script for sphinx using config: $sphinx_config with rails env: $rails_env ... 

#pid_file = /home/cao/dev/tianji/tianjicom/log/searchd.development.pid
pid_file=$this_script_dir/../log/searchd.$rails_env.pid

#BUG TODO FIXME
sudo chmod o+w /etc/init.d
sudo cat >$init_sphinx_searchd <<InitStript 
#!/bin/bash
### BEGIN INIT INFO
# Provides:          searchd
# Required-Start:    \$local_fs \$remote_fs \$network \$syslog
# Required-Stop:     \$local_fs \$remote_fs \$network \$syslog
# Default-Start:     
# Default-Stop:      
# X-Interactive:     true
# Short-Description: Start/Stop/Restart searchd
### END INIT INFO

#Note: DONOT EDIT ME, I am Generated by autoboot_sphinx.sh(by cao, contact: http://shareup.me)

function user_do(){
  su -c "\$*" - $service_user
}

case "\${1:-}" in
  'start')
    # put the command to start sphinx
    # i.e., /usr/bin/searchd start or /usr/bin/searchd --daemon or whatever the command is
    user_do "$daemon_path --pidfile --config $sphinx_config"
    ;;
  'stop')
    # stop command here
    $daemon_path --stop --config $sphinx_config
    ;;
  'restart')
    # restart command here
    $daemon_path --stop --config $sphinx_config && $daemon_path --pidfile --config $sphinx_config
    ;;
  'status')
    $daemon_path --status --config $sphinx_config
    ;;
  'pid')
    cat $pid_file
    ;;
  *)
    echo "Usage: \$SELF start|stop|restart|status|pid"
    exit 1
    ;;
esac
InitStript
#BUG TODO FIXME
sudo chmod o-w /etc/init.d
echo ==Created a init script file in $init_sphinx_searchd ...

sudo chmod +x $init_sphinx_searchd
sudo update-rc.d $daemon_name defaults 

echo ==Congratulations! $daemon_name will auto running when start your machine with user: $service_user, go to sleep, z, z, Z, Z...
