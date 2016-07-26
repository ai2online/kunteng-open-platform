----



#### 关于坤腾开放平台

- 为坤腾路由设备提供插件编译平台（SDK）；


#### 支持设备型号：

- MT7620系：KunTeng9525、KunTeng ZC9526、 KunTeng ZC9527
- MT7621系：KunTeng9990、KunTeng9962
- MT7628系：KunTeng ZC9525A、KunTeng9762
- AR71XX系：KunTeng9661(原KunTeng-Foxconn 2010)、KunTeng9671

----

# Install

**注意，下面的操作指引旨在ubuntu发行版上的自动化SDK编译流程，ubuntu系发行版中可以使用`sudo apt-get install`命令直接安装，其他Linux发行版请按对应平台的安装命令，自行安装依赖库，依赖库包括但不限于(由于平台差异)以下lib及工具(以空格分隔)**

```
subversion build-essential libncurses5-dev zlib1g-dev 
gawk git ccache gettext libssl-dev xsltproc 
libxml-parser-perl gengetopt patch
```

#### 获取源码

    git clone https://github.com/kttec/kunteng-open-platform.git

#### 开始编译

1. 进入平台主目录

		cd kunteng-open-platform	

2. 选择需要编译的路由型号，这里以KunTeng-ZC9525为例

		cp ZC9525.config config_kt 
		
3. 编译profile，根据需求添加额外编译选项

		make menuconfig


4. 配置所需package(可以跳过，在`执行编译`时自动检查配置，但会比较耗时间，因此建议手动操作)

		git clone http://121.194.169.198:8888/root/openwrt-cc-dl.git openwrt/dl
		
5. 执行编译(自动检查CPU线程数，自动添加V、-j参数进行并发编译)

		make

# Others

#### Package创建

- Openwrt编译源码存放在git项目目录的`openwrt`文件夹下。
- 官方教程 [Openwrt简体中文wiki-创建软件包](https://wiki.openwrt.org/zh-cn/doc/devel/packages)
- example目录下提供了openwrt `helloworld` 的示例package代码，该示例代码的用法如下：

1. 进入kunteng-open-platform主目录；

2. 将helloworld示例package代码拷贝到openwrt对应packages目录，选择对应平台（以KT9661为例）：
![image](http://7xl7m7.com1.z0.glb.clouddn.com/sample.gif)
3. 执行`make menuconfig`，选择helloworld中的指定分类（示例代码为Utilities，可自行指定），选择helloworld：
![image](http://7xl7m7.com1.z0.glb.clouddn.com/sample2.gif)
4. 使用默认配置名config来保存配置（Save），退出make menuconfig界面（Exit），执行编译命令(make)：
![image](http://7xl7m7.com1.z0.glb.clouddn.com/sample3.gif)
5. 待编译结束后，固件中就包含我们的helloworld示例程序了。

- 说明：上面若第四步无gif图片显示，请点击4.下的空白，在单独的网页里查看。

#### Openwrt source

- 路由内核基于openwrt官方[源码chaos-calmer版本](https://git.openwrt.org/15.05/openwrt.git)；
- svn版本校验：git-svn-id: svn://svn.openwrt.org/openwrt/branches/chaos_calmer@47727 3c298f89-4303-0410-b956-a3cf2f4a3e73 

----


