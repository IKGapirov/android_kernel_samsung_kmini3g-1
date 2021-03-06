#Android makefile to build kernel as a part of Android Build
PERL		= perl

ifeq ($(TARGET_PREBUILT_KERNEL),)

KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
KERNEL_CONFIG := $(KERNEL_OUT)/.config
ifeq ($(TARGET_KERNEL_APPEND_DTB), true)
TARGET_PREBUILT_INT_KERNEL := $(KERNEL_OUT)/arch/arm/boot/zImage-dtb
else
TARGET_PREBUILT_INT_KERNEL := $(KERNEL_OUT)/arch/arm/boot/zImage
endif
KERNEL_HEADERS_INSTALL := $(KERNEL_OUT)/usr
KERNEL_MODULES_INSTALL := system
KERNEL_MODULES_OUT := $(TARGET_OUT)/lib/modules
KERNEL_IMG=$(KERNEL_OUT)/arch/arm/boot/Image

USE_MODULE ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MODULES=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))

DTS_NAMES ?= $(shell $(PERL) -e 'while (<>) {$$a = $$1 if /CONFIG_ARCH_((?:MSM|QSD|MPQ)[a-zA-Z0-9]+)=y/; $$r = $$1 if /CONFIG_MSM_SOC_REV_(?!NONE)(\w+)=y/; $$arch = $$arch.lc("$$a$$r ") if /CONFIG_ARCH_((?:MSM|QSD|MPQ)[a-zA-Z0-9]+)=y/} print $$arch;' $(KERNEL_CONFIG))
KERNEL_USE_OF ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_USE_OF=y/) { $$of = "y"; break; } } print $$of;' kernel/arch/arm/configs/$(KERNEL_DEFCONFIG))
LOCALE_KOR ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_LOCALE_KOR=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
LOCALE_JPN ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_LOCALE_JPN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
JS_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_JS_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
JS_TW_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_JS01LTEZT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
LOCALE_CHN_DUOS ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_H3GDUOS=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
K_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_K_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
S_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_S_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
PATEK_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_PATEK_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
H_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_H_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
FRESCO_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_FRESCO_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
F_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_F_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MONDRIAN_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_MONDRIAN_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
VIENNA_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_VIENNA_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
LT03_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_LT03_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MILLET3G_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MILLET3G_EUR=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MILLET3G_CHN_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MILLET3G_CHN_OPEN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MILLETLTE_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MILLETLTE_OPEN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MILLETLTE_ATT_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MILLETLTE_ATT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MILLETLTE_CAN_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MILLETLTE_CAN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MILLETLTE_TMO_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MILLETLTE_TMO=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MILLETLTE_VZW_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MILLETLTE_VZW=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MILLETLTE_KOR_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MILLETLTE_KOR=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MILLETWIFI_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_MILLETWIFI_COMMON=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MATISSE3G_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MATISSE3G_OPEN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MATISSEWIFI_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_MATISSEWIFI_COMMON=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MATISSELTE_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MATISSELTE_OPEN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MATISSELTE_ATT_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MATISSELTE_ATT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MATISSELTE_VZW_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MATISSELTE_VZW=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MATISSELTE_USC_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_MATISSELTE_USC=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
AFYONLTE_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_AFYONLTE_COMMON=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
ATLANTICLTE_ATT_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_ATLANTICLTE_ATT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
ATLANTICLTE_VZW_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_ATLANTICLTE_VZW=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
ATLANTIC3G_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_ATLANTIC3G_COMMON=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
ATLANTICLTE_USC_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_ATLANTICLTE_USC=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
PICASSO_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_PICASSO_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
CHAGALL_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_CHAGALL_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
KLIMT_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_KLIMT_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
V2_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_V2_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
KS01_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_KS01_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
JACTIVE_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_JACTIVE_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
KACTIVE_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_KACTIVE_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
HEAT_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_HEAT_PROJECT=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
BERLUTI3G_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_BERLUTI3G_EUR=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
BERLUTILTE_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_BERLUTILTE_EUR=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
GNOTEDS_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_BERLUTILTE_EUR=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
HEAT_DYN_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_HEAT_DYN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
HEAT_AIO_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_HEAT_AIO=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
VICTORLTE_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_VICTORLTE=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
VASTALTE_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_VASTALTE=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
FRESCONEOLTE_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_FRESCONEOLTE_CTC=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
KANAS3G_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_KANAS3G=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
KANAS3G_CMCC_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_KANAS3G_CMCC=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
KANAS3G_CTC_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_KANAS3G_CTC=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
DEGASLTE_SPR_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_DEGASLTE_SPR=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
MEGA23G_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_SEC_MEGA23G_COMMON=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
GNOTELTEDS_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_GNOTELTEDS_OPEN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
T10_3G_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_T10_3G_OPEN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
T8_3G_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_T8_3G_OPEN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))
T10_WIFI_PROJECT ?= $(shell $(PERL) -e '$$of = "n"; while (<>) { if (/CONFIG_MACH_T10_WIFI_OPEN=y/) { $$of = "y"; break; } } print $$of;' $(KERNEL_CONFIG))

