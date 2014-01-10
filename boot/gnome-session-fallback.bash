#!/bin/bash

if which gnome-session-fallback >/dev/null ; then
  echo has set ...
else
  echo Ubuntu12.04+后默认使用Unity3D效果，不习惯，重设回Gnome桌面Classic模式
  sudo apt-get install gnome-session-fallback 
  echo 注销或登录时设为Gnome Classic模式即可！
fi
