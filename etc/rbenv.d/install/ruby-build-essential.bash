#hooks for ruby-build or rbenv install to compile rubies 
osinfo=`uname -a`
if echo $osinfo|grep -iq ubuntu; then
  sudo apt-get install -y build-essential autoconf libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev
  exit 1
  echo not here
else
  if [ -z "$RUBY_BUILD_SKIP_ESSENTIAL" ];then
    echo Not support platform: $osinfo 
    exit 1
  fi
fi
