#BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
#ALLOW_MISSING_DEPENDENCIES := true

# Disable sparse on all filesystem images
TARGET_USERIMAGES_SPARSE_EROFS_DISABLED := false
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
TARGET_USERIMAGES_SPARSE_F2FS_DISABLED := false
TARGET_USERIMAGES_SPARSE_SQUASHFS_DISABLED := false

# Kernel
#TARGET_KERNEL_ARCH := arm64
#TARGET_KERNEL_HEADER_ARCH := arm64
#TARGET_KERNEL_SOURCE := kernel/allwinner/linux-5.4
#TARGET_KERNEL_CONFIG := sun50iw9p1smp_h618_android_defconfig
#TARGET_PREBUILT_KERNEL := $(PRODUCT_PREBUILT_PATH)/bImage
BOARD_KERNEL_IMAGE_NAME := bImage

include device/softwinner/common/BoardConfigCommon.mk
include device/softwinner/apollo/BoardConfig.mk

# must include common BoardConfig.mk in the end
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_CMDLINE += androidboot.dtbo_idx=0,1,2
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/etc/firmware


# wifi and bt configuration
# 1. Wifi Configuration
BOARD_WIFI_VENDOR := common
BOARD_USR_WIFI    :=
WIFI_DRIVER_MODULE_PATH :=
WIFI_DRIVER_MODULE_NAME :=
WIFI_DRIVER_MODULE_ARG  :=

# 2. Bluetooth Configuration
BOARD_BLUETOOTH_VENDOR    := common
BOARD_HAVE_BLUETOOTH_NAME :=
BOARD_BLUETOOTH_CONFIG_DIR := device/softwinner/apollo/common/wireless/bluetooth
BOARD_BLUETOOTH_TTY := /dev/ttyAS1
# Must include after wifi/bt configuration
include device/softwinner/common/config/wireless/wireless_config.mk
