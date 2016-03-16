----

# Kunteng open platform


#### 关于坤腾开放平台

- 为坤腾路由设备提供插件编译平台；
- 路由内核基于openwrt官方[github源码chaos-calmer分支](https://github.com/openwrt/openwrt/tree/chaos_calmer)；


#### 支持设备型号：

- MT7620系：KunTeng9525、KunTeng ZC9526、 KunTeng ZC9527
- MT7628系：KunTeng ZC9525A

----

# Install

#### 获取源码

    git clone http://121.194.169.198:8888/gukaiqiang/kunteng-open-platform.git

#### 开始编译

1. 进入平台主目录

		cd kunteng-open-platform	

2. 选择需要编译的路由型号，这里以KunTeng-ZC9525为例

		cp ZC9525.config config_kt 
		
3. 编译profile，根据需求添加额外编译选项

		make menuconfig

4. 执行编译

		make


# Others

#### Package创建

[Openwrt简体中文wiki-创建软件包](https://wiki.openwrt.org/zh-cn/doc/devel/packages)
----


