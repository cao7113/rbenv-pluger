Ref: http://surniaulula.com/2013/08/01/multiple-mongodb-instances-with-ubuntus-upstart/

* 使用ubuntu的upstart进行mongod实例服务管理
* 兼容默认包安装时的单实例配置文件：/etc/mongdb.conf
* 如想系统启动时启动mongo服务，需创建软链接/etc/init.d/mongodb -> /lib/init/upstart-job