ifeq "$(KERNEL_USE_OF)" "y"
DTS_FILES = $(wildcard $(TOP)/kernel/arch/arm/boot/dts/$(DTS_NAME)*.dts)
DTS_FILE = $(lastword $(subst /, ,$(1)))
DTB_FILE = $(addprefix $(KERNEL_OUT)/arch/arm/boot/,$(patsubst %.dts,%.dtb,$(call DTS_FILE,$(1))))
ZIMG_FILE = $(addprefix $(KERNEL_OUT)/arch/arm/boot/,$(patsubst %.dts,%-zImage,$(call DTS_FILE,$(1))))
KERNEL_ZIMG = $(KERNEL_OUT)/arch/arm/boot/zImage
DTC = $(KERNEL_OUT)/scripts/dtc/dtc

define append-dtb
mkdir -p $(KERNEL_OUT)/arch/arm/boot;\
$(foreach DTS_NAME, $(DTS_NAMES), \
   $(foreach d, $(DTS_FILES), \
      $(DTC) -p 1024 -O dtb -o $(call DTB_FILE,$(d)) $(d); \
      cat $(KERNEL_ZIMG) $(call DTB_FILE,$(d)) > $(call ZIMG_FILE,$(d));))
endef
else

define append-dtb
endef
endif

ifeq ($(TARGET_USES_UNCOMPRESSED_KERNEL),true)
$(info Using uncompressed kernel)
TARGET_PREBUILT_KERNEL := $(KERNEL_OUT)/piggy
else
TARGET_PREBUILT_KERNEL := $(TARGET_PREBUILT_INT_KERNEL)
endif

define mv-modules
mdpath=`find $(KERNEL_MODULES_OUT) -type f -name modules.dep`;\
if [ "$$mdpath" != "" ];then\
mpath=`dirname $$mdpath`;\
ko=`find $$mpath/kernel -type f -name *.ko`;\
for i in $$ko; do mv $$i $(KERNEL_MODULES_OUT)/; done;\
fi
endef

define clean-module-folder
mdpath=`find $(KERNEL_MODULES_OUT) -type f -name modules.dep`;\
if [ "$$mdpath" != "" ];then\
mpath=`dirname $$mdpath`; rm -rf $$mpath;\
fi
endef

#Tweak defconfig for FACTORY KERNEL without additional fac_defcofig
define modi-facdefconfig
cp kernel/arch/arm/configs/$(KERNEL_DEFCONFIG) kernel/arch/arm/configs/factory_defconfig
echo -e "\nCONFIG_SEC_FACTORY=y" >> kernel/arch/arm/configs/factory_defconfig
endef

$(KERNEL_OUT):
	mkdir -p $(KERNEL_OUT)

$(KERNEL_CONFIG): $(KERNEL_OUT)
ifeq ($(SEC_FACTORY_BUILD),true)
	$(modi-facdefconfig)
	$(MAKE) -C kernel O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=arm-eabi- VARIANT_DEFCONFIG=$(VARIANT_DEFCONFIG) DEBUG_DEFCONFIG=$(DEBUG_DEFCONFIG) SELINUX_DEFCONFIG=$(SELINUX_DEFCONFIG) SELINUX_LOG_DEFCONFIG=$(SELINUX_LOG_DEFCONFIG) factory_defconfig TIMA_DEFCONFIG=$(TIMA_DEFCONFIG)
else
	$(MAKE) -C kernel O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=arm-eabi- VARIANT_DEFCONFIG=$(VARIANT_DEFCONFIG) DEBUG_DEFCONFIG=$(DEBUG_DEFCONFIG) SELINUX_DEFCONFIG=$(SELINUX_DEFCONFIG) SELINUX_LOG_DEFCONFIG=$(SELINUX_LOG_DEFCONFIG) $(KERNEL_DEFCONFIG) TIMA_DEFCONFIG=$(TIMA_DEFCONFIG)
endif
$(KERNEL_OUT)/piggy : $(TARGET_PREBUILT_INT_KERNEL)
	$(hide) gunzip -c $(KERNEL_OUT)/arch/arm/boot/compressed/piggy.gzip > $(KERNEL_OUT)/piggy

$(TARGET_PREBUILT_INT_KERNEL): $(KERNEL_OUT) $(KERNEL_CONFIG) $(KERNEL_HEADERS_INSTALL)
	$(MAKE) -C kernel O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=arm-eabi-
ifeq "$(USE_MODULE)" "y"
	$(MAKE) -C kernel O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=arm-eabi- modules
	$(MAKE) -C kernel O=../$(KERNEL_OUT) INSTALL_MOD_PATH=../../$(KERNEL_MODULES_INSTALL) INSTALL_MOD_STRIP=1 ARCH=arm CROSS_COMPILE=arm-eabi- modules_install
	$(mv-modules)
	$(clean-module-folder)
endif
	$(append-dtb)

$(KERNEL_HEADERS_INSTALL): $(KERNEL_OUT) $(KERNEL_CONFIG)
	$(MAKE) -C kernel O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=arm-eabi- headers_install

kerneltags: $(KERNEL_OUT) $(KERNEL_CONFIG)
	$(MAKE) -C kernel O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=arm-eabi- tags

kernelconfig: $(KERNEL_OUT) $(KERNEL_CONFIG)
	env KCONFIG_NOTIMESTAMP=true \
	     $(MAKE) -C kernel O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=arm-eabi- menuconfig
	env KCONFIG_NOTIMESTAMP=true \
	     $(MAKE) -C kernel O=../$(KERNEL_OUT) ARCH=arm CROSS_COMPILE=arm-eabi- savedefconfig
	cp $(KERNEL_OUT)/defconfig kernel/arch/arm/configs/$(KERNEL_DEFCONFIG)

endif
