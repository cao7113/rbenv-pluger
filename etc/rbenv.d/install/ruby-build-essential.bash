#hooks for ruby-build or rbenv install to compile rubies 
osinfo=`uname -a`
if echo $osinfo|grep -iq ubuntu; then
  flag_file=~/.ruby-built-essential
  if [ ! -f $flag_file ];then
    before_install "
     echo ====running befor hook
     sudo apt-get install -y build-essential autoconf libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev
     exit 1"
    #touch $flag_file
  fi 
else
  if [ -z "$RUBY_BUILD_SKIP_ESSENTIAL" ];then
    echo Not support platform: $osinfo 
    echo You can add support in $0
    exit 1
  fi
fi
