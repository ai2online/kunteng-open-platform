----

# Kunteng open platform


#### 关于坤腾开放平台

- 为坤腾路由设备提供插件编译平台；
- 路由内核基于openwrt官方[源码chaos-calmer版本](https://git.openwrt.org/15.05/openwrt.git)，svn版本：git-svn-id: svn://svn.openwrt.org/openwrt/branches/chaos_calmer@47727 3c298f89-4303-0410-b956-a3cf2f4a3e73 


#### 支持设备型号：

- MT7620系：KunTeng9525、KunTeng ZC9526、 KunTeng ZC9527
- MT7621系：KunTeng9990、KunTeng9962
- MT7628系：KunTeng ZC9525A、KT9762
- AR71XX系：KT9661(原KunTeng-Foxconn 2010)、KT9671

----

# Install

**注意，下面的操作指引旨在ubuntu发行版上的自动化SDK编译流程，其他Linux发行版请按对应平台的安装命令，自行安装依赖库，依赖库包括但不限于(由于平台差异)以下lib及工具(以空格分隔)**

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

		git clone git@121.194.169.198:root/openwrt-cc-dl.git opnewrt/dl
		
5. 执行编译(自动检查CPU线程数，自动添加V、-j参数进行并发编译)

		make

# Others

#### Package创建

[Openwrt简体中文wiki-创建软件包](https://wiki.openwrt.org/zh-cn/doc/devel/packages)

#### Openwrt source

openwrt源码版本：`r47727`

----


