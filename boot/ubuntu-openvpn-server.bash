#!/usr/bin/env bash 

#on digital ocean

echo ref https://github.com/Nyr/openvpn-install

echo run as root
echo sudo su -
echo wget git.io/vpn --no-check-certificate -O openvpn-install.sh; bash openvpn-install.sh

exit 0


==服务端安装

脚本很智能，不错

自动化配置ubuntu server
再次运行可以创建新的client
还可自己卸载，喜欢

且配置成了自启动的

sudo service openvpn status

生成的客户端为： abc.ovpn

== 客户端配置

在network-manager 中配置openvpn

将服务端给的abc.ovpn，分解成？

abc.ovpn
ca.crt
abc.crt
abc.key

network-manager可以导入abc.ovpn

其余的文件配置时指定位置

不用指定私钥密码

2015.7.28 测试访问facebook, twitter正常


命令行：
sudo openvpn --config ./abc.ovpn
