# kunteng openwrt platform for openwrt
# created @ 2015-03-15
DEPEND_PKGS := subversion build-essential \
      libncurses5-dev zlib1g-dev gawk git ccache \
      gettext libssl-dev xsltproc libxml-parser-perl gengetopt
OPENWRT := openwrt_src
KTOP_ROOT := $(shell pwd)
CONFIG_FILENAME := config_kt

RUNNING_THREADS := $(shell cat /proc/cpuinfo | grep -i '^processor\s\+:' | wc -l)

define rely_check
# check openwrt-chaos_calmer source from github 
	@[ -d $(OPENWRT) ] && : || \
	git clone -b chaos_calmer https://github.com/openwrt/openwrt.git $(OPENWRT)
	
endef

define hostdepends
# Install required host components
	@which dpkg >/dev/null 2>&1 || exit 0; \
	for p in $(DEPEND_PKGS); do \
		dpkg -s $$p >/dev/null 2>&1 || to_install="$$to_install$$p "; \
	done; \
	if [ -n "$$to_install" ]; then \
		echo "Please install missing packages by running the following commands:"; \
		echo "  sudo apt-get update"; \
		echo "  sudo apt-get install $$to_install"; \
		exit 1; \
	fi;
endef

define do_patching
# patch kunteng routers on openwrt
	cd $(OPENWRT); \
	patch -f -p0 < ../patches/01_kt_open_platform.patch
endef


define config_check
# check kunteng default config
	@if [ ! -e $(OPENWRT)/.config ]; then \
		if [ ! -e $(CONFIG_FILENAME) ]; then \
			echo "*** configuration file:'$(CONFIG_FILENAME)' and '.config' missing, you need to specify a defaultconfiguration file named '$(CONFIG_FILENAME)'";\
			exit 1;\
		else \
			cp $(CONFIG_FILENAME) $(OPENWRT)/.config; \
		fi; \
	fi;
endef

kt_router: .kt_config_check
	make -C $(OPENWRT) V=s -j$(RUNNING_THREADS)

.kt_config_check:.kt_patched
	$(call config_check)
	touch .kt_config_check

.kt_patched: .kt_check_openwrt_source
	$(call do_patching)
	@touch .kt_patched

.kt_check_openwrt_source:
	$(call hostdepends)
	$(call rely_check)
	@touch .kt_check_openwrt_source
	
	
menuconfig: .kt_config_check
	@cd $(OPENWRT); [ -f .config ] && cp .config .config.bak || :
	@cp -vf $(CONFIG_FILENAME) $(OPENWRT)/.config
	@touch $(CONFIG_FILENAME)  # change modification time
	@make -C $(OPENWRT) menuconfig
	
clean:
	make clean -C recovery.bin
	make clean -C $(OPENWRT) V=s
