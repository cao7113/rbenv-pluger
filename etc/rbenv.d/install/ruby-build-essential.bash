#hooks for ruby-build or rbenv install to compile rubies 
#ref: https://github.com/sstephenson/ruby-build/wiki/Definitions
script_dir=$(dirname $BASH_SOURCE)/../../../boot #echo $BASH_SOURCE != $0 #this is sourced

case "$OSTYPE" in
  darwin*) #mac
    before_install <<-Script
      #Mac OS X: If you have not done so, install Xcode Command Line Tools (xcode-select --install) and Homebrew. Then:
      # optional, but recommended:
      brew install openssl libyaml libffi
      # required for building Ruby <= 1.9.3-p0:
      # brew tap homebrew/dupes && brew install apple-gcc42
Script
    ;;
  linux*)  #ubuntu
    if [ ! -f ~/.ruby-built-essential ];then
      before_install "`cat $script_dir/ruby-build-essential`"
    else
      echo ==has install ruby-build-essential by flag file ~/.ruby-built-essential
    fi
    ;;
  *)
    if [ -z "$RUBY_BUILD_SKIP_ESSENTIAL" ];then
      echo Not support platform: $osinfo 
      echo You can add support in $BASH_SOURCE hook
      exit 1
    fi
    ;;
esac
