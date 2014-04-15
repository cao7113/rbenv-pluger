Ref: http://surniaulula.com/2013/08/01/multiple-mongodb-instances-with-ubuntus-upstart/

## Features

* 使用ubuntu的upstart进行mongod多实例服务管理
* 兼容ubuntu安装包安装的单实例配置文件：/etc/mongodb.conf（不用删除，会自动启动，也可删除）
* 如想在系统启动时自动启动mongodb服务，需创建软链 /etc/init.d/mongodb -> /lib/init/upstart-job （包安装时已设置）

## 构建一个典型的MongoDB Recplica Set

members： primary + secondary + arbiter

Steps:

* setup upstart-based init script
* config replica set in /etc/mongodb.d/. ( mkdir mongodb data in var/lib/mongodb-cluster/* )
* restart mongodb service after configuration 
* config/connect replica set members in a mongo shell by `mongo --port 27027`:

```
rs.initiate()
rs.status()
rs.add('tjpc:27028')
rs.addArb('tjpc:27029')
rs.status()
```

ref info in http://localhost:28027
