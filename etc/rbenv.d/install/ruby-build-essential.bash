#hooks for ruby-build or rbenv install to compile rubies 
#ref: https://github.com/sstephenson/ruby-build/wiki/Definitions
osinfo=`uname -a`
script_dir=$(dirname $BASH_SOURCE)/../../../boot #echo $BASH_SOURCE != $0 #this is sourced
if echo $osinfo|grep -iq ubuntu; then
  if [ ! -f ~/.ruby-built-essential ];then
    before_install "`cat $script_dir/ruby-build-essential`"
  else
    echo ==has install ruby-build-essential by flag file ~/.ruby-built-essential
  fi
else
  if [ -z "$RUBY_BUILD_SKIP_ESSENTIAL" ];then
    echo Not support platform: $osinfo 
    echo You can add support in $BASH_SOURCE hook
    exit 1
  fi
fi
